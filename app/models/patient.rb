class Patient < ActiveRecord::Base
  validates :firstname,
            :lastname,
            :email,
            presence: true

  validates :email, uniqueness: true

  belongs_to :client
  has_many :medical_situations
  has_many :allergies
  has_many :diseases

  def print_gender
    gender=='1' ? 'Male' : 'Female'
  end
  
end
