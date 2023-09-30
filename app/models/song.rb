class Song < ApplicationRecord
    has_one_attached :mp3
    has_one_attached :image
    belongs_to :user
    validates_presence_of :user
    has_and_belongs_to_many :playlists, join_table: :playlists_songs
end
