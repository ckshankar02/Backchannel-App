require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :posts, :comments  ,:users
  def setup
    @comments2 = comments(:two)
    @comments1 = comments(:one)
    @post3 = posts (:three)
    @user3 = posts (:three)
  end
  def test_relationships
    # belongs_to :post
    assert_equal(3, @comments1.post_id)
    assert_equal(3, @comments1.post.id)
  end

  def test_relationships
    # post has_many :comments

    assert_equal([3,3], @post3.comments.collect {|u| u.user_id })
    assert_equal(2, @post3.comments.count)

  end

  def test_relationships
    # belongs_to :user
    assert_equal(3, @comments1.user_id)
    assert_equal(3, @comments1.user.id)
  end

  def test_relationships
    # user has_many :comments

    assert_equal([3,3], @user3.comments.collect {|u| u.user_id })
    assert_equal(2, @user3.comments.count)

  end



end
