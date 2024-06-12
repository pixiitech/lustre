class GradeValueSerializer < ApplicationSerializer
  attributes :grade, :value

  belongs_to :coin_variety
end
