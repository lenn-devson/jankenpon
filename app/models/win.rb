class Win < ApplicationRecord
belongs_to :element, class_name: 'Element'
belongs_to :win_element, class_name: 'Element', foreign_key: :wins_against_id
end
