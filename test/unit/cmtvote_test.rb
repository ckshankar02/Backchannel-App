require 'test_helper'

class CmtvoteTest < ActiveSupport::TestCase
  fixtures :users, :cmtvotes , :posts, :comments


   test "the truth" do
     assert true
   end
  def setup
    @cmtvotes1 = cmtvotes(:one)
    @comments1 = comments(:one)
    @user3 = users(:three)
    @post3 = posts(:three)
  end
  def test_relationships
    # cmtvotes  belongs_to :user
    assert_equal(3, @cmtvotes1.user_id)
    assert_equal(3, @cmtvotes1.user.id)
  end
  def test_relationships
    # cmtvotes  belongs_to :posts
    assert_equal(3, @cmtvotes1.post_id)
    assert_equal(3, @cmtvotes1.post.id)
  end

  def test_relationships
    # cmtvotes  belongs_to :comments
    assert_equal(3, @comments1.user_id)
    assert_equal(3, @comments1.user.id)
  end


end
