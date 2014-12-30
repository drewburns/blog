class Tag < ActiveRecord::Base
  has_many :relationships
  has_many :posts , through: :relationships

  validates :name , presence: true
end
