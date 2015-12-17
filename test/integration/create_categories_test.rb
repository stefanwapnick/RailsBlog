require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'john', email: 'john@test.com', password: 'password', admin: true)
    sign_in_as(@user, 'password')
  end

  test 'get new category form and create category' do
    get new_category_path                 # check that path exists
    assert_template 'categories/new'      # assert that template exists

    # Assert that 1 new category added
    assert_difference 'Category.count', 1 do
       post_via_redirect categories_path, category: {name: 'sports'}
    end

    assert_template 'categories/index'
    assert_match 'sports', response.body

  end


  test 'invalid category submission' do

    get new_category_path                 # send get request to category_path
    assert_template 'categories/new'      # assert correct template

    # Post invalid category and check that no change in DB
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ' '}
    end

    assert_template 'categories/new'                # check that sent back to categories/new template
    assert_select 'div.panel-heading'               # check that the following two classes are in layout since these are part of error window
    assert_select 'h3.panel-title'

  end

end