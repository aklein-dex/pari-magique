require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Pari-magique"
    @member = users(:member1)
  end

  test "should get home when user not logged in" do
    get root_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
  end

  test "should get rules" do
    get rules_url
    assert_response :success
    assert_select "title", "Rules | #{@base_title}"
  end

  test "should get home when user is logged in" do
    sign_in @member
    get static_pages_home_url
    assert_response :success
    assert_select "a[href=?]", new_user_registration_path, false, "This page must not contain a sign up link"
    assert_select "a[href=?]", new_user_session_path, false, "This page must not contain a sign in link"
  end
end