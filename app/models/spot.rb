class Spot < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  attr_writer :use_address

  enum zoom_level: { building: 20, street: 15, city: 10, region: 5, continent: 3 }

  validates :address_1, :city, :state, :zip, presence: true, if: :validate_address?
  validates :latitude, :longitude, presence: true, if: :validate_coordinates?
  validates :name, :user, :zoom_level, presence: true

  after_validation :maybe_clear_address
  after_validation :geocode, if: :should_geocode?

  def self.us_states
    [
        ['AK', 'AK'],
        ['AL', 'AL'],
        ['AR', 'AR'],
        ['AZ', 'AZ'],
        ['CA', 'CA'],
        ['CO', 'CO'],
        ['CT', 'CT'],
        ['DC', 'DC'],
        ['DE', 'DE'],
        ['FL', 'FL'],
        ['GA', 'GA'],
        ['HI', 'HI'],
        ['IA', 'IA'],
        ['ID', 'ID'],
        ['IL', 'IL'],
        ['IN', 'IN'],
        ['KS', 'KS'],
        ['KY', 'KY'],
        ['LA', 'LA'],
        ['MA', 'MA'],
        ['MD', 'MD'],
        ['ME', 'ME'],
        ['MI', 'MI'],
        ['MN', 'MN'],
        ['MO', 'MO'],
        ['MS', 'MS'],
        ['MT', 'MT'],
        ['NC', 'NC'],
        ['ND', 'ND'],
        ['NE', 'NE'],
        ['NH', 'NH'],
        ['NJ', 'NJ'],
        ['NM', 'NM'],
        ['NV', 'NV'],
        ['NY', 'NY'],
        ['OH', 'OH'],
        ['OK', 'OK'],
        ['OR', 'OR'],
        ['PA', 'PA'],
        ['RI', 'RI'],
        ['SC', 'SC'],
        ['SD', 'SD'],
        ['TN', 'TN'],
        ['TX', 'TX'],
        ['UT', 'UT'],
        ['VA', 'VA'],
        ['VT', 'VT'],
        ['WA', 'WA'],
        ['WI', 'WI'],
        ['WV', 'WV'],
        ['WY', 'WY']
    ]
  end

  def address
    address = nil
    if address_1.present? && city.present? && state.present? && zip.present?
      address = address_1
      address += " #{address_2}" if address_2.present?
      address += " #{city}" if city.present?
      address += " #{state}" if state.present?
      address += " #{zip.to_s}" if zip.present?
    end
    address
  end

  def use_address
    @use_address || (address.present? ? "1": "0")
  end

  def validate_address?
    use_address == "1"
  end

  def validate_coordinates?
    use_address == "0"
  end

  def address_changed?
    address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed?
  end

  def should_geocode?
    address_changed? && address.present?
  end

  def maybe_clear_address
    if use_address == "0"
      self.address_1 = nil
      self.address_2 = nil
      self.city = nil
      self.zip = nil
      self.state = nil
    end
  end

  def large_image_tag
    if geocoded?
      map_location = MapLocation.new(latitude: latitude, longitude: longitude)
      map = GoogleStaticMap.new(zoom: Spot.zoom_levels[zoom_level],
                                width: 400,
                                height: 400,
                                center: map_location )
      map.markers << MapMarker.new(color: "red", location: map_location)
      map.url(:auto)
    end
  end

  def small_image_tag
    if geocoded?
      map_location = MapLocation.new(latitude: latitude, longitude: longitude)
      map = GoogleStaticMap.new(zoom: Spot.zoom_levels[zoom_level],
                                width: 75,
                                height: 75,
                                scale: 2,
                                center: map_location )
      map.markers << MapMarker.new(color: "red", location: map_location)
      map.url(:auto)
    end
  end
end
