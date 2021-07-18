class BirdsController < ApplicationController
  def index
    @birds = Bird.all
    render json: @birds
  end

  def show
    # To also remove all instances of :created_at and :updated_at from the nested bird 
    # and location data we'd have to add nesting into the options, so the 
    # included bird and location data can have their own options listed. Using the fully written to_json 
    # render statement can help keep things more readable here:

    sighting = Sighting.find_by(id: params[:id])
    render json: sighting.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])

  end
end