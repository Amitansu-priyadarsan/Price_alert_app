
# Price Alert Application

The Price Alert Application is a cryptocurrency price monitoring system that allows users to create alerts for specific cryptocurrency prices. When the price of a selected cryptocurrency meets or exceeds the user-defined target price, an email notification is sent to the user. The application utilizes Sidekiq and Redis for background processing and SendGrid for email notifications.

## Project Structure

```bash
price_alert_app/
├── app/
│   ├── controllers/
│   │   ├── alerts_controller.rb
│   │   └── users_controller.rb
│   ├── models/
│   │   ├── alert.rb
│   │   └── user.rb
│   ├── services/
│   │   ├── price_check_service.rb
│   │   └── email_service.rb
│   ├── mailers/
│   │   └── alert_mailer.rb
│   ├── jobs/
│   │   └── price_check_job.rb
├── config/
│   ├── database.yml
│   ├── routes.rb
│   ├── schedule.rb
├── db/
│   ├── migrate/
│   │   ├── create_users.rb
│   │   └── create_alerts.rb
├── Dockerfile
├── docker-compose.yml
├── Gemfile
├── Gemfile.lock
├── README.md
```

## Architecture

- **Controllers**: Handle HTTP requests and responses. They interact with models and services to perform actions.
  - `alerts_controller.rb`: Manages alert creation, retrieval, and deletion.
  - `users_controller.rb`: Manages user-related actions (authentication not fully detailed here).

- **Models**: Represent data and interact with the database.
  - `alert.rb`: Defines the `Alert` model with attributes such as cryptocurrency, target price, and status.
  - `user.rb`: Defines the `User` model with authentication details.

- **Services**: Contain business logic for the application.
  - `price_check_service.rb`: Fetches current cryptocurrency prices and handles alert triggering.
  - `email_service.rb`: Contains email client(Use to send email).

- **Mailers**: Manage email notifications.
  - `alert_mailer.rb`: Handles sending email notifications when price alerts are triggered.

- **Jobs**: Define background jobs for Sidekiq.
  - `price_check_job.rb`: Periodically checks prices and triggers alerts.

- **Config**: Configuration files.
  - `database.yml`: Database configuration.
  - `routes.rb`: Defines the application's routes.
  - `schedule.rb`: Defines Sidekiq cron jobs.

- **Database Migrations**: Manage database schema changes.
  - `create_users.rb`: Migration to create the users table.
  - `create_alerts.rb`: Migration to create the alerts table.

- **Docker and Docker Compose Files**:
  - `Dockerfile`: Defines the Docker image for the application.
  - `docker-compose.yml`: Defines services, networks, and volumes for Docker Compose.

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd price_alert_app
   ```

2. **Create a `.env` file:**

   Create a `.env` file in the root directory with the following content:

   ```env
   DATABASE_USERNAME=your_database_username
   DATABASE_PASSWORD=your_database_password
   SENDGRID_API_KEY=your_sendgrid_api_key
   SENDGRID_SENDER_EMAIL=your_sendgrid_sender_email
   SECRET_KEY_BASE=your_rails_secret_key_base
   ```

3. **Build and run the Docker containers:**

   ```bash
   docker-compose up --build
   ```

   This command will build the Docker images and start the containers for the Rails application, PostgreSQL database, Redis, and Sidekiq.

4. **Run database migrations:**

   Open a new terminal and run:

   ```bash
   docker-compose exec web rake db:migrate
   ```

5. **Access the application:**

   Open your browser and navigate to:

   ```bash
   http://localhost:3000
   ```

## Testing with Postman

To test the API endpoints, use Postman with the following details:

1. **Create User:**

   - **Endpoint:** `POST /users/create`
   - **Request Body:**
     ```json
     {
       "user": {
         "email": "user@example.com",
         "password": "password123"
       }
     }
     ```
   - **Response:**
     ```json
     {
       "id": 1,
       "email": "user@example.com",
       "created_at": "2024-07-31T04:42:03.831Z",
       "updated_at": "2024-07-31T04:42:03.831Z"
     }
     ```

2. **Login User:**

   - **Endpoint:** `POST /users/login`
   - **Request Body:**
     ```json
     {
       "user": {
         "email": "user@example.com",
         "password": "password123"
       }
     }
     ```
   - **Response:**
     ```json
     {
       "token": "your_jwt_token"
     }
     ```

3. **Create Alert:**

   - **Endpoint:** `POST /alerts/create`
   - **Headers:** `Authorization: Bearer your_jwt_token`
   - **Request Body:**
     ```json
     {
       "alert": {
         "cryptocurrency": "bitcoin",
         "target_price": 50000
       }
     }
     ```
   - **Response:**
     ```json
     {
       "id": 1,
       "user_id": 1,
       "cryptocurrency": "bitcoin",
       "target_price": 50000.0,
       "status": "created",
       "created_at": "2024-07-31T04:42:03.831Z",
       "updated_at": "2024-07-31T04:42:03.831Z"
     }
     ```

4. **Delete Alert:**

   - **Endpoint:** `DELETE /alerts/:id`
   - **Headers:** `Authorization: Bearer your_jwt_token`
   - **Response:**
     ```json
     {
       "message": "Alert deleted successfully"
     }
     ```

5. **List Alerts:**

   - **Endpoint:** `GET /alerts`
   - **Headers:** `Authorization: Bearer your_jwt_token`
   - **Response:**
     ```json
     [
       {
         "id": 1,
         "user_id": 1,
         "cryptocurrency": "bitcoin",
         "target_price": 50000.0,
         "status": "created",
         "created_at": "2024-07-31T04:42:03.831Z",
         "updated_at": "2024-07-31T04:42:03.831Z"
       }
     ]
     ```

### Monitoring Sidekiq

To monitor Sidekiq jobs, navigate to the Sidekiq web UI:

```bash
http://localhost:3000/sidekiq
```

## Troubleshooting

### Checking Logs

- **Application Logs:**

  Check the logs of the Rails application:

  ```bash
  docker-compose logs web
  ```

- **Sidekiq Logs:**

  Check the logs of Sidekiq:

  ```bash
  docker-compose logs sidekiq
  ```

### Checking Email Delivery

- **SendGrid Dashboard:**

  Log into your SendGrid account and check the Email Activity section to see if emails are being sent and if there are any errors.

- **Application Logs:**

  Ensure that the logs show email delivery status:

  ```bash
  Email sent with status code 202
  ```

## Conclusion

This project demonstrates a complete cryptocurrency price alert system with user authentication, alert management, and email notifications. Docker ensures an efficient setup and deployment process, while Postman facilitates comprehensive API testing.



This `README.md` provides a comprehensive guide for setting up, running, and testing your project, including detailed information on the project structure, Docker setup, Postman testing, and troubleshooting.
