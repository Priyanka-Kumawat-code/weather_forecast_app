require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  describe "GET #show" do
    let(:address) { "Indore, MP" }
    let(:coords) { { lat: 22.7196, lon: 75.8577, zip: "452001" } }
    let(:forecast_data) { { temp: 32, condition: "Sunny" } }

    context "when address is valid" do
      before do
        allow(GeocodingService).to receive(:get_coordinates).with(address).and_return(coords)
        allow(CacheService).to receive(:fetch_or_store).with(coords[:zip]).and_yield({ data: forecast_data, cached: false })
      end

      it "returns a successful response" do
        get :show, params: { address: address }
        expect(response).to have_http_status(:ok)
      end

      it "returns forecast data in JSON" do
        get :show, params: { address: address }
        json = JSON.parse(response.body)

        expect(json["forecast"]).to eq(forecast_data.as_json)
        expect(json["cached"]).to eq(false)
      end
    end

    context "when address is invalid" do
      before do
        allow(GeocodingService).to receive(:get_coordinates).with("invalid").and_return(nil)
      end

      it "returns a 400 error" do
        get :show, params: { address: "invalid" }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ "error" => "Invalid address" })
      end
    end
  end
end
