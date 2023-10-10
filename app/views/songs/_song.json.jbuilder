json.extract! song, :id, :name, :description, :length, :created_at, :updated_at, :user_id
json.user_full_name song.user.full_name
json.url song_url(song, format: :json)
json.mp3_url song.mp3.url
