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
end
