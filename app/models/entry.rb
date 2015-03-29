class Entry < ActiveRecord::Base
  belongs_to :ticket

  def entry_range
     self.start..self.end
  end

  def any_overylap?
    all_user_entries = Entry.joins(:ticket).where('tickets.user_id' => self.ticket.user.id)
    if all_user_entries.any? {|e| e.entry_range.overlaps? self.entry_range}
      errors[:base] << "Entry time conflict"
      return true
    else
      return false
    end
  end

end
