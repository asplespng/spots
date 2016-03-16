class Spot < ActiveRecord::Base
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :should_geocode?

  attr_accessor :use_address


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

  def address_changed?
    address_1_changed? || address_2_changed? || city_changed? || state_changed? || zip_changed?
  end

  def should_geocode?
    address_changed? && address.present?
  end
end
