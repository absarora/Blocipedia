class Wiki < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :collaborations
  has_many :users, through: :collaborations
  belongs_to :user

end
