class District < ApplicationRecord
    has_many :incomes, dependent: :destroy
    validates :name, presence: true
    validates :year, presence: true
    validates :office, presence: true
end
