require "httparty"
require "json"

class UpdatesController < ApplicationController

  def index
    @all_updates = get_updates
    @filtered_updates = @all_updates.select{|update| includes_keyword?(update)}
  end

  def get_updates
    url = "https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json"
    @response = JSON.parse(HTTParty.get(url))
  end

  def includes_keyword?(update)
    update["message"].include? "coke"  or  update["message"].include? "coca-cola" or update["message"].include? "diet-cola"
  end
end
