class ForecastsController < ApplicationController
  def show
    address = params[:address]
    coords = GeocodingService.get_coordinates(address)

    return render json: { error: 'Invalid address' }, status: 400 unless coords

    result = CacheService.fetch_or_store(coords[:zip]) do
      WeatherService.fetch_forecast(coords[:lat], coords[:lon])
    end

    render json: {
      forecast: result[:data],
      cached: result[:cached]
    }
  end
end
