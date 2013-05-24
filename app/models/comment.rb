class Comment < ActiveRecord::Base
  attr_accessible :body, :post_id, :user_id
    
  belongs_to :user
  belongs_to :post
  
  default_scope order('created_at desc')
  
  validates :body, presence: true, length: { maximum: 160 } 
  
end
