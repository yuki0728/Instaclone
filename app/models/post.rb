class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :img, ImageUploader
end
