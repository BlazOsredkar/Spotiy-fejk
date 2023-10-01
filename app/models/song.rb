class Song < ApplicationRecord
    has_one_attached :mp3
    has_one_attached :image
    belongs_to :user
    validates_presence_of :user
    has_many :playlist_songs
    has_many :playlists, through: :playlist_songs
end
