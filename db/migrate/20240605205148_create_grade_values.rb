class CreateGradeValues < ActiveRecord::Migration[7.1]
  def change
    create_table :grade_values do |t|
      t.integer :grade
      t.float :value
      t.references :coin_variety

      t.timestamps
    end
  end
end
