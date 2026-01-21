module Api
  module V1
    class SessionsController < BaseController
      def create
        user = User.find_by(email_address: params[:email_address])

        if user&.authenticate(params[:password])
          session = user.sessions.create!
          render json: {
            message: 'Logged in successfully',
            user: {
              id: user.id,
              email_address: user.email_address
            },
            session_id: session.id
          }, status: :created
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        session = Session.find(params[:id])
        session.destroy
        render json: { message: 'Logged out successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Session not found' }, status: :not_found
      end
    end
  end
end
