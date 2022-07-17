class UsersController < ApplicationController
    def create 
        user = User.create(user_params)
        if user.valid? 
            sessions[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id:params[:id])
        if user&.authenticate(params[:password])
            render json: user, status: :created
        else
            render json: { errors: 'User not found' }, status: :not_found
        end
    end

    private

    def user_params 
        params.permit(:username, :password_digest)
    end
end
