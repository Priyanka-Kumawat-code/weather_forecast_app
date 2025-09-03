RSpec.describe WeatherService do
  it 'fetches weather data for valid coordinates' do
    data = WeatherService.fetch_forecast(37.422, -122.084)
    expect(data).to include(:temp, :temp_min, :temp_max, :description)
  end
end
