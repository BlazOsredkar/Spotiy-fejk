class Playlist < ApplicationRecord
    belongs_to :user

    def self.ransackable_attributes(auth_object = nil)
        ["cover_image", "created_at", "id", "name", "privacy", "updated_at", "user_id"]
    end
end
