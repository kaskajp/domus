class Task < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :priority, inclusion: { in: %w[low medium high urgent] }
  validates :recurrence_type, inclusion: { in: %w[daily weekly monthly quarterly yearly custom] }, allow_blank: true
  validates :recurrence_interval, presence: true, numericality: { greater_than: 0 }, if: :custom_recurrence?
  
  validate :due_date_cannot_be_in_past, if: :due_date_changed?
  validate :recurring_task_must_have_recurrence_type, if: :recurring?

  scope :completed, -> { where.not(completed_at: nil) }
  scope :incomplete, -> { where(completed_at: nil) }
  scope :due_today, -> { where(due_date: Date.current) }
  scope :overdue, -> { where("due_date < ? AND completed_at IS NULL", Date.current) }
  scope :assigned_to, ->(user) { where(assignee: user) }
  scope :created_by, ->(user) { where(created_by: user) }
  scope :by_priority, -> { order(Arel.sql("CASE priority WHEN 'urgent' THEN 1 WHEN 'high' THEN 2 WHEN 'medium' THEN 3 WHEN 'low' THEN 4 END")) }
  scope :by_due_date, -> { order(:due_date) }
  scope :recent, -> { order(created_at: :desc) }

  def completed?
    completed_at.present?
  end

  def complete!
    update!(completed_at: Time.current)
  end

  def incomplete!
    update!(completed_at: nil)
  end

  def overdue?
    due_date.present? && due_date < Date.current && !completed?
  end

  def due_today?
    due_date == Date.current
  end

  def priority_color
    case priority
    when "urgent" then "bg-red-100 text-red-800"
    when "high" then "bg-orange-100 text-orange-800"
    when "medium" then "bg-yellow-100 text-yellow-800"
    when "low" then "bg-green-100 text-green-800"
    else "bg-gray-100 text-gray-800"
    end
  end

  def priority_icon
    case priority
    when "urgent" then "M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L4.082 15.5c-.77.833.192 2.5 1.732 2.5z"
    when "high" then "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
    when "medium" then "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
    when "low" then "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
    else "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
    end
  end

  def tags_array
    return [] if tags.blank?
    tags.split(",").map(&:strip).reject(&:blank?)
  end

  def tags_array=(array)
    self.tags = array.join(", ")
  end

  def due_datetime
    return nil unless due_date.present?
    return due_date.to_time if due_time.blank?
    
    Time.zone.parse("#{due_date} #{due_time}")
  end

  def next_due_date
    return nil unless recurring? && recurrence_type.present?
    
    base_date = completed_at&.to_date || due_date || Date.current
    
    case recurrence_type
    when "daily"
      base_date + (recurrence_interval || 1).days
    when "weekly"
      base_date + (recurrence_interval || 1).weeks
    when "monthly"
      base_date + (recurrence_interval || 1).months
    when "quarterly"
      base_date + (recurrence_interval || 3).months
    when "yearly"
      base_date + (recurrence_interval || 1).years
    when "custom"
      base_date + (recurrence_interval || 1).days
    end
  end

  def create_next_occurrence!
    return unless recurring? && completed?
    
    next_task = self.dup
    next_task.due_date = next_due_date
    next_task.completed_at = nil
    next_task.save!
    
    next_task
  end

  private

  def due_date_cannot_be_in_past
    return unless due_date.present? && due_date < Date.current
    errors.add(:due_date, "cannot be in the past")
  end

  def recurring_task_must_have_recurrence_type
    return unless recurring? && recurrence_type.blank?
    errors.add(:recurrence_type, "must be specified for recurring tasks")
  end

  def custom_recurrence?
    recurrence_type == "custom"
  end
end 