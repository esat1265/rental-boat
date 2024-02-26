class CreateBoats < ActiveRecord::Migration[7.1]
  def change
    create_table :boats do |t|
      t.string :name
      t.text :description
      t.integer :price_per_day
      t.integer :year_production
      t.string :image_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
