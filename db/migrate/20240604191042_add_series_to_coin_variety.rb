class AddSeriesToCoinVariety < ActiveRecord::Migration[7.1]
  def change
    add_reference :coin_varieties, :series
  end
end
