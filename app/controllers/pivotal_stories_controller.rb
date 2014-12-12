class PivotalStoriesController < ApplicationController


  def show
    tracker_api = TrackerApi.new
    @tracker_stories = tracker_api.stories(current_user.pivotal_tracker_token, params[:id])
  end

end
