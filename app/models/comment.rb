class Comment < ActiveRecord::Base
  attr_accessible :content, :time, :user, :post

  validates   :content ,:presence => true

  belongs_to :user        #one user can comment on various posts once.
  belongs_to :post        #there can be more than one comment for a post.
  has_many :cmtvotes, :dependent => :destroy          #many votes can be on a comment
end
