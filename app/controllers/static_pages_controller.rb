class StaticPagesController < ApplicationController
  def index
    @favorite_vehicles = Vehicle.all.limit(5)
  end
end
