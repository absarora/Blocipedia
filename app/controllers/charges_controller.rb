class ChargesController < ApplicationController

  def new
    Rails.logger.info ">>>> Current User: #{current_user}"
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    # update user to set premium to true
    current_user.update_attribute :role, "premium"

    redirect_to wikis_path, notice: "Thank you for subscribing! You can start creating wikis now."

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
