class CoinVarietySerializer < ApplicationSerializer
  # Pre-loaded data
  attributes :name, :id, :mint_type, :designation, :pcgs_id, :year, :mint_mark

  # Fetched data
  attributes :denomination, :mintage, :metal_content, :diameter, :edge, :weight,
    :population, :pcgs_link, :designer, :pcgs_notes, :images

  attribute :description do
    [object.name, (object.MS? ? nil : "(#{object.mint_type})"), object.designation].compact.join(' ')
  end
end
