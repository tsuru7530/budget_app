class District < ApplicationRecord
    has_many :incomes
    has_many :outgoes
    validates :name, presence: true
end
