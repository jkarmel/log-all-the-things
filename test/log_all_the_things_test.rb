require 'test_helper'




class TestController < ActionController::Base
  def do_nothing
    render text: 'hi'
  end

  def call_method_that_fires_event
    Code.method_that_fires_event
    render text: 'hi'
  end
end

class Code
  def self.method_that_fires_event
    Event.publish({data: 1})
  end
end

Rails.application.routes.draw do
  get 'do_nothing', to: 'test#do_nothing'
  get 'call_method_that_fires_event', to: 'test#call_method_that_fires_event'
end

class LogAllTheThingsTest < Minitest::Test
  class RequestTest < ActionController::TestCase
    def setup
      @controller = TestController.new
    end

    test "it logs a request when one is made" do
      assert_difference ->{Request.count} do
        get :do_nothing
      end
    end

    test "requests have cookied devices" do
      get :do_nothing
      assert_not_nil Request.first.browser
    end

    test "when two requests are made they have references to the same cookied devices" do
      get :do_nothing
      get :do_nothing
      assert_equal Request.first.browser, Request.last.browser
    end
  end

  class EventTest < ActionController::TestCase
    def setup
      @controller = TestController.new
    end

    test "events fired from a method called within a controller contain the request id" do
      get :call_method_that_fires_event
      assert_equal Event.first.request, Request.first
    end

  end
end
