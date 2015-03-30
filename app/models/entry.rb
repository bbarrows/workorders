class EntryValidator < ActiveModel::Validator
  def validate(entry_obj)
    all_user_entries = Entry.joins(:ticket).where('tickets.user_id' => entry_obj.ticket.user.id)
    entry_obj.errors[:base] << "Entry time conflict" if all_user_entries.any? {|e| e.entry_range.overlaps? entry_obj.entry_range}
    entry_obj.errors[:base] << "Start time is after end time" if entry_obj.start > entry_obj.end
  end
end

class Entry < ActiveRecord::Base
  validates_with EntryValidator
  belongs_to :ticket

  def entry_range
     self.start..self.end
  end
end
