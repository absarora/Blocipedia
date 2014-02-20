class Page < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user
  attr_accessible :body, :title, :wiki

  default_scope order('created_at DESC')
end
