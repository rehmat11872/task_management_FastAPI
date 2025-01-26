
### README for Setting Up the Project

### Project Overview
This project is a Python-based application using the FastAPI framework and configured to use a PostgreSQL database. The project requires a `.env` file for environment-specific configurations, including database settings, application environment variables, and Docker setup.

Follow the steps below to clone, set up, and run the project.

---

### Prerequisites

Make sure the following tools are installed on your system:

1. **Python 3.10 or higher**  
   You can download Python from [https://python.org](https://python.org).
   
2. **PostgreSQL Database**  
   Install PostgreSQL from [https://www.postgresql.org/](https://www.postgresql.org/).

3. **Git** (to clone the repository)  
   You can download Git from [https://git-scm.com/](https://git-scm.com/).

4. **Virtual Environment Manager**  
   Such as `venv` (comes built into Python) or `virtualenv`.

5. **Docker** (Required for containerized application setup and database environment).

---

### Steps to Set Up the FastAPI Project

#### Step 1: Clone the Repository
Run the following command in your terminal to clone the repository:

```bash
git clone <repository_url>
```

Replace `<repository_url>` with the URL of the Git repository.

---

#### Step 2: Set up a Virtual Environment
Navigate to the project's root directory and set up a Python virtual environment:

```bash
cd <project_directory>
python3 -m venv venv
```

Activate the virtual environment:

- **MacOS/Linux**:
  ```bash
  source venv/bin/activate
  ```

- **Windows**:
  ```cmd
  venv\Scripts\activate
  ```
If you prefer using Docker, you can skip setting up a virtual environment locally.

---

#### Step 3: Initial Poetry 

```bash
poetry init
poetry env info --path
souce .venv/bin/activate
potry install


```

---

#### Step 4: Configure the `.env` File
Create a `.env` file in the root directory of your project if it doesn't already exist. This file will provide environment-specific configurations for the project and Docker.

An example `.env` file is as follows:

```env
# Database configuration
DATABASE_URL=postgresql://task_user:task_password@db:5432/task_db

# App settings
APP_ENV=development
APP_DEBUG=True

# Other configurations
# SECRET_KEY=your_secret_key_here
```

**Key Notes**:
- `DATABASE_URL` should point to your PostgreSQL instance or Dockerized database.
- Replace `your_secret_key_here` with a strong, unique secret key.
- Ensure `APP_ENV` matches your intended development or production environment.

---

#### Step 5: Set Up FastAPI and the Database with Docker
- **If you're using Docker**, you can set up the database using a `docker-compose.yml` file. If your project includes this configuration, start the database container with:
  ```bash
  docker-compose --build
  docker-compose up
  ```

- **If you're setting up PostgreSQL manually**:
  1. Create a new database named `task_db` if not using Docker.
  2. Create a PostgreSQL user (`task_user`) with access to the database if not using Docker.
  3. Update the `.env` file to reflect your database connection details. With Docker, use default settings as shown in the example `.env`.

---

#### Step 6: If port already use
Ensure the database schema is up to date by applying migrations (if the project uses an ORM such as SQLAlchemy):

```bash
sudo lsof -i :5432
sudo systemctl stop postgresql
docker ps
docker stop <container_id>
docker-compose up --build

```
---

#### Step 7: Run the FastAPI Application
Start the application in development mode:

To start the project with Docker, use:
```bash
docker-compose up --build -d
```

Access the FastAPI application at:
```bash
http://127.0.0.1:8000/docs
```

```bash
If running the application locally without Docker, use:
```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

#### Step 8: Access the App
Your application should now be running. Access it in your web browser at:

```
http://127.0.0.1:8000
```

---

### Optional Steps

#### Testing the Application
Run tests to ensure everything is working properly:

```bash
pytest
```

#### Linting and Code Quality
If your project uses linters like `flake8`, you can run it to check code formatting:

```bash
flake8
```
### Access Db by command in docker

```bash
# Connect to the database
docker-compose exec db psql -U task_user -d task_db

# Verify connection
\c task_db

# List tables
\dt


# Select all users
SELECT * FROM users;

# Select all tasks
SELECT * FROM tasks;

# Delete a specific record
DELETE FROM users WHERE id = 1;

# delete all users 
DELETE FROM users;


```
---

### Troubleshooting

- **Database connection issues**: Double-check that your PostgreSQL instance is running, and ensure the `DATABASE_URL` in the `.env` file matches your setup.
- **Missing dependencies**: If some Python libraries are not found, check the `requirements.txt` file and install any missing packages.
- **Debugging in development**: Set `APP_DEBUG=True` in your `.env` file for better error logs.
- **Debugging in development**: Set `APP_DEBUG=True` in your `.env` file for better error logs and use the FastAPI interactive API documentation at `/docs`.
---

### Contributing
If you'd like to contribute, please fork the repository, create a new branch, and submit a pull request with your changese...

---

This README provides a step-by-step guide to help you set up and run the project successfully. If you experience any issues or require assistance, feel free to contact the project maintainer. Happy coding!
