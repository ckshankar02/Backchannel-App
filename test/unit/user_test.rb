require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "the truth" do
    assert true
   end
   test "should not save post without username" do
     #presence of user name
     post = Post.new
     assert !post.save
   end
   test "should not save user without lastname" do
     #presence of last name
     post = Post.new
     assert !post.save
   end
   test "should not save user  without firstname" do
     #presence of first name
     post = Post.new
     assert !post.save
   end
   test "should not save user without email" do
     #presence of email
     post = Post.new
     assert !post.save
   end
   test "should not save user without password" do
     #presence of password
     post = Post.new
     assert !post.save
   end


   test "given a user named gopi with a password of 1234, he should be authenticated with 'gopi' and '1234' " do
     User.create(:username => "gopi",
                 :email =>"gns_gopi@yahoo.co.in",
                 :password => "1234",
                 :password_confirmation => "1234",
                 :firstname => "gopi",
                 :lastname  => "gopi"
     )
     assert User.authenticate("gopi","1234")
   end
end
