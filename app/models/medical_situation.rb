class MedicalSituation < ActiveRecord::Base
  has_many :medications
  accepts_nested_attributes_for :medications, reject_if: :all_blank, allow_destroy: true

  has_many :lab_tests
  accepts_nested_attributes_for :lab_tests, reject_if: :all_blank, allow_destroy: true

  has_many :other_documents
  accepts_nested_attributes_for :other_documents, reject_if: :all_blank, allow_destroy: true

  belongs_to :patient, foreign_key: 'patient_id'
  belongs_to :pool
  belongs_to :specialization, foreign_key: 'specialization_id'
  belongs_to :medical_situation_status, foreign_key: 'medical_situation_status_id'

  # todo: does medical situation belong to only one doctor
  # can it be so that many doctors are viewing one medical_situation, probably yes
  # if so, change this to join table
  belongs_to :doctor

  has_many :medical_services
  has_many :medical_situation_reports

  attr_accessor :manager_sets_fee_attr

  validates :reason, :specialization_id, presence: true
  validates :price,  numericality: { only_integer: true, greater_than: 0 }, on: :create

  validates :fee, numericality: { greater_than: 0, less_than: :price }, if: lambda {|u| manager_sets_fee_attr }

  scope :with_specialization_id, lambda { |specialization_ids| 
    where(specialization_id: [*specialization_ids])
  }

  scope :with_medical_situation_status_id, lambda { |status_ids| 
    where(medical_situation_status_id: [*status_ids])
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
      when /^urgent_/
        order("medical_situations.is_urgent #{ direction }")
      when /^fee_/
        order("medical_situations.fee #{ direction } NULLS LAST")
      when /^price_/
        order("medical_situations.price #{ direction } NULLS LAST")
      when /patient_name_/
        MedicalSituation.joins("INNER JOIN patients ON patients.id = medical_situations.patient_id").order("LOWER(patients.firstname) #{ direction },
               LOWER(patients.lastname) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :search_by_patient, lambda { |query| 
    return nil if query.blank?

    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 2
    MedicalSituation.joins("INNER JOIN patients ON patients.id = medical_situations.patient_id").where(
      terms.map { |term|
        "(LOWER(patients.firstname) LIKE ? OR LOWER(patients.lastname) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  def self.options_for_sorted_by
  [
    ['Registration date (newest first)', 'created_at_desc'],
    ['Registration date (oldest first)', 'created_at_asc'],
    ['Urgent first', 'urgent_desc']
  ]
  end

  def self.options_for_sorted_by_manager
    [
      ['Fee ascending', 'fee_asc'],
      ['Fee descending', 'fee_desc'],
      ['Price ascending', 'price_asc'],
      ['Price descending', 'price_desc'],
      ['Patient name (a-z)', 'patient_name_asc'],
      ['Registration date (newest first)', 'created_at_desc'],
      ['Registration date (oldest first)', 'created_at_asc'],
      ['Urgent first', 'urgent_desc']
    ]
  end

  filterrific(
    default_settings: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_fee_gte,
      :with_specialization_id,
      :search_by_patient,
      :with_medical_situation_status_id
    ]
  )


end
