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

## Discussion of Technologies
- **Ruby on Rails**
  - MVC Architecture: Rails uses the Model-View-Controller pattern to separate concerns cleanly, making it easier to maintain and expand the application.
  - ActiveRecord ORM: The built-in ORM provides a simple yet powerful way to interact with the database, enabling efficient database querying and management.
- **PostgreSQL**
  - Scalability: It is built to handle a high volume of concurrent transactions, making it suitable for applications that might scale over time.
  - Rails Integration: ActiveRecord, the Rails ORM, has built-in support for PostgreSQL, making it straightforward to implement and manage.
- **Bootstrap**
  - Responsive Design: Bootstrap’s grid system makes it easy to create layouts that adapt to various screen sizes, providing a seamless experience across devices.
  - Component Library: It includes pre-designed components like modals, buttons, and alerts, which speed up development and ensure a consistent UI.

## Design
1. **Associations and Data Modeling:**
  - **Tickets-Users Association:**
    - Each ticket is associated with a specific user to establish ownership, making it clear who is responsible for each ticket. This simplifies data retrieval for both admins and users.
  - **Tickets-Comments Association:**
    - Comments are associated with tickets, reflecting a one-to-many relationship. This ensures that each comment belongs to a specific ticket, which helps keep discussions focused and organized.
2. **User Roles and Access Control:**
  - **Admin Role:**
    - Admins have full access to all tickets, allowing them to oversee the system, manage tickets effectively, and handle escalated issues. This ensures they can provide guidance and support to users.
  - **Customer/Requester Role:**
    - Regular users can only access their own tickets, protecting the privacy of other users and preventing unauthorized modifications. They can interact with their tickets through comments, creating a collaborative experience while maintaining control over their own support issues.
3. **Comments as a Nested Resource:**
  - Comments are defined as a nested resource within tickets. This ensures comments are always tied to a specific ticket, making URL structures intuitive and simplifying the routing logic. It keeps the comments closely coupled to their tickets, which provides a clear context for both retrieval and creation of comments.
4. **Scoping and Access Management:**
  - **Scoped Resources:**
    - The tickets controller restricts access based on user roles. Admins have broader access, while regular users are scoped to their own tickets. This makes it easier to enforce role-based access control throughout the application.
  - **Nested Resources:**
    - Comments being nested under tickets ensures that each comment operation is directly related to its parent ticket. This scoping makes it straightforward to manage comments while maintaining context, especially when validating ticket statuses and expiration.

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
