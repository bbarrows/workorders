module TicketsHelper

  def tickets_to_csv(tickets)

    # Better way to do this with directy query, all entries with same ticket_id
    max_entries=1
    for t in tickets
      if t.entries.count > max_entries
        max_entries = t.entries.count
      end
    end

    user_columns = ["first", "last", "email"]
    wo_columns = Ticket.columns.map {|c| c.name }
    e_columns = Entry.columns.map {|c| c.name }
    CSV.generate do |csv|
      columns = user_columns + wo_columns + (e_columns * max_entries)
      csv << columns
      for t in tickets
        row = t.user.attributes.values_at(*user_columns)
        row += t.attributes.values_at(*wo_columns)

        for e in t.entries
          row += e.attributes.values_at(*e_columns)
        end

        csv << row
      end
    end
  end

end
