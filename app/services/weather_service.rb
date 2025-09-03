class WeatherService
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def self.fetch_forecast(lat, lon)
    response = get('/weather', query: {
      lat: lat,
      lon: lon,
      units: 'metric',
      appid: ENV['OPENWEATHER_API_KEY']
    })

    return nil unless response.success?

    {
      temp: response['main']['temp'],
      temp_min: response['main']['temp_min'],
      temp_max: response['main']['temp_max'],
      description: response['weather'][0]['description']
    }
  end
end
