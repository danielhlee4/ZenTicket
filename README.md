# User Support Ticket System

## Overview
**ZenTicket** is a web application designed to help organizations manage user inquiries and issues effectively. It enables users to submit support tickets, view their status, and update them as necessary. The system also offers administrators the ability to assign priority levels, status updates, and manage comments for better communication.

## Architecture

### Frontend
- **Ticket Submission Form:** Allows users to submit new support tickets with a title, description, and priority level (assigned by admin).
- **Ticket Dashboard:** Provides a dynamic view to list all tickets with sorting, filtering, and search capabilities based on ticket attributes such as status and priority. The view dynamically adjusts based on user roles.
- **Ticket Details View:** Displays full ticket details, allowing users to view and update the ticket status. Includes a "Customer Service Thread" section for admin-user communication through comments.

### Backend
- **API Endpoints:**
  - **Authentication:**
    - `GET /login`: Display the login page (`sessions#new`).
    - `POST /login`: Log in the user (`sessions#create`).
    - `DELETE /logout`: Log out the user (`sessions#destroy`).

  - **Tickets:**
    - `GET /tickets`: Retrieve a list of all tickets (`tickets#index`).
    - `POST /tickets`: Create a new ticket (`tickets#create`).
    - `GET /tickets/new`: Display a form for creating a new ticket (`tickets#new`).
    - `GET /tickets/:id/edit`: Display a form for editing a specific ticket (`tickets#edit`).
    - `GET /tickets/:id`: Retrieve a specific ticket's details (`tickets#show`).
    - `PATCH/PUT /tickets/:id`: Update a specific ticket's details (`tickets#update`).
    - `DELETE /tickets/:id`: Delete a specific ticket (`tickets#destroy`).

  - **Comments:**
    - `POST /tickets/:ticket_id/comments`: Add a new comment to a specific ticket (`comments#create`).

- **Data Storage:** Uses PostgreSQL to persist tickets and their associated data.

### User Authentication
- Implemented authentication to ensure that users can only view and edit their own tickets.

## Setup and Installation Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/danielhlee4/ZenTicket.git
2. **Navigate to the Project Directory:**
    ```bash
    cd ZenTicket
3. **Install Dependencies:**<br>
Ensure you have Ruby and PostgreSQL installed. Then, install the required gems:
    ```bash
    bundle install
4. **Setup Database:**<br>
Configure your database settings in `config/database.yml`. Then, create and migrate the database:
    ```bash
    rails db:create
    rails db:migrate
5. **Seed the Database:**<br>
To seed the database with sample data:
    ```bash
    rails db:seed
6. **Start the Rails Server:**
    ```bash
    rails server
7. **Access the Application:**<br>
Open your browser and navigate to [http://localhost:3000/login](http://localhost:3000/login).

## Next Steps

- **Automated Email Notifications:**
  Implement functionality to automatically send email notifications to users whenever their ticket has been updated or commented on by an admin. Users can reply directly to the email to update the ticket's customer service thread. This feature will keep users informed about the status of their tickets in real-time.

- **Public vs. Internal Comments:**
  Allow admins to mark comments as either 'public' or 'internal'. Public comments will be visible to the user, while internal comments will remain private for internal use only. This will enable admins to keep internal notes while also communicating transparently with users.

- **Custom Statuses:**
  Provide admins with more flexibility and customization by allowing them to create custom statuses. These could include more granular statuses such as 'Escalated', 'In Eng Triage', or 'In Legal Review', providing better collaboration, communication, and transparency for multiple agents working on the same ticket, as well as for end users seeking updates.

- **Add Triggers and Automations:**
  Add automated rules that trigger specific actions based on ticket status changes. For example, 'Escalated' tickets could automatically be sent to specialized agents, while tickets marked as 'In Eng Triage' could be routed directly to developers. By defining trigger rules, the flow can be automated, reducing the need for manual intervention.
