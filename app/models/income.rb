class Income < ApplicationRecord
    belongs_to :district, optional: true
    has_many :outgoes, dependent: :destroy
    validates :district_id, presence: true
    validates :year, presence: true
    validates :category, presence: true
    validates :price, presence: true, numericality:{only_integer: true, greater_than_or_equal_to: 0}
end
