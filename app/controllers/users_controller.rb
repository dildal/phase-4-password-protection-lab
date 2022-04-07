class UsersController < ApplicationController
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end

    def show
        user = User.find(session[:user_id])
        render json: user, status: :ok
    rescue ActiveRecord::RecordNotFound => invalid
        render json: {error: "Not logged in"}, status: :unauthorized
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
