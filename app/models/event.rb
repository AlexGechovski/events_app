class Event < ApplicationRecord
    validates :title, presence: true , length: { in: 4..150 }
    validates :location, presence: true, length: { in: 6..150 }
    validates :start_date, presence: true
    validates :end_date, presence: true ,comparison: { greater_than_or_equal_to: :start_date }

    has_many :comments, dependent: :destroy
    belongs_to :user
end
