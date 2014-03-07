class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(params[:user])
    if @user.save
      if params[:premium]        
        sign_in(:user, @user)
        redirect_to new_charge_path
      else
        redirect_to root_path, :notice => "Check your email for confirmation instructions"
      end
    else
      render :new
    end
  end
end