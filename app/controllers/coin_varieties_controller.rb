class CoinVarietiesController < ApplicationController
  def index
    @series = Series.find(params[:series_id])

    render json: @series.coin_varieties.order(year: :asc)
  end

  def show
    @coin_variety = CoinVariety.find(params[:id])

    fetch_data
    unless @coin_variety.pcgs_link.present?
      @coin_variety.update(
        denomination: @data['Denomination'],
        mintage: @data['Mintage'],
        metal_content: @data['MetalContent'],
        diameter: @data['Diameter'],
        edge: @data['Edge'],
        weight: @data['Weight'],
        population: @data['Population'],
        pcgs_link: @data['CoinFactsLink'],
        designer: @data['Designer'],
        pcgs_notes: @data['CoinFactsNotes'],
        images: @data['Images']
      )
    end
    @grade = @coin_variety.grade_values.find_or_create_by(grade: params[:grade])
    @grade.update(value: @data['PriceGuideValue'])

    render json: @grade
  end

  private

  def fetch_data
    @data = HTTParty.get(
      "#{ENV.fetch("PCGS_URL")}GetCoinFactsByGrade?PCGSNo=#{@coin_variety.pcgs_id}&GradeNo=#{params[:grade]}&PlusGrade=false",
      headers: { Authorization: "Bearer #{ENV.fetch("PCGS_API_TOKEN")}"}
    )
  end
end
