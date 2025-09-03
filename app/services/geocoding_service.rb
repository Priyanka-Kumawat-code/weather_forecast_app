class GeocodingService
  def self.get_coordinates(address)
    results = Geocoder.search(address)
    return nil if results.empty?

    location = results.first
    { lat: location.latitude, lon: location.longitude, zip: location.postal_code }
  end
end
