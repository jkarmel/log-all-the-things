require 'test_helper'

class TestController < ActionController::Base
  def index
    render text: 'hi'
  end
end

class LogAllTheThingsTest < ActionController::TestCase
  def setup
    Rails.application.routes.draw do
      root to: 'test#index'
    end

    @controller = TestController.new
  end

  test "it logs a request when one is made" do
    assert_difference ->{Request.count} do
      get :index
    end
  end

  test "requests have cookied devices" do
    get :index
    assert_not_nil Request.first.cookied_browser
  end

  test "when two requests are made they have references to the same cookied devices" do
    get :index
    get :index
    assert_equal Request.first.cookied_browser, Request.last.cookied_browser
  end

end
