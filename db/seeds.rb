# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do 
    puts "Destroying tables..."

    [User, Ticket].each(&:destroy_all)
  
    puts "Resetting primary keys..."
    # For easy testing, so that after seeding, the first `User` has `id` of 1
    ['users', 'tickets'].each do |table_name|
      ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end
end

puts "Creating users..."

admin_user = User.create!(
    email: 'demo@admin.io', 
    password: 'password',
    admin: true
)

user1 = User.create!(email: 'demo@user.io', password: 'password', admin: false)
user2 = User.create!(email: 'demo1@user.io', password: 'password', admin: false)
user3 = User.create!(email: 'demo2@user.io', password: 'password', admin: false)
user4 = User.create!(email: 'demo3@user.io', password: 'password', admin: false)

puts "Creating tickets..."

Ticket.create!(
    title: "Login Issue", 
    description: "Cannot log into account", 
    priority_level: "High", 
    status: "Open", 
    user: user1
    )

Ticket.create!(
    title: "Payment Issue", 
    description: "Payment processing failed", 
    priority_level: "Medium", 
    status: "In Progress", 
    user: user1
    )

Ticket.create!(
    title: "Account Locked", 
    description: "Account has been locked after multiple login attempts", 
    priority_level: "High", 
    status: "Closed", 
    resolution_details: "Account unlocked. Login attempts limit increased.", 
    user: user2
    )

Ticket.create!(
    title: "Feature Request", 
    description: "Requesting new features in the dashboard", 
    priority_level: "Low", 
    status: "Open", 
    user: user2
    )

Ticket.create!(
    title: "Data Sync Error", 
    description: "Data is not syncing between devices", 
    priority_level: "Medium", 
    status: "In Progress", 
    user: user3
    )

Ticket.create!(
    title: "Email Notification Bug", 
    description: "Email notifications are not being sent", 
    priority_level: "High", 
    status: "Open", 
    user: user3
    )

Ticket.create!(
    title: "UI Glitch", 
    description: "UI does not load properly in Safari", 
    priority_level: "Low", 
    status: "Closed",
    resolution_details: "Safari support included", 
    user: user4
    )

Ticket.create!(
    title: "Performance Issues", 
    description: "The application is slow during peak hours", 
    priority_level: "Medium", 
    status: "In Progress", 
    user: user4
    )

puts "Users and their tickets have been created."
