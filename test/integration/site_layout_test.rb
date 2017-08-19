require 'test_helper'

# rails generate test_unit:integration site_layout


class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Pari-magique"
    @user = users(:user1)
  end

  test "layout links for non-login users" do
    get root_path
    assert_template 'static_pages/root'
    assert_select "title", "Home | #{@base_title}"
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", admin_teams_path, false, "This page must not contain a sign up link"
    assert_select "a[href=?]", admin_tournaments_path, false, "This page must not contain a sign up link"
  end

  test "layout links for normal users" do
    sign_in @user
    get static_pages_home_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", new_user_registration_path, false, "This page must not contain a sign up link"
    assert_select "a[href=?]", new_user_session_path, false, "This page must not contain a sign in link"
    assert_select "a[href=?]", admin_teams_path, false, "This page must not contain a teams link"
    assert_select "a[href=?]", admin_leagues_path, false, "This page must not contain a leagues link"
    assert_select "a[href=?]", admin_tournaments_path, false, "This page must not contain a tournament link"
    assert_select "a[href=?]", manager_games_path, false, "This page must not contain a game link"
  end

  test "layout links for admin users" do
    @admin = users(:admin)
    sign_in @admin
    get static_pages_home_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", admin_teams_path
    assert_select "a[href=?]", admin_leagues_path
    assert_select "a[href=?]", admin_tournaments_path
    assert_select "a[href=?]", manager_games_path
    assert_select "a[href=?]", new_user_registration_path, false, "This page must not contain a sign up link"
    assert_select "a[href=?]", new_user_session_path, false, "This page must not contain a sign in link"
  end

  test "layout links for manager users" do
    @manager = users(:manager)
    sign_in @manager
    get static_pages_home_url
    assert_template 'static_pages/home'
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", manager_games_path
    assert_select "a[href=?]", admin_teams_path, false, "This page must not contain a teams link"
    assert_select "a[href=?]", admin_leagues_path, false, "This page must not contain a leagues link"
    assert_select "a[href=?]", admin_tournaments_path, false, "This page must not contain a tournament link"
    assert_select "a[href=?]", new_user_registration_path, false, "This page must not contain a sign up link"
    assert_select "a[href=?]", new_user_session_path, false, "This page must not contain a sign in link"
  end
end
