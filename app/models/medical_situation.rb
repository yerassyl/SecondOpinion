class MedicalSituation < ActiveRecord::Base
  has_many :medications
  accepts_nested_attributes_for :medications, reject_if: :all_blank, allow_destroy: true

  has_many :lab_tests
  accepts_nested_attributes_for :lab_tests, reject_if: :all_blank, allow_destroy: true

  has_many :other_documents
  accepts_nested_attributes_for :other_documents, reject_if: :all_blank, allow_destroy: true

  belongs_to :patient
  belongs_to :pool
  belongs_to :specialization

  # todo: does medical situation belong to only one doctor
  # can it be so that many doctors are viewing one medical_situation, probably yes
  # if so, change this to join table
  belongs_to :doctor

  has_many :medical_services
  has_one :medical_situation_report

  attr_accessor :manager_sets_fee_attr

  validates :reason, :specialization_id, presence: true
  validates :price,  numericality: {only_integer: true, greater_than: 0}, on: :create

  validates :fee, numericality: { greater_than: 0, less_than: :price }, if: lambda {|u| manager_sets_fee_attr }


end
