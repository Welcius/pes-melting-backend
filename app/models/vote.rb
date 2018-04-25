class Vote < ApplicationRecord
    validates :user_id, uniqueness: {scope: :event_id, message: 'One vote per user'}
end
