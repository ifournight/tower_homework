class ActivitiesController < ApplicationController
  def index
    @activities = []
    if Team.exists?(session[:team_id])
      @team = Team.find session[:team_id]
      projects = current_user.anticipated_projects_in_team(@team)
      project_ids = projects.map(&:id)
      @activities = Activity.where(project_id: project_ids).order('created_at DESC').to_a

      by_day = @activities.group_by_day(&:created_at)
      @activities_by_day = {}
      by_day.each do |day, group|
        @activities_by_day[day] = {}
        by_project = group.group_by(&:project_id)
        by_project.each do |id, subgroup|
          @activities_by_day[day][id] = subgroup
        end
      end

      @by_day_groups = []
      @activities_by_day.each do |day, group|
        @by_day_groups << { day: day, group: group }
      end

      @by_day_groups.sort do |a, b|
        (a[:day] <=> b[:day])
      end
      @by_day_groups.reverse!
    end
  end
end
