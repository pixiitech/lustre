class Series < ActiveRecord::Base
  belongs_to :category
  has_many :coin_varieties

  def plain_title
    name&.gsub(/\(.+\)/, '')&.squish
  end
end
