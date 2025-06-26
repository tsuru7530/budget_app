class Outgo < ApplicationRecord
    belongs_to :income, optional: true
    validates :income_id, presence: true
    validates :year, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 7}
    validates :price, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 0}, length: {maximum: 10}
    validates :memo, presence: true, length: {maximum: 50}
end
