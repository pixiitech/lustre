class CoinVariety < ActiveRecord::Base
  belongs_to :series
  has_many :grade_values

  enum mint_type: {
    "MS": 0,
    "PR": 1,
    "SP": 2
  }

  def description
    "#{year}-#{mint_mark} #{name}"
  end
end
