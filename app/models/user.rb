class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :anonymous, :image_url, :subscribe
  # attr_accessible :title, :body
  
  validates :name, uniqueness: true, allow_nil: true
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
