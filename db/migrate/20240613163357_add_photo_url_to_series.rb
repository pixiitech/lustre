class AddPhotoUrlToSeries < ActiveRecord::Migration[7.1]
  def change
    add_column :series, :photo_url, :string
  end
end
