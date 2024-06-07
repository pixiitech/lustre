class Series < ActiveRecord::Base
  belongs_to :category
  has_many :coin_varieties
end
