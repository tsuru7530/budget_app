class District < ApplicationRecord
    has_many :incomes, dependent: :destroy
    has_one_attached :image, dependent: :destroy
    validates :name, presence: true, length: {maximum: 50}
    validates :year, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 7}
    validates :office, presence: true, length: {maximum: 50}
end
