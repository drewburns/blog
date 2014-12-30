class Post < ActiveRecord::Base
  has_many :relationships
  has_many :tags , through: :relationships
  belongs_to :user
  
  validates :title , presence: true
  validates :body , presence: true
end
