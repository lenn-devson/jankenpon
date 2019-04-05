class Element < ApplicationRecord
  has_many :wins
  has_many :win_elements, through: :wins

  validates :title, uniqueness: true
end
