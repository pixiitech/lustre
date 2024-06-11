class SeriesSerializer < ApplicationSerializer
  attribute :label do
    object.name
  end
  attribute :value do
    object.id
  end
end
