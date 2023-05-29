class AddDatesIndexesToVisit < ActiveRecord::Migration[7.0]
  def change
    add_index :visits, :time_at
    add_index :visits, %i[domain_id time_at]
  end
end
