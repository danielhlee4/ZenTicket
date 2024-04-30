class Ticket < ApplicationRecord
  validates :title, :description, :priority_level, :status,
    presence: true
  validates :resolution_details, presence: true, if: -> { status == "Closed" }
  validates :title,
    length: { in: 2..255 },
    uniqueness: { scope: :user_id, message: "You have already created a ticket with this title" }
  validates :description,
    length: { in: 3..30000 }
  validates :priority_level, 
    inclusion: { in: ["Low", "Medium", "High"], message: "%{value} is not a priority level" }
  validates :status, 
    inclusion: { in: ["Open", "In Progress", "Closed"], message: "%{value} is not a status" }
  validate :status_transition_is_valid

  belongs_to :user

  private

  def status_transition_is_valid
    # Only check transitions if the record already exists and the status has changed
    return unless persisted? && status_changed?
  
    unless status_change_allowed?
      errors.add(:status, "Transition from #{status_was} to #{status} is not allowed")
    end
  end

  # Determine if a status transition is allowed
  def status_change_allowed?
    allowed_transitions = {
      "Open" => ["In Progress"],
      "In Progress" => ["Closed", "Open"],
      "Closed" => []
    }

    # Allow any initial status when the record is new and not persisted
    return true if new_record?
    
    # Fetch the allowed transitions for the previous status, or use an empty array if none
    valid_transitions = allowed_transitions[status_was] || []
    valid_transitions.include?(status)
  end
end
