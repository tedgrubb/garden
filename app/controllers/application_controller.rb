class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_weather

  helper_method :controller_name, :action_name

  def get_weather
    @forcast = Rails.cache.fetch("weather_for_now", expires_at: (Time.now.end_of_day - Time.now).to_i.seconds) do
      ForecastIO.forecast(37.813964, -122.248746)
    end
  end

  def load_plants
    @plants = Plant.order(:name)
  end

  def home

  end
end
