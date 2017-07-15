require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Pari-magique"
  end

  test "should get home when user not logged in" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get rules" do
    get rules_url
    assert_response :success
    assert_select "title", "Rules | #{@base_title}"
  end
end