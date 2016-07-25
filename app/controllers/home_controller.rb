class HomeController < ApplicationController
  def show
    render :show, layout: false
  end

  def dashboard
    @gardens = Garden.all
  end
end