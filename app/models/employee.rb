class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true # creator
  has_many :employee_documents, dependent: :destroy
  has_many :employee_salary_structures, dependent: :destroy
  has_many :employee_monthly_salaries, dependent: :destroy

  enum employee_status: { active: "active", inactive: "inactive", resigned: "resigned", suspended: "suspended" }

  validates :first_name, :last_name, :designation, :joining_date, :salary, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone_number,
            format: { with: /\A\d{10}\z/, message: "must be 10 digits" },
            allow_blank: true

  validates :aadhaar_number,
            format: { with: /\A\d{12}\z/, message: "must be 12 digits" },
            allow_blank: true

  validates :pan_number,
            format: { with: /\A[A-Z]{5}[0-9]{4}[A-Z]\z/, message: "is invalid" },
            allow_blank: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_salary_structure
    employee_salary_structures.active.order(effective_from: :desc).first
  end
end
