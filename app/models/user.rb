class User < ActiveRecord::Base
  attr_accessible :username,:firstname, :lastname,:email, :password,:password_confirmation
  validates   :lastname ,:presence => true
  validates  :firstname, :presence => true
  validates  :username, :presence => true , :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}
  validates_format_of :email, :with => /^.+@.+\..+$/, :on => :create
  validates  :password, :presence => true
  validates :password, :confirmation => true

  def self.authenticate username, password
    user = find_by_username username
    if user && user.password == password
      user
    else
      false
    end
  end

  has_many :posts
  has_many :comments
  has_many :postvotes
  has_many :cmtvotes
end
