class Animal < ApplicationRecord
    validates :name, :lhs_id, :species, :status, presence: true

    enum :species, { dog: 0, cat: 1, small_and_furry: 2 }
    enum :gender, { male: 0, female: 1 }
    enum :status, { new_to_shelter: 0, adoptable: 1, adopted: 2 }
end
