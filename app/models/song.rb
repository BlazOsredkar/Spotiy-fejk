class Song < ApplicationRecord
    has_one_attached :mp3
    has_one_attached :image
    belongs_to :user
    validates_presence_of :user
end
