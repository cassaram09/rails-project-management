# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@jon = User.create(name: "Jon Snow", email: "jon@thewall.westeros", password: "hello123")
@ollie = User.create(name: "Ollie", email: "ollie@thewall.westeros", password: "hello123")

@project = Project.create(owner_id: 1, name: "Defend the Wall", description: "defend the wall from the wildings", due_date: "2016-07-23", status: 0)
@task = Task.create(project_id: 1, owner_id: 1, name: "Secure the tunnel", description: "flood the tunnel so it can't be be breached by the wildings", due_date: "2016-07-23" )
@comment = Comment.create(user_id: 2, task_id: 1, content: "For the watch!")

@note = Note.create(user_id: 1, project_id: 1, title: "Watch out for climbers", content: "If the climbers start to come up the wall, drop the scythe on them. That should hold them off, for a little while anyways.")
@project.collaborators << [@ollie]
@project.save