require "test_helper"

class Public::SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_songs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_songs_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_songs_edit_url
    assert_response :success
  end
end
