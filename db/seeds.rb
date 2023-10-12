# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Role.create(name: 'admin')
Role.create(name: 'usuario')
Role.create(name: 'editor')

# Primero, obtén las instancias de los roles
admin_role = Role.find_by(name: 'admin')
user_role = Role.find_by(name: 'usuario')
editor_role = Role.find_by(name: 'editor')

# Crea usuarios con roles
User.create(name: 'david', email: 'david@example.com', password: 'password1', password_confirmation: 'password1', role: admin_role)
User.create(name: 'roxana', email: 'roxana@example.com', password: 'password2', password_confirmation: 'password2', role: user_role)
User.create(name: 'yull', email: 'yull@example.com', password: 'password3', password_confirmation: 'password3', role: editor_role)

