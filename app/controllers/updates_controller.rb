require "httparty"
require "json"

class UpdatesController < ApplicationController

  def index
    @all_updates = get_updates
    @filtered_updates = @all_updates.select{|update| includes_keyword?(update)}.sort_by{|update| update["sentiment"]}

    @count = count(@all_updates)
    @percentage = (@count.to_f/@all_updates.length)*100
  end

  def get_updates
    url = "https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json"
    @response = JSON.parse(HTTParty.get(url))
  end

  def count(updates)
    keyword_count = 0;
    updates.each do |update|
      if includes_keyword?(update)
        keyword_count +=1
      end
    end
    keyword_count
  end

  def includes_keyword?(update)
    update["message"].include? "coke"  or  update["message"].include? "coca-cola" or update["message"].include? "diet-cola"
  end
end
