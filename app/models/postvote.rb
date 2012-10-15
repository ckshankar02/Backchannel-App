class Postvote < ActiveRecord::Base
  attr_accessible :time, :user, :post

  belongs_to :user
  belongs_to :post
end
