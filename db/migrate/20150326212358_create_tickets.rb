class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.date :date
      t.string :work_order
      t.string :job_code
      t.integer :quantity
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
