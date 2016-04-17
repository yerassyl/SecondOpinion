class MedicalSituation < ActiveRecord::Base
  has_many :medications
  accepts_nested_attributes_for :medications, reject_if: :all_blank, allow_destroy: true

  has_many :lab_tests
  accepts_nested_attributes_for :lab_tests, reject_if: :all_blank, allow_destroy: true

  has_many :other_documents
  accepts_nested_attributes_for :other_documents, reject_if: :all_blank, allow_destroy: true

  belongs_to :patient
  belongs_to :doctor
  belongs_to :pool
  validates :reason, presence: true
  validates :price,  numericality: {only_integer: true, greater_than: 0}, on: :update

end
