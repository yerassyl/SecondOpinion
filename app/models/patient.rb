class Patient < ActiveRecord::Base
  validates :firstname,
            :lastname,
            :email,
            presence: true

  validates :email, uniqueness: true

  belongs_to :client
  has_many :medical_histories
  has_many :allergies

  def print_gender
    gender=='1' ? 'Male' : 'Female'
  end
  
end
