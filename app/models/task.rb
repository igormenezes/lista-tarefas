class Task < ApplicationRecord
	validates :description, length: {minimum: 5}, presence: true
end
