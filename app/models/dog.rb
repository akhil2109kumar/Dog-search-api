class Dog < ApplicationRecord
	validates :breed, presence: true
	validates :image_url, presence: true
end
