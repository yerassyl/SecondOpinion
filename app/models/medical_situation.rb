class MedicalSituation < ActiveRecord::Base
  has_many :medications
  accepts_nested_attributes_for :medications, reject_if: :all_blank, allow_destroy: true

  has_many :lab_tests
  accepts_nested_attributes_for :lab_tests, reject_if: :all_blank, allow_destroy: true

  has_many :other_documents
  accepts_nested_attributes_for :other_documents, reject_if: :all_blank, allow_destroy: true

  belongs_to :patient
  belongs_to :pool
  belongs_to :specialization, foreign_key: 'specialization_id'

  # todo: does medical situation belong to only one doctor
  # can it be so that many doctors are viewing one medical_situation, probably yes
  # if so, change this to join table
  belongs_to :doctor

  has_many :medical_services
  has_one :medical_situation_report

  attr_accessor :manager_sets_fee_attr

  validates :reason, :specialization_id, presence: true
  validates :price,  numericality: { only_integer: true, greater_than: 0 }, on: :create

  validates :fee, numericality: { greater_than: 0, less_than: :price }, if: lambda {|u| manager_sets_fee_attr }

  scope :with_specialization_id, lambda { |specialization_ids| 
    where(specialization_id: [*specialization_ids])
  }

  scope :with_fee_gte, lambda { |given_fee|
    where('fee >= ?', given_fee)
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        # Simple sort on the created_at column.
        # Make sure to include the table name to avoid ambiguous column names.
        # Joining on other tables is quite common in Filterrific, and almost
        # every ActiveRecord table has a 'created_at' column.
        order("medical_situations.created_at #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
  [
    ['Registration date (newest first)', 'created_at_desc'],
    ['Registration date (oldest first)', 'created_at_asc']
  ]
  end

  filterrific(
    default_settings: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_fee_gte,
      :with_specialization_id
    ]
  )


end
