class PlaylistSong < ApplicationRecord
  self.table_name = "playlists_songs"
  belongs_to :playlist
  belongs_to :song

end