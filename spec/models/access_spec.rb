require 'rails_helper'

RSpec.describe Access, 'validations' do
  it do
    is_expected.to validate_presence_of(:type)
    is_expected.to validate_inclusion_of(:type)
      .in_array(Access::ACCESS_TYPE.values)
  end
end

RSpec.describe Access, '.has_access' do
  it 'verify if user has centain types of access on subject' do
    user = create(:user)
    team = create(:team, owner: user)
    project = create(:project, team: team, creator: user)
    _access = create(:access,
                     user: user,
                     type: Access::ACCESS_TYPE[:PROJECT_COLLABORATOR],
                     subject: project)

    result = Access.has_access?(user.id,
                                project.id,
                                project.class.name,
                                Access::ACCESS_TYPE[:PROJECT_COLLABORATOR])
    expect(result).to eq true
    result = Access.has_access?(user.id,
                                project.id,
                                project.class.name,
                                Access::ACCESS_TYPE[:CREATE_PROJECT])
    expect(result).to eq false
  end
end
