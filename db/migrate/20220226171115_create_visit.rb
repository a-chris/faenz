class CreateVisit < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.references :domain, null: false, foreign_key: true
      t.string :url
      t.string :event
      t.string :referrer
      t.integer :width
      t.string :ip
      t.text :geo
      t.datetime :time_at
      t.timestamps
    end
  end
end
