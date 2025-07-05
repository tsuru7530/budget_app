class Map < ApplicationRecord
  belongs_to :district
  geocoded_by :address
  after_validation :geocode
end
