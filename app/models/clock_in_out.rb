class ClockInOut < ApplicationRecord
  belongs_to :user


  validates :user, presence: true
  validates :clock_in, presence: true
  validate :should_be_clocked_once
  # validates :clock_out, presence: true, :if => Proc.new { |clockinout | clockinout clockinout.clock_in.present? }


  def should_be_clocked_once
    if clock_in_changed? && clock_in_was != nil
      errors.add(:clock_in_change, 'Cannot update clock in')
    end

    if clock_out_changed? && clock_out_was != nil
      errors.add(:clock_out_change, 'Cannot update clock out')
    end
  end

  def self.clock_in(user_id)
    now = DateTime.now
    clock_in_out = self.find_or_create_by(user_id: user_id, target_date: now.to_date)
    clock_in_out.clock_in = now
    clock_in_out.save
    clock_in_out
  end

  def self.clock_out(user_id)
    now = DateTime.now
    clock_in_out = self.find_or_create_by(user_id: user_id, target_date: now.to_date)
    duration = now.to_i - clock_in_out.clock_in.to_i
    clock_in_out.clock_out = now
    clock_in_out.duration = duration
    clock_in_out.save
    clock_in_out
  end

  def self.find_by_user_ordered_created_at(user_id)
    self.where(user_id: user_id).order(created_at: :desc)
  end
end
