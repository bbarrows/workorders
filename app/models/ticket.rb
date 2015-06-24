class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :entries, dependent: :destroy

  def to_csv
  	wo_columns = Ticket.columns.map {|c| c.name }
  	b_columns = Entry.columns.map {|c| c.name }
    CSV.generate do |csv|
      csv << wo_columns
      csv << self.attributes.values_at(*wo_columns)
      csv << b_columns
      for b in self.breaks
      	csv << b.attributes.values_at(*b_columns)
      end
    end
  end

end
