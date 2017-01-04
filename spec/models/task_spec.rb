require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'toggle_complete!' do
    it 'should switch complete to false if it began as true' do
      task = Task.new(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
    it 'it should switch complete to true if it began as false' do
      task = Task.new(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end
  
  describe 'toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.new(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
    it 'should switch favorite to true if it began as false' do
      task = Task.new(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe 'overdue?' do
    it 'should check that current time is not past the specified deadline of a task' do
      task = Task.new(deadline: Time.now + 1.hour)
      expect(task.overdue?).to eq(false)
    end
    it 'should check that current time is not past the specified deadline of a task' do
      task = Task.new(deadline: Time.now - 1.hour)
      expect(task.overdue?).to eq(true)
    end
  end

  describe 'increment_priority!' do
    it 'should increase priority' do
      task = Task.new(priority: 2)
      task.increment_priority!
      expect(task.priority).to eq(3)
    end
    it 'should not increase priority if the priority is 10 or higher' do
      task = Task.new(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe 'decrement_priority!' do
    it 'should decrease priority by 1' do
      task = Task.new(priority: 4)
      task.decrement_priority!
      expect(task.priority).to eq(3)
    end
    it 'should not decrease the priority if it is already equal to one or less' do
      task = Task.new(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe 'snooze_hour!' do
    it 'should increase the deadline by an hour' do
      current_time = Time.now
      task = Task.new(deadline: current_time)
      task.snooze_hour!
      expect(task.deadline).to eq(current_time + 1.hour)
    end
  end
end
