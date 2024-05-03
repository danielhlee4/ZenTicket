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
        status: "Open",
        user: user1,
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
  
    account_locked_ticket = Ticket.create!(
        title: "Account Locked",
        description: "Account has been locked after multiple login attempts",
        priority_level: "3 - High",
        status: "Closed",
        resolution_details: "Account unlocked. Login attempts limit increased.",
        internal_note: "User failed login attempts exceeded limit",
        user: user2,
        created_at: DateTime.new(2024, 4, 10, 12, 0, 0),
        updated_at: DateTime.new(2024, 4, 10, 17, 0, 0)
    )

    Comment.create!(
        content: "Can you share more details about the login attempts?",
        user: admin_user,
        ticket: account_locked_ticket,
        created_at: DateTime.new(2024, 4, 10, 13, 0, 0)
      )
    
    Comment.create!(
        content: "I tried to log in three times and was then locked out.",
        user: user2,
        ticket: account_locked_ticket,
        created_at: DateTime.new(2024, 4, 10, 14, 0, 0)
    )
    
    Comment.create!(
        content: "Were there any specific error messages you encountered?",
        user: admin_user,
        ticket: account_locked_ticket,
        created_at: DateTime.new(2024, 4, 10, 15, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, I received a message saying 'Account locked due to multiple failed attempts'.",
        user: user2,
        ticket: account_locked_ticket,
        created_at: DateTime.new(2024, 4, 10, 16, 0, 0)
    )
    
    Comment.create!(
        content: "Thanks for the information. We've increased the limit for login attempts.",
        user: admin_user,
        ticket: account_locked_ticket,
        created_at: DateTime.new(2024, 4, 10, 17, 0, 0)
    )
  
    feature_request_ticket = Ticket.create!(
        title: "Feature Request",
        description: "Requesting new features in the dashboard",
        status: "Open",
        user: user2,
        created_at: DateTime.new(2024, 4, 15, 14, 0, 0)
    )

    Comment.create!(
        content: "Can you specify which features you're requesting?",
        user: admin_user,
        ticket: feature_request_ticket,
        created_at: DateTime.new(2024, 4, 15, 15, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, we're looking for a way to export reports in PDF format.",
        user: user2,
        ticket: feature_request_ticket,
        created_at: DateTime.new(2024, 4, 15, 16, 0, 0)
    )
  
    data_sync_error_ticket = Ticket.create!(
        title: "Data Sync Error",
        description: "Data is not syncing between devices",
        priority_level: "2 - Medium",
        status: "In Progress",
        user: user3,
        internal_note: "Investigating cloud sync issues",
        created_at: DateTime.new(2024, 4, 20, 15, 0, 0)
    )

    Comment.create!(
        content: "When did you notice the data sync issue?",
        user: admin_user,
        ticket: data_sync_error_ticket,
        created_at: DateTime.new(2024, 4, 20, 16, 0, 0)
    )
    
    Comment.create!(
        content: "It started after the last software update.",
        user: user3,
        ticket: data_sync_error_ticket,
        created_at: DateTime.new(2024, 4, 20, 17, 0, 0)
    )
    
    Comment.create!(
        content: "Do you have any specific error messages?",
        user: admin_user,
        ticket: data_sync_error_ticket,
        created_at: DateTime.new(2024, 4, 20, 18, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, I'm seeing a 'Data sync failed' error.",
        user: user3,
        ticket: data_sync_error_ticket,
        created_at: DateTime.new(2024, 4, 20, 19, 0, 0)
    )
    
  
    Ticket.create!(
        title: "Email Notification Bug",
        description: "Email notifications are not being sent",
        status: "Open",
        user: user3,
        created_at: DateTime.new(2024, 4, 25, 9, 0, 0)
    )
  
    ui_glitch_ticket = Ticket.create!(
        title: "UI Glitch",
        description: "UI does not load properly in Safari",
        priority_level: "1 - Low",
        status: "Closed",
        resolution_details: "Safari support included",
        internal_note: "Browser compatibility testing resolved issue",
        user: user4,
        created_at: DateTime.new(2024, 4, 27, 11, 0, 0)
    )

    Comment.create!(
        content: "Can you describe the issue you're seeing in Safari?",
        user: admin_user,
        ticket: ui_glitch_ticket,
        created_at: DateTime.new(2024, 4, 27, 12, 0, 0)
    )
    
    Comment.create!(
        content: "The UI elements appear misaligned, and some buttons are not clickable.",
        user: user4,
        ticket: ui_glitch_ticket,
        created_at: DateTime.new(2024, 4, 27, 13, 0, 0)
    )
    
    Comment.create!(
        content: "Did this happen after a specific update or change?",
        user: admin_user,
        ticket: ui_glitch_ticket,
        created_at: DateTime.new(2024, 4, 27, 14, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, this started happening after the last version update.",
        user: user4,
        ticket: ui_glitch_ticket,
        created_at: DateTime.new(2024, 4, 27, 15, 0, 0)
    )
    
    Comment.create!(
        content: "We've updated the UI for better Safari compatibility. Please check if the issue is resolved.",
        user: admin_user,
        ticket: ui_glitch_ticket,
        created_at: DateTime.new(2024, 4, 27, 16, 0, 0)
    )
  
    performance_issues_ticket = Ticket.create!(
        title: "Performance Issues",
        description: "The application is slow during peak hours",
        priority_level: "2 - Medium",
        status: "In Progress",
        user: user4,
        internal_note: "Performance profiling in progress",
        created_at: DateTime.new(2024, 4, 30, 16, 0, 0)
    )

    Comment.create!(
        content: "Do you notice any particular features or actions that slow down the application?",
        user: admin_user,
        ticket: performance_issues_ticket,
        created_at: DateTime.new(2024, 4, 30, 17, 0, 0)
      )
    
    Comment.create!(
        content: "It usually happens when generating reports during high traffic periods.",
        user: user4,
        ticket: performance_issues_ticket,
        created_at: DateTime.new(2024, 4, 30, 18, 0, 0)
    )

    Ticket.create!(
        title: "Forgot Password",
        description: "Cannot remember password and password reset email is not working",
        status: "Open",
        user: user1,
        created_at: DateTime.new(2024, 4, 3, 13, 0, 0)
    )
    
    Ticket.create!(
        title: "Subscription Cancellation",
        description: "Unable to cancel subscription from user dashboard",
        status: "Open",
        user: user2,
        created_at: DateTime.new(2024, 4, 7, 12, 0, 0)
    )
    
    two_factor_issue_ticket = Ticket.create!(
        title: "Two-Factor Authentication Issue",
        description: "Unable to authenticate with 2FA enabled",
        priority_level: "3 - High",
        status: "In Progress",
        user: user3,
        internal_note: "Two-factor authentication not working with certain authenticator apps",
        created_at: DateTime.new(2024, 4, 17, 15, 0, 0)
    )

    Comment.create!(
        content: "What authenticator app are you using?",
        user: admin_user,
        ticket: two_factor_issue_ticket,
        created_at: DateTime.new(2024, 4, 17, 16, 0, 0)
    )
    
    Comment.create!(
        content: "I'm using the Authy app.",
        user: user3,
        ticket: two_factor_issue_ticket,
        created_at: DateTime.new(2024, 4, 17, 17, 0, 0)
    )
    
    Comment.create!(
        content: "Have you tried re-syncing the time in the Authy app?",
        user: admin_user,
        ticket: two_factor_issue_ticket,
        created_at: DateTime.new(2024, 4, 17, 18, 0, 0)
    )
    
    Comment.create!(
        content: "Yes, I did that, and it still isn't working.",
        user: user3,
        ticket: two_factor_issue_ticket,
        created_at: DateTime.new(2024, 4, 17, 19, 0, 0)
    )
    
    Ticket.create!(
        title: "Login Notification Bug",
        description: "Login notifications are not being sent",
        status: "Open",
        user: user4,
        created_at: DateTime.new(2024, 4, 29, 14, 0, 0)
    )
  
    puts "Tickets and comments have been created."
end