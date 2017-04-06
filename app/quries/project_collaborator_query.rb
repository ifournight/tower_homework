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
end
end
