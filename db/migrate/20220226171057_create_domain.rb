class CreateDomain < ActiveRecord::Migration[7.0]
  def change
    create_table :domains do |t|
      t.references :user, foreign_key: true
      t.string :base_url
      t.string :icon
      t.timestamps
    end
  end
end
