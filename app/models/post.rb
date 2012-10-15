class Post < ActiveRecord::Base
  attr_accessible :title, :content, :time, :category, :user
  validates   :title ,:presence => true
  validates   :content ,:presence => true
  validates   :category ,:presence => true

  belongs_to :user
  has_many :comments, :dependent => :destroy    #Dependent destroy when a post is deleted all the comments made on it gets deleted
  has_many :postvotes, :dependent => :destroy
  has_many :cmtvotes, :dependent => :destroy
end
