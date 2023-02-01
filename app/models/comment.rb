class Comment < ApplicationRecord
    belongs_to :event
    belongs_to :user
    validates :text , presence: true , length: { in: 1..250 }

    after_create_commit do
        puts "Broadcasting to: comments_#{self.event_id}"
        broadcast_prepend_to "comments_#{self.event_id}" , target: "comments_#{self.event_id}", partial: "comments/comment", locals: { comment: self }
      end
    
      after_update_commit do
        puts "Broadcasting to: comments_#{self.event_id}"
        broadcast_replace_to "comments_#{self.event_id}" , target: "comments_#{self.event_id}", partial: "comments/comment", locals: { comment: self }
      end
    
      after_destroy_commit do
        puts "Broadcasting to: comments_#{self.event_id}"
        broadcast_remove_to "comments_#{self.event_id}" , target: "comments_#{self.event_id}"  , locals: { comment: self }
      end

    # after_create_commit {broadcast_prepend_to  "comments_#{event_id}"}
    # after_update_commit {broadcast_replace_to "comments"}
    # after_destroy_commit {broadcast_remove_to "comments"}
end
