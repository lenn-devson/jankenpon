class CreateWins < ActiveRecord::Migration[5.2]
  def change
    create_table :wins do |t|
      t.integer :element_id
      t.integer :wins_against_id
    end
  end
end
