# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ifournight = User.find_or_create_by(name: 'ifournight')

if ifournight.owned_teams.blank?
  citizen_4 = CreateTeam.new(creator_id: ifournight.id, team_name: 'Citizen 4').do

  v_project = CreateProject.new(creator_id: ifournight.id, team_id: citizen_4.id, project_name: 'V coming', desc: '').do
  tower_homework = CreateProject.new(creator_id: ifournight.id, team_id: citizen_4.id, project_name: 'tower_homework', desc: '').do

  CreateTodo.new(project_id: v_project.id, creator_id: ifournight.id, title: 'First todo').create
  CreateTodo.new(project_id: v_project.id, creator_id: ifournight.id, title: 'Second todo').create
  CreateTodo.new(project_id: v_project.id, creator_id: ifournight.id, title: 'Third todo').create

  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'First todo').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Second todo').create
  CreateTodo.new(project_id: tower_homework.id, creator_id: ifournight.id, title: 'Third todo').create


  birthday = CreateTodo.new(project_id: v_project.id, creator_id: ifournight.id, title: 'Birthday coming!').create
  SetDueTodo.new(user_id: birthday.creator.id,
                 due_date: '2017-04-18',
                 todo_id: birthday.id).do

end
