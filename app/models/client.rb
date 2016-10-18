class Client < ActiveRecord::Base

  validates :name

  belongs_to :user
  has_many :patients

end
