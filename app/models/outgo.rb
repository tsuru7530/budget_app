class Outgo < ApplicationRecord
    belongs_to :income, optional: true
    validates :year, presence: true
    validates :price, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 0}
    validates :memo, presence: true
end
