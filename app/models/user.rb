class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :collaborations
  
  has_many :wikis

  before_create :set_member
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  attr_accessor :stripe_card_token

  ROLES = %w[member moderator premium admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def save_with_payment
      if valid?
        customer = Stripe::Customer.create(description: email, plan: 500, card: stripe_card_token)
        self.stripe_customer_token = customer.id
        save!
      end
  end 

  def active_for_authentication?
    true
  end

  private

  def set_member
    self.role = 'member'
  end

end