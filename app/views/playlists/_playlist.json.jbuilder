json.extract! playlist, :id, :name, :cover_image, :privacy, :created_at, :updated_at
json.url playlist_url(playlist, format: :json)
