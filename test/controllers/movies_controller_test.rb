require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/"
    assert_response :success
  end
  test "should get recommendations" do
    get "/movies/recommendations?user_id=1"
    assert_response :success
  end
  test "should get user rented" do
    get "/movies/user_rented_movies?user_id=1"
    assert_response :success
  end
  test "should rent a movie" do
    get "/movies/1/rent?user_id=1"
    assert_response :success
  end
  test "should rent the same movie twice" do
    get "/movies/1/rent?user_id=1"
    assert_response :success
    get "/movies/1/rent?user_id=1"
    assert_response :success
  end
  test "should not rent a movie if there are no available copies" do
    @movie = Movie.where(available_copies: 1).first
    get "/movies/#{@movie.id}/rent?user_id=1"
    assert_response :success
    get "/movies/#{@movie.id}/rent?user_id=1"
    assert_response :bad_request
  end
end
