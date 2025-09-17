class Animal < ApplicationRecord
    validates :name, :lhs_id, :species, :status, presence: true
end
