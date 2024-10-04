class CoinVariety < ActiveRecord::Base
  searchkick

  def search_data
    {
      name: name,
      year: year,
      denomination: denomination,
      search_terms: search_terms
    }
  end

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

  def search_terms
    [name, series.plain_title, designation, (PR? ? "Proof" : nil)].compact.join(' ')
  end
end
