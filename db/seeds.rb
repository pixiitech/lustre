# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

CSV.foreach("lib/assets/series.csv").each do |line|
  category = Category.find_or_create_by(name: line[0])
  Series.find_or_create_by(category_id: category.id, name: line[1])
end

Dir.entries('lib/assets/coins').select { |f| f.match?(/\.csv$/) }.each do |file_name|
  CSV.foreach("lib/assets/coins/#{file_name}", headers: true).each do |line|
    begin
    series = Series.find_by(name: line['series'])
    CoinVariety.find_or_create_by(
      series_id: series.id,
      pcgs_id: line['pcgs_id'],
      name: line['name'],
      designation: line['designation']&.squish,
      year: line['name'].match(/^\d{4}/).to_s,
      mint_mark: line['name'].match(/^\d{4}-(P|D|S|O|CC|C|W)/).try(:[], 1),
      mint_type: line['mint_type'] || 'MS'
    )
    rescue => e
      puts file_name
      raise e
    end
  end
end
