class CreateCoinVarieties < ActiveRecord::Migration[7.1]
  def change
    create_table :coin_varieties do |t|
      t.integer :pcgs_id
      t.string :name
      t.integer :year
      t.string :denomination
      t.string :mintage
      t.string :mint_mark
      t.string :metal_content
      t.float :diameter
      t.string :edge
      t.float :weight
      t.string :grade
      t.string :designation
      t.float :price_value
      t.integer :population
      t.string :pcgs_link
      t.string :designer
      t.text :pcgs_notes
      t.string :series_name

      t.timestamps
    end
  end
end
