class PagesController < ApplicationController
  def index
    @categories = Category.all.map do |cat|
      ActiveModelSerializers::SerializableResource.new(cat).as_json
    end
  end
end
