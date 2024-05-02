class AddInternalNoteToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :internal_note, :text
  end
end
