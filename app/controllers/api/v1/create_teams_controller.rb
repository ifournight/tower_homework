class Api::V1::CreateTeamsController < ApplicationController
  def create
    @create_team = CreateTeam.new(create_team_params)
    @team = @create_team.do

    if @team
      render json: @team, status: :created
    else
      render json: { errors: @create_team.errors.full_messages },
             status: @create_team.status_code
    end
  end

  private

  def create_team_params
    params.require(:create_team).permit(:creator_id, :team_name)
  end
end
