class ChangePriorityLevelNullConstraintInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tickets, :priority_level, true
  end
end
