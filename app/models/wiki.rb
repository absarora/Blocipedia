class Wiki < ActiveRecord::Base
  has_many :pages
  attr_accessible :description, :name, :public
end
