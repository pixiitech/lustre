class PcgsLookupController < ApplicationController
  def index
    @cert_no = params[:cert_no]
    resp = fetch_data

    render json: resp
  end

  private

  def fetch_data
    data = HTTParty.get(
      "#{ENV.fetch("PCGS_URL")}GetCoinFactsByCertNo/#{@cert_no}?retrieveAllData=true",
      headers: { Authorization: "Bearer #{ENV.fetch("PCGS_API_TOKEN")}"}
    )
    coin_variety = CoinVariety.find_by(pcgs_id: data['PCGSNo'])
    data.merge(image_url_template: coin_variety&.series&.photo_url)
  end
end
