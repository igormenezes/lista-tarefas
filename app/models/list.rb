class List < ApplicationRecord
	validates :name, length: {minimum: 5}, uniqueness: true, presence: true
	validates :available, presence: true, inclusion: { in: 0..1 }
end
