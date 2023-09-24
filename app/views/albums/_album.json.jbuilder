json.extract! album, :id, :name, :description, :year, :created_at, :updated_at
json.url album_url(album, format: :json)
