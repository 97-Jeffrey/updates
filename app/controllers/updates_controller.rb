require "httparty"
require "json"

class UpdatesController < ApplicationController

  def index
    get_updates
  end

  def get_updates
    url = "https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json"
    @response = JSON.parse(HTTParty.get(url))
  end
end
