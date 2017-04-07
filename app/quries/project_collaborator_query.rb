class ProjectCollaboratorQuery
  def find_project_collaborators(project)
    temp = Access
           .where(
             subject_id: project.id,
             subject_type: project.class.name,
             access_type: Access::ACESS_TYPE[:PROJECT_COLLABORATOR]
           )
           .to_a
    if block_given?
      temp.each do |access|
        yield(access.user)
      end
    else
      temp.map(&:user)
    end
  end

  def find_user_anticipated_projects_in_team(user, team)
    projects = team.projects.to_a.keep_if do |project|
      is_user_a_collaborator(user, project)
    end
  end

  def is_user_a_collaborator(user, project)
    Access.has_access?(
      user.id,
      project.id,
      project.class.name,
      Access::ACCESS_TYPE[:PROJECT_COLLABORATOR]
    )
  end
end
