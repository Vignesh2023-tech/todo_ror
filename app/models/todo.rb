class Todo < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true
  validates :user_id, presence: true

  def self.over_due
    all.where("due_date < ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

end
