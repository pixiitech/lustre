class CoinVarietySerializer < ApplicationSerializer
  # Pre-loaded data
  attributes :name, :id, :mint_type, :designation, :pcgs_id, :year, :mint_mark

  # Fetched data
  attributes :denomination, :mintage, :metal_content, :diameter, :edge, :weight,
    :population, :designer, :pcgs_notes, :images

  attribute :pcgs_link do
    object.pcgs_link ? "https://#{object.pcgs_link}" : nil
  end

  attribute :description do
    [
      object.name,
      (object.MS? ? nil : object.mint_type),
      (%w[MS PR SP].include?(object.designation) ? nil : object.designation)
    ].compact.join(' ')
  end
end
