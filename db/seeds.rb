# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ifournight = User.find_or_create_by(name: 'ifournight')
ifournighthk = User.find_or_create_by(name: 'ifournighthk')
moerlang_cat = User.find_or_create_by(name: 'moerlang_cat')
sweetkuma = User.find_or_create_by(name: 'sweetkuma')
uncle_tan = User.find_or_create_by(name: 'uncle_tan')
huahua = User.find_or_create_by(name: 'huahua')

if ifournight.owned_teams.blank?
  # team citizen 4
  citizen_4 = CreateTeam.new(creator_id: ifournight.id, team_name: 'Citizen 4').do

  AddTeamMember.new(team_id: citizen_4.id, authorizer_id: ifournight.id, member_id: sweetkuma.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:ADMIN]).do
  AddTeamMember.new(team_id: citizen_4.id, authorizer_id: ifournight.id, member_id: uncle_tan.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]).do
  AddTeamMember.new(team_id: citizen_4.id, authorizer_id: ifournight.id, member_id: huahua.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]).do
  AddTeamMember.new(team_id: citizen_4.id, authorizer_id: ifournight.id, member_id: moerlang_cat.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]).do
  AddTeamMember.new(team_id: citizen_4.id, authorizer_id: ifournight.id, member_id: ifournighthk.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]).do

  journey = CreateProject.new(creator_id: ifournight.id, team_id: citizen_4.id, project_name: 'journey', desc: '').do
  make_momo_star = CreateProject.new(creator_id: ifournight.id, team_id: citizen_4.id, project_name: 'make_momo_star', desc: '').do

  # hack
  [journey, make_momo_star].each do |project|
    [sweetkuma, uncle_tan, huahua, moerlang_cat].each do |user|
      Access::ACCESS_GROUP_MEMBER[:PROJECT].each do |access_type|
        Access.create(
          user_id: user.id,
          subject_id: project.id,
          subject_type: project.class.name,
          access_type: access_type
        )
      end
    end
  end

  CreateTodo.new(project_id: journey.id, creator_id: sweetkuma.id, title: '松坪沟').create
  CreateTodo.new(project_id: journey.id, creator_id: uncle_tan.id, title: '蒙顶山').create
  CreateTodo.new(project_id: journey.id, creator_id: uncle_tan.id, title: '青城山').create
  CreateTodo.new(project_id: journey.id, creator_id: sweetkuma.id, title: '龙苍沟').create
  CreateTodo.new(project_id: journey.id, creator_id: ifournight.id, title: '毕棚沟').create

  todo_take_picture = CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: '每天给摸摸拍照片').create
  CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: '每次带🐱出行写游记').create
  CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: "在豆瓣上建立相册'每天一摸'").create
  CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: "在豆瓣上建立相册'摸摸睡着了'").create
  CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: '把摸摸喂的白白胖胖的').create
  CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: '临时照顾摸摸').create
  todo_knack = CreateTodo.new(project_id: make_momo_star.id, creator_id: ifournight.id, title: '给摸摸喂一整袋零食').create

  SetDueTodo.new(user_id: ifournight.id,
                 due_date: '2017-04-07',
                 todo_id: todo_take_picture.id).do

  AssignTodo.new(authorizer_id: ifournight.id,
                 todo_id: todo_take_picture.id,
                 member_id: ifournight.id).do

  AssignTodo.new(authorizer_id: ifournight.id,
                 todo_id: todo_knack.id,
                 member_id: uncle_tan.id).do

  # ifournight private

  debugger
  ifournight_private = CreateTeam.new(creator_id: ifournight.id, team_name: 'ifournight_private').do

  AddTeamMember.new(team_id: ifournight_private.id, authorizer_id: ifournight.id, member_id: moerlang_cat.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]).do
  AddTeamMember.new(team_id: ifournight_private.id, authorizer_id: ifournight.id, member_id: ifournighthk.id, member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:ADMIN]).do

  v_coming = CreateProject.new(creator_id: ifournight.id, team_id: ifournight_private.id, project_name: 'v coming', desc: '').do
  tower_homework = CreateProject.new(creator_id: ifournight.id, team_id: ifournight_private.id, project_name: 'tower_homework', desc: '').do

  [moerlang_cat, ifournighthk].each do |user|
    Access::ACCESS_GROUP_ADMIN[:PROJECT].each do |access_type|
      Access.create(
        user_id: user.id,
        subject_id: v_coming.id,
        subject_type: v_coming.class.name,
        access_type: access_type
      )
    end
  end

  Access::ACCESS_GROUP_ADMIN[:PROJECT].each do |access_type|
    Access.create(
      user_id: ifournighthk.id,
      subject_id: tower_homework.id,
      subject_type: tower_homework.class.name,
      access_type: access_type
    )
  end

  CreateTodo.new(project_id: v_coming.id, creator_id: ifournighthk.id, title: 'First todo').create
  CreateTodo.new(project_id: v_coming.id, creator_id: ifournight.id, title: 'Second todo').create
  CreateTodo.new(project_id: v_coming.id, creator_id: moerlang_cat.id, title: 'Third todo').create
  birthday = CreateTodo.new(project_id: v_coming.id, creator_id: ifournight.id, title: 'Birthday coming!').create
  SetDueTodo.new(user_id: birthday.creator.id,
                 due_date: '2017-04-18',
                 todo_id: birthday.id).do

  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: '阅读理解测试题目').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: '把玩tower, trello, 重点放在动态上!!!').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: '回顾Testing Rails, 制定这个项目Test的策略').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Activity Model Design').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Activity Dynamic View Design').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Activity Coding').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Todo Model Design').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'User Model Design').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'User, Todo Coding').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Team Project Access Model Design').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Team Project Access Model Coding').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'More Activity Coding').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Seed data, sample project').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Seed data, sample project').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: '整理，更新RSpec').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: '提交，写README').create

end
