require 'rails_helper'

RSpec.describe Access, 'validations' do
  it do
    is_expected.to validate_presence_of(:access_type)
    is_expected.to validate_inclusion_of(:access_type)
      .in_array(Access::ACCESS_TYPE.values)
  end
end

RSpec.describe Access, 'relations' do
  it { should belong_to :user }
  it { should belong_to :subject }
end

RSpec.describe Access, '.has_access' do
  it 'verify if user has centain types of access on subject' do
    user = create(:user)
    team = create(:team, owner: user)
    project = create(:project, team: team, creator: user)
    _access = Access.create(
      user_id: user.id,
      access_type: Access::ACCESS_TYPE[:PROJECT_COLLABORATOR],
      subject_id: project.id,
      subject_type: project.class.name
    )

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
