module Api
  module V1
    class UsersController < BaseController
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.all
        render json: @users, only: [:id, :email_address, :created_at]
      end

      def show
        render json: @user, only: [:id, :email_address, :created_at]
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: {
            message: 'User created successfully',
            user: @user.as_json(only: [:id, :email_address, :created_at])
          }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: {
            message: 'User updated successfully',
            user: @user.as_json(only: [:id, :email_address, :created_at])
          }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        render json: { message: 'User deleted successfully' }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end 

      def user_params
        params.require(:user).permit(:email_address, :password, :password_confirmation)
      end
    end
  end
end
