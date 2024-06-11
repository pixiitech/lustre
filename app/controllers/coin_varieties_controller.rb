class CoinVarietiesControllers < ApplicationController
  def show
    @coin_variety = CoinVariety.find(id: params[:id])

    respond_to do
      format.json { fetch_data }
    end
  end

  private

  def fetch_data
    HTTParty.get(
      "#{ENV.fetch("PCGS_URL")}?PCGSNo=#{@coin_variety.pcgs_id}&GradeNo=#{params[:grade]}&PlusGrade=false",
      headers: { Authorization: "Bearer #{ENV.fetch("PCGS_API_TOKEN")}"}
    )
  end
end
