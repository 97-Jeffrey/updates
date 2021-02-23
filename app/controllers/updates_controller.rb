require "httparty"

class UpdatesController < ApplicationController

  # All logics of sorting, filtering, and counting are implemented by controllers' methods, then passed into index action as variables, so index.html.erb is just for render html and ruby variables.
  
  # So index action knows nothing about logics, it only care about returned variables from methods, if tomorrow we want to change keywords or orders of display, we just make changes in methods that implement the logics.
  
  def index
    @all_updates = get_updates
    @filtered_updates = @all_updates.select{|update| includes_keyword?(update)}
    @sorted_updates = sort_update(@filtered_updates)

    @count = count(@all_updates)
    @percentage = (@count.to_f/@all_updates.length)*100
  end

  def show
    @update = get_updates.select{|update| update["id"].to_s== params[:id]}[0]
  end

  # This method is for retrieving all updates from API.
  # httparty is ideal for fetching API, we can use class method to retrieve data quickly.
  def get_updates
    url = "https://raw.githubusercontent.com/Vericatch/devtestapiapp/master/mock_response.json"
    @response = JSON.parse(HTTParty.get(url))
  end

  # Identify numbers of updates with keywords:
  def count(updates)
    keyword_count = 0;
    updates.each do |update|
      if includes_keyword?(update)
        keyword_count +=1
      end
    end
    keyword_count
  end

  # sort each update from minimum sentiment to maximum sentiment:
  def sort_update(updates)
    updates.sort_by{|update| update["sentiment"]}
  end

  # filtering conditional:
  def includes_keyword?(update)
    update["message"].include? "coke"  or  update["message"].include? "coca-cola" or update["message"].include? "diet-cola"
  end
end
