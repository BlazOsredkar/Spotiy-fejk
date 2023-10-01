json.extract! song, :id, :name, :description, :length, :created_at, :updated_at
json.url song_url(song, format: :json)
json.mp3_url song.mp3.url
