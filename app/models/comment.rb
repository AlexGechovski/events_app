class Comment < ApplicationRecord
    belongs_to :event
    belongs_to :user
    after_create_commit {broadcast_append_to "comments"}
end
