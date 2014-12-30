class User < ActiveRecord::Base
	has_many :posts
  validates :title , presence: true , uniqueness: true
end
