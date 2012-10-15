require 'test_helper'

class PostTest < ActiveSupport::TestCase
  fixtures :posts, :users

  test "the truth" do
    assert true
  end
  test "should not save post without title" do
    #presence of title
    post = Post.new
    assert !post.save
  end
  test "should not save post without category" do
    #presence of  category
    post = Post.new
    assert !post.save
  end
  test "should not save post without time" do
    #presence of time
    post = Post.new
    assert !post.save
  end
  test "should not save post without content" do
    #presence of content
    post = Post.new
    assert !post.save
  end
  def setup
    @post3 = posts(:three)
    @user3 = users(:three)
    @post4 = posts (:four)
  end
  def test_relationships
    # belongs_to :user
    assert_equal(3, @post3.user_id)
    assert_equal(3, @post3.user.id)
  end

  def test_relationships
    # user has_many :posts

    assert_equal([3,3], @user3.posts.collect {|u| u.user_id })
    assert_equal(2, @user3.posts.count)

  end



end
