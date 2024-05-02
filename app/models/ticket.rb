class Ticket < ApplicationRecord
  validates :title, :description, :status,
    presence: true
  validates :resolution_details, presence: true, if: -> { status == "Closed" }
  validates :title,
    length: { in: 2..255 },
    uniqueness: { scope: :user_id, message: "You have already created a ticket with this title" }
  validates :description,
    length: { in: 3..1000 }
  validate :validate_priority_level
  validates :status, 
    inclusion: { in: ["Open", "In Progress", "Closed"], message: "%{value} is not a status" }
  validates :internal_note, length: { maximum: 1000 }, allow_blank: true
  validate :status_transition_is_valid
  validate :admin_priority_validation

  belongs_to :user
  has_many :comments, dependent: :destroy

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

  def admin_priority_validation
    if user&.admin? && priority_level.blank?
      errors.add(:priority_level, "is required for admins")
    end
  end

  def validate_priority_level
    if user&.admin?
      unless ["1 - Low", "2 - Medium", "3 - High"].include?(priority_level)
        errors.add(:priority_level, "#{priority_level} is not a priority level")
      end
    end
  end
end
