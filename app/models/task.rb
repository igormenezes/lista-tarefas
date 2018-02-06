class Task < ApplicationRecord
	validates :name, length: {minimum: 5}, presence: true
end
