class MedicalService < ActiveRecord::Base

  belongs_to :medical_situation
  belongs_to :specialization
  belongs_to :doctor

  has_many :medical_service_documents
  accepts_nested_attributes_for :medical_service_documents, reject_if: :all_blank, allow_destroy: true


  attr_accessor :manager_sets_fee_attr

  validates :specialization_id, :description, presence: true
  validates :price, numericality: { greater_than: 0 }

  validates :fee, numericality: { greater_than: 0, less_than: :price }, if: lambda {|u| manager_sets_fee_attr }


  private


end
