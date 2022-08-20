class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_camper_not_found
rescue_from ActiveRecord::RecordInvalid, with: :validation_error
    wrap_parameters format: []
    def index
        campers = Camper.all 
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitesShowSerializer
    end
    
    def create 
        camper = Camper.create!(params_camper)
        render json: camper, status: :created 
    end

    private 

    def render_camper_not_found
        render json: {error: "Camper not found"}, status: :not_found 
    end

    def params_camper
        params.permit(:name, :age)
    end

    def validation_error(valide)
        render json: { error: valide.record.errors }, status: :unprocessable_entity 
    end

end
