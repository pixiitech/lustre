class SeriesSerializer < ApplicationSerializer
  attributes :name, :id, :photo_url

  attribute :mint_types do
    object.coin_varieties.pluck(:mint_type).uniq
  end
end
