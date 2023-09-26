class Song < ApplicationRecord
    has_one_attached :mp3
    has_one_attached :image
end
