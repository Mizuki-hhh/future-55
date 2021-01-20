class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :content

  # validates_uniqueness_of :content_id, scop: :user_id
end
