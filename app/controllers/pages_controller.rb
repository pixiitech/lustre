class PagesController < ApplicationController
  def index
    @categories = Category.all.map do |cat|
      ActiveModelSerializers::SerializableResource.new(cat).as_json
    end
    if params['category']
      cat = Category.find(params['category'])
      @category = ActiveModelSerializers::SerializableResource.new(cat).as_json
    end
    if params['series']
      series = Series.find(params['series'])
      @series = ActiveModelSerializers::SerializableResource.new(series).as_json
    end
    if params['coin']
      coin = CoinVariety.find(params['coin'])
      @coin = ActiveModelSerializers::SerializableResource.new(coin).as_json
    end
    
    @mint_type = params['mint_type']
    @grade = params['grade']
  end
end
