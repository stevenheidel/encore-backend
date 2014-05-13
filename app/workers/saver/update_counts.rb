class Saver::UpdateCounts
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :queue => :default, :backtrace => false

  recurrence { daily }

  # Update the counter caches in the Event <-> User relationship
  def perform
    # Ruby trick found here: https://stackoverflow.com/questions/15761306/convert-array-of-objects-to-hash-with-a-field-as-the-key
    users = Hash[User.all.map do |u|
      [u.id, {events_count: u.events.count}]
    end]
    User.update(users.keys, users.values)

    events = Hash[Event.all.map do |e|
      [e.id, {users_count: e.users.count}]
    end]
    Event.update(events.keys, events.values)
  end
end
