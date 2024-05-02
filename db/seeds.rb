# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do
    puts "Destroying tables..."
  
    [User, Ticket, Comment].each(&:destroy_all)
  
    puts "Resetting primary keys..."
    # For easy testing, so that after seeding, the first `User` has `id` of 1
    ['users', 'tickets', 'comments'].each do |table_name|
        ApplicationRecord.connection.reset_pk_sequence!(table_name)
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

    puts "Users have been created."
  
    puts "Creating tickets and comments..."
  
    Ticket.create!(
        title: "Login Issue",
        description: "Cannot log into account",
        priority_level: "3 - High",
        status: "Open",
        user: user1,
        internal_note: "High priority due to multiple reports",
        created_at: DateTime.new(2024, 4, 1, 10, 0, 0)
    )
  
    payment_issue_ticket = Ticket.create!(
        title: "Payment Issue",
        description: "Payment processing failed",
        priority_level: "2 - Medium",
        status: "In Progress",
        user: user1,
        internal_note: "Investigating payment gateway issues",
        created_at: DateTime.new(2024, 4, 5, 11, 0, 0)
    )

    Comment.create!(
        content: "Could you provide more details on the payment gateway used?",
        user: admin_user,
        ticket: payment_issue_ticket,
        created_at: DateTime.new(2024, 4, 5, 12, 0, 0)
      )
    
    Comment.create!(
        content: "We're using Stripe for processing our payments.",
        user: user1,
        ticket: payment_issue_ticket,
        created_at: DateTime.new(2024, 4, 5, 13, 0, 0)
    )
    
    Comment.create!(
        content: "Got it. Have you noticed any specific error messages?",
        user: admin_user,
        ticket: payment_issue_ticket,
        created_at: DateTime.new(2024, 4, 5, 14, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, we're seeing a 'Payment Failed' error.",
        user: user1,
        ticket: payment_issue_ticket,
        created_at: DateTime.new(2024, 4, 5, 15, 0, 0)
    )
  
    Ticket.create!(
        title: "Account Locked",
        description: "Account has been locked after multiple login attempts",
        priority_level: "3 - High",
        status: "Closed",
        resolution_details: "Account unlocked. Login attempts limit increased.",
        internal_note: "User failed login attempts exceeded limit",
        user: user2,
        created_at: DateTime.new(2024, 4, 10, 12, 0, 0)
    )
  
    Ticket.create!(
        title: "Feature Request",
        description: "Requesting new features in the dashboard",
        priority_level: "1 - Low",
        status: "Open",
        user: user2,
        internal_note: "Enhancement request, not urgent",
        created_at: DateTime.new(2024, 4, 15, 14, 0, 0)

    )
  
    Ticket.create!(
        title: "Data Sync Error",
        description: "Data is not syncing between devices",
        priority_level: "2 - Medium",
        status: "In Progress",
        user: user3,
        internal_note: "Investigating cloud sync issues",
        created_at: DateTime.new(2024, 4, 20, 15, 0, 0)
    )
  
    Ticket.create!(
        title: "Email Notification Bug",
        description: "Email notifications are not being sent",
        priority_level: "3 - High",
        status: "Open",
        user: user3,
        internal_note: "Critical impact on user notifications",
        created_at: DateTime.new(2024, 4, 25, 9, 0, 0)
    )
  
    Ticket.create!(
        title: "UI Glitch",
        description: "UI does not load properly in Safari",
        priority_level: "1 - Low",
        status: "Closed",
        resolution_details: "Safari support included",
        internal_note: "Browser compatibility testing resolved issue",
        user: user4,
        created_at: DateTime.new(2024, 4, 27, 11, 0, 0)
    )
  
    Ticket.create!(
        title: "Performance Issues",
        description: "The application is slow during peak hours",
        priority_level: "2 - Medium",
        status: "In Progress",
        user: user4,
        internal_note: "Performance profiling in progress",
        created_at: DateTime.new(2024, 4, 30, 16, 0, 0)
    )

    Ticket.create!(
        title: "Forgot Password",
        description: "Cannot remember password and password reset email is not working",
        priority_level: "3 - High",
        status: "Open",
        user: user1,
        internal_note: "Password reset email delivery issues",
        created_at: DateTime.new(2024, 4, 3, 13, 0, 0)
    )
    
    Ticket.create!(
        title: "Subscription Cancellation",
        description: "Unable to cancel subscription from user dashboard",
        priority_level: "2 - Medium",
        status: "Open",
        user: user2,
        internal_note: "User dashboard lacks cancellation feature",
        created_at: DateTime.new(2024, 4, 7, 12, 0, 0)
    )
    
    Ticket.create!(
        title: "Two-Factor Authentication Issue",
        description: "Unable to authenticate with 2FA enabled",
        priority_level: "3 - High",
        status: "In Progress",
        user: user3,
        internal_note: "Two-factor authentication not working with certain authenticator apps",
        created_at: DateTime.new(2024, 4, 17, 15, 0, 0)
    )
    
    Ticket.create!(
        title: "Login Notification Bug",
        description: "Login notifications are not being sent",
        priority_level: "1 - Low",
        status: "Open",
        user: user4,
        internal_note: "Investigating issue with login notification feature",
        created_at: DateTime.new(2024, 4, 29, 14, 0, 0)
    )
  
    puts "Tickets and comments have been created."
end
  