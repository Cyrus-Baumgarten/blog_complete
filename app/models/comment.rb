class Comment < ActiveRecord::Base
  attr_accessible :body, :post_id, :user_id
  
  validates :body,  presence: true, length: { maximum: 160 }  
  
  belongs_to :user
  belongs_to :post
  
end
