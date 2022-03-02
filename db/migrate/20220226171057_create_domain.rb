class CreateDomain < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.string :base_url
      t.string :icon
      t.timestamps
    end
  end
end
