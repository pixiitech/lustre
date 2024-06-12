class SeriesSerializer < ApplicationSerializer
  attributes :name, :id

  attribute :mint_types do
    object.coin_varieties.pluck(:mint_type).uniq
  end
end
