class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :validation_error
    def create 
        signup = Signup.create!(signup_params)
        activity = Activity.find(signup.activity_id)
        render json: activity, status: :created
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def validation_error(valide)
        render json: { error: valide.record.errors }, status: :unprocessable_entity 
    end
end
