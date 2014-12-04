require 'rails_helper'

describe "Task" do
  it "can't be created with a date in the past" do

    task = Task.new
    task.due_date = '01/01/2011'
    task.valid?
    expect(task.errors[:due_date].present?).to eq(true)
  end
  include ActiveSupport::Testing::TimeHelpers
  it "can have an existing date in the past" do
    task = Task.new
    travel_to 3.years.ago do
      task.due_date = Date.today
      task.save
      task.valid?
      expect(task.errors[:due_date].present?).to eq(false)
    end
  end
end
