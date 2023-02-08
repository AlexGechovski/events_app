class Comment < ApplicationRecord
    belongs_to :event
    belongs_to :user
    validates :text , presence: true , length: { in: 1..250 }

    after_create_commit do
         if user.id == self.user.id
            puts "Broadcasting to: comments_#{self.event_id}"
            broadcast_prepend_to "comments_#{self.event_id}", target: "comments_#{self.event_id}", partial: "comments/comment_buttons", locals: { comment: self }
         else
            puts "Broadcasting to: comments_#{self.event_id}"
            broadcast_prepend_to "comments_#{self.event_id}", target: "comments_#{self.event_id}", partial: "comments/comment", locals: { comment: self }
         end
    end

    after_update_commit do
        puts "Broadcasting to: comments_#{self.event_id}"
        broadcast_replace_to "comments_#{self.event_id}", target: "comment_#{self.id}", partial: "comments/comment_buttons", locals: { comment: self }
    end

    after_destroy_commit do
        puts "Broadcasting to: comments_#{self.event_id}"
        broadcast_remove_to "comments_#{self.event_id}" , target: "comment_#{self.id}"
    end
end