class District < ApplicationRecord
    has_many :incomes
    validates :name, presence: true
end
