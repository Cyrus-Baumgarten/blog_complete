class Post < ActiveRecord::Base
  attr_accessible :body, :commenting, :title, :user_id
  
  validates :body,  presence: true
  validates :title, presence: true, uniqueness: true
  
  default_scope order('created_at desc')
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  
end
