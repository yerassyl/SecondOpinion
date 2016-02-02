class MedicalHistory < ActiveRecord::Base
  validates :reason, presence: true

  has_many :medications
  accepts_nested_attributes_for :medications, reject_if: :all_blank, allow_destroy: true

  has_many :diseases
  accepts_nested_attributes_for :diseases, reject_if: :all_blank, allow_destroy: true

  has_many :allergies
  accepts_nested_attributes_for :allergies, reject_if: :all_blank, allow_destroy: true

  has_many :lab_tests
  accepts_nested_attributes_for :lab_tests, reject_if: :all_blank, allow_destroy: true

  has_many :other_documents
  accepts_nested_attributes_for :other_documents, reject_if: :all_blank, allow_destroy: true

  belongs_to :patient

end
