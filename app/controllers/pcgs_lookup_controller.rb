class PcgsLookupController < ApplicationController
  def index
    @cert_no = params[:cert_no]
    resp = fetch_data

    render json: resp
  end

  private

  def fetch_data
    HTTParty.get(
      "#{ENV.fetch("PCGS_URL")}GetCoinFactsByCertNo/#{@cert_no}?retrieveAllData=true",
      headers: { Authorization: "Bearer #{ENV.fetch("PCGS_API_TOKEN")}"}
    )
  end
end
