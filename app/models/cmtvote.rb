class Cmtvote < ActiveRecord::Base
  attr_accessible :user, :post, :comment, :time

  belongs_to :user        #one user can vote for many comment. But only once for a post
  belongs_to :post
  belongs_to :comment
end
