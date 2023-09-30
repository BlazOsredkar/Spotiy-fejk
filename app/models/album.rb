class Album < ApplicationRecord
    has_and_belongs_to_many :artists, join_table: :albums_artists, class_name: 'User'
end
