class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :priority_level, null: false
      t.string :status, null: false
      t.text :resolution_details

      t.timestamps
    end
    add_index :tickets, :priority_level
    add_index :tickets, :status
  end
end
