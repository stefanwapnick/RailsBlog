require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  #Setup called before each test
  def setup
    @category = Category.new(name: 'sports')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test 'name should be present' do
    @category.name = ' '
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    category2 = Category.new(name: 'sports')
    assert_not category2.valid?
  end

  test 'name correct length' do

    @category.name = 'a' * 26     # Must not be too long
    assert_not @category.valid?

    @category.name = 'aa'         # Must not be too short
    assert_not @category.valid?

    @category.name = 'aaa'       # test min length = 3 valid
    assert @category.valid?
  end

end