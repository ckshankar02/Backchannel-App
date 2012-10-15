require 'test_helper'

class PostvoteTest < ActiveSupport::TestCase
  fixtures :users, :postvotes , :posts


  test "the truth" do
    assert true
  end
  def setup
    @postvotes1 = postvotes(:one)
    @user3 = users(:three)
    @post3 = posts(:three)
  end
  def test_relationships
    # postvotes belongs_to :user
    assert_equal(3, @postvotes1.user_id)
    assert_equal(3, @postvotes1.user.id)
  end
  def test_relationships
    # postvotes  belongs_to :posts
    assert_equal(3, @postvotes1.post_id)
    assert_equal(3, @postvotes1.post.id)
  end
end
