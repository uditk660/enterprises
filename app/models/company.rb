class Company < ApplicationRecord
	has_many :bills, dependent: :destroy
end
