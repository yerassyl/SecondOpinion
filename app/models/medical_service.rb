class MedicalService < ActiveRecord::Base

  belongs_to :medical_situation
  belongs_to :specialization


  has_many :medical_service_documents
  accepts_nested_attributes_for :medical_service_documents, reject_if: :all_blank, allow_destroy: true

  validates :specialization_id, :description, presence: true
  validates :price, numericality: { greater_than: 0}

  #validates :fee, numericality: {greater_than: 0 }

end
