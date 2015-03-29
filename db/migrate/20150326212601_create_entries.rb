class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.datetime :start
      t.datetime :end
      t.references :ticket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
