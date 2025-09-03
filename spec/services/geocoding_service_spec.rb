require 'rails_helper'

RSpec.describe GeocodingService do
  it 'returns coordinates for a valid address' do
    result = GeocodingService.get_coordinates('1600 Amphitheatre Parkway, Mountain View, CA')
    expect(result).to include(:lat, :lon, :zip)
  end
end
