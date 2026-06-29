# Step-by-Step Instructions to Run Staff Leave Management System

## Prerequisites
- Python 3.8 or higher installed
- pip (Python package manager)

---

## Step 1: Open Terminal/Command Prompt
- **Windows**: Press `Win + R`, type `cmd` or `powershell`, press Enter
- Or right-click on the project folder and select "Open in Terminal"

---

## Step 2: Navigate to Project Directory
Open terminal in the project root (where `slms` folder is located), then:
```powershell
cd slms
```

---

## Step 3: Check Python Installation
Check if Python is installed:
```powershell
python --version
```
OR
```powershell
py --version
```

If Python is not found, install Python from https://www.python.org/downloads/

---

## Step 4: Create Virtual Environment (Recommended)
**Windows PowerShell:**
```powershell
python -m venv venv
```
OR
```powershell
py -m venv venv
```

**Windows CMD:**
```cmd
python -m venv venv
```
OR
```cmd
py -m venv venv
```

---

## Step 5: Activate Virtual Environment
**Windows PowerShell:**
```powershell
.\venv\Scripts\Activate.ps1
```

If you get an execution policy error, run this first:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Then try activating again.

**Windows CMD:**
```cmd
venv\Scripts\activate.bat
```

You should see `(venv)` at the beginning of your command prompt when activated.

---

## Step 6: Install Dependencies
With virtual environment activated, install required packages:
```powershell
pip install -r requirements.txt
```

This will install:
- Django 4.2
- Pillow (for image handling)

---

## Step 7: Run Database Migrations
Create/update database tables:
```powershell
python manage.py migrate
```
OR
```powershell
py manage.py migrate
```

---

## Step 8: Create Admin Account (Superuser)
Create an admin account to login:
```powershell
python manage.py createsuperuser
```

**When prompted, enter:**
- Username: (press Enter or enter any username)
- Email address: **admin@example.com** (This is IMPORTANT - you'll login with email)
- Password: (enter a secure password)
- Password (again): (confirm password)

---

## Step 9: Set Admin User Type
After creating superuser, you need to set user_type to '1' for admin access.

**Option A - Using Django Shell:**
```powershell
python manage.py shell
```

Then type these commands one by one:
```python
from slmsapp.models import CustomUser
user = CustomUser.objects.filter(is_superuser=True).first()
user.user_type = '1'
user.save()
print("Admin user configured successfully!")
exit()
```

**Option B - Through Django Admin (if you can access it):**
1. Start the server first (Step 10)
2. Go to http://127.0.0.1:8000/admin/
3. Login with your superuser credentials
4. Go to Users section
5. Edit your user
6. Set "User type" to '1' (admin)
7. Save

---

## Step 10: Start Development Server
Start the Django development server:
```powershell
python manage.py runserver
```
OR
```powershell
py manage.py runserver
```

You should see output like:
```
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.
```

---

## Step 11: Access the Application
Open your web browser and go to:

1. **Landing Page**: http://127.0.0.1:8000/
2. **Login Page**: http://127.0.0.1:8000/Login
3. **Django Admin**: http://127.0.0.1:8000/admin/

---

## Step 12: Login
- **Email**: Use the email you entered when creating superuser
- **Password**: Use the password you set

After login:
- **Admin users (user_type = '1')**: Will be redirected to admin dashboard
- **Staff users (user_type = '2')**: Will be redirected to staff dashboard

---

## Quick Command Summary
For quick reference, here are all commands in order:

```powershell
# Navigate to project
cd slms

# Create virtual environment
python -m venv venv

# Activate virtual environment (PowerShell)
.\venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Set admin user type (after creating superuser)
python manage.py shell
# Then in Python shell:
# from slmsapp.models import CustomUser
# user = CustomUser.objects.filter(is_superuser=True).first()
# user.user_type = '1'
# user.save()
# exit()

# Start server
python manage.py runserver
```

---

## Troubleshooting

### Issue: "python is not recognized"
- Try using `py` instead of `python`
- Make sure Python is installed and added to PATH

### Issue: "pip is not recognized"
- Install pip: `python -m ensurepip --upgrade`
- Or use: `python -m pip install -r requirements.txt`

### Issue: Virtual environment activation error
- PowerShell: Run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Or use CMD instead of PowerShell

### Issue: Port 8000 already in use
- Use a different port: `python manage.py runserver 8080`
- Or stop the process using port 8000

### Issue: Migration errors
- Delete `db.sqlite3` file (backup first if needed)
- Delete all files in `slmsapp/migrations/` except `__init__.py`
- Run: `python manage.py makemigrations`
- Run: `python manage.py migrate`

### Issue: Media files not showing
- Ensure `media` folder exists in `slms` directory
- Check file permissions

---

## Creating Staff Accounts

After logging in as admin:

1. Go to "Staff" → "Add Staff"
2. Fill in the form:
   - Profile Picture (required)
   - First Name
   - Last Name
   - Email
   - Username
   - Password
   - Gender
   - Address
3. Click "Add Staff"
4. Staff account will be created with user_type = '2'

---

## Stopping the Server

To stop the development server:
- Press `CTRL + C` in the terminal
- Or close the terminal window

---

## Next Steps After Setup

1. **Login as Admin** using the email and password you created
2. **Add Staff Members** through the admin panel
3. **Staff members** can then login and apply for leave
4. **Admin** can view and approve/disapprove leave requests

---

## Notes

- The project uses SQLite database (db.sqlite3)
- Default DEBUG mode is ON (for development only)
- All uploaded files are stored in `media/` folder
- Static files are in `static/` folder


