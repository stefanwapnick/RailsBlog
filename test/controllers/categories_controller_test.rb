require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  def setup
    @category = Category.create(name: 'sports')
  end

  test 'should get categories index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    @user = User.create(username: 'john', email: 'john@test.com', password: 'password', admin: true)
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test 'should get show' do
    get(:show, {'id' => @category.id})
    assert_response :success
  end

end