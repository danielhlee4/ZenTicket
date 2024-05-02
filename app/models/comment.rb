class Comment < ApplicationRecord
    validates :content,
        presence: true,
        length: { in: 1..1000 }

    belongs_to :ticket
    belongs_to :user
end