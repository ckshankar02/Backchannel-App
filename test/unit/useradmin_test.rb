require 'test_helper'

class UseradminTest < ActiveSupport::TestCase
  fixtures :useradmins, :users
  # test "the truth" do
  #   assert true
  # end

  def setup
    @useradmin3 = useradmins(:useradmin3)
    @user3 = users(:three)
  end
  def test_relationships
    # admin  belongs_to :user
    assert_equal(3, @useradmin3.user_id)
    assert_equal(3, @useradmin3.user.id)
  end

end
