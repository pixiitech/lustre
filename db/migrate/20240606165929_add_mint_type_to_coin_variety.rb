class AddMintTypeToCoinVariety < ActiveRecord::Migration[7.1]
  def change
    add_column :coin_varieties, :mint_type, :integer, default: 0, null: false
  end
end
