class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  validates :content, presence: true, length: { maximum: 400 }
end
