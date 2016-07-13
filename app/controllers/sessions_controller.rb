class SessionsController < ApplicationController
 protect_from_forgery with: :null_session

  def create
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:notice] = 'Sign In Details Incorrect!'
      redirect_to '/sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password_digest)
  end
end