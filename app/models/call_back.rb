class CallBack < ActiveRecord::Base
  validates :name,
            :country,
            :phone,
            :language,
            :email,
            :specialization,
            :code,
            presence: true

  validates :email, uniqueness: true

  validates :didAgree, presence: {message: I18n.t('forms.required') }


end
