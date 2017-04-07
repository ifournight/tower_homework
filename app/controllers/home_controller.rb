class HomeController < ApplicationController
  def index
    @user = current_user
    @owned_teams = current_user.owned_teams
    @joined_teams = current_user.joined_teams
  end
end
