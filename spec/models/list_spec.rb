require 'rails_helper'

RSpec.describe List, type: :model do
  describe '#complete_all_tasks!' do
    it 'should mark all task from the list as complete' do
      list = List.create(name: "Chores")
      task = Task.create(complete: false, list_id: list.id)
      task = Task.create(complete: false, list_id: list.id)
      list.complete_all_tasks!
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end
    end
  end
  describe '#snooze_all_tasks!' do
    it 'should snooze all tasks by an hour' do
      deadline_time = Time.now
      list = List.create(name: "Chores")
      task = Task.create(deadline: deadline_time, list_id: list.id)
      task = Task.create(deadline: deadline_time, list_id: list.id)
      list.snooze_all_tasks!
      list.tasks.each do |task|
        expect(task.deadline).to eq(deadline_time + 1.hour)
      end
    end
  end
  describe '#total_duration' do
    it 'should total up the duration of all tasks' do
      list = List.create(name: "Chores")
      task = Task.create(duration: 3, list_id: list.id)
      task = Task.create(duration: 5, list_id: list.id)
      expect(list.total_duration).to eq(8)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return an array of incomplete tasks' do
      deadline_time = Time.now
      list = List.create(name: "Chores")
      task = Task.create(complete: false, list_id: list.id)
      task = Task.create(complete: false, list_id: list.id)
      task = Task.create(complete: true, list_id: list.id)
      list.incomplete_tasks.each do |task|
        expect(task.complete).to eq(false)
      end
    end
  end
  describe '#favorite_tasks' do
    it 'should return and array of tasks that were favorited' do
      list = List.create(name: "Chores")
      task = Task.create(favorite: false, list_id: list.id)
      task = Task.create(favorite: true, list_id: list.id)
      task = Task.create(favorite: true, list_id: list.id)
      list.favorite_tasks.each do |task|
        expect(task.favorite).to eq(true)
      end
    end
  end
end
