class CategorySerializer < ApplicationSerializer
  attribute :label do
    object.name
  end
  attribute :value do
    object.id
  end

  has_many :series
end
