# HACK-Portfolio & Database Administration Portal

A dynamic web application built using **ASP.NET Web Forms (C#)** and **MySQL**. It serves as an interactive digital portfolio displaying achievements, activities, and resources, integrated with a secure user authentication system and a central database administration console.

---

## 🚀 Key Features

*   **👤 Authentication & Profiles:** Fully validated user registration (sign-up) and login flow. Users can edit profile details, update passwords, and manage account statuses.
*   **📨 Contact Messaging Portal:** A database-backed contact form allowing visitors to leave structured inquiries.
*   **🛠️ Database Management Panel (`managedb.aspx`):** An administrative dashboard providing CRUD operations. Administrators can view, track, and delete users or contact inquiries in real-time.
*   **📉 Auto-Sequential IDs (Transaction-Safe):** Includes a custom reindexing engine. When a user or contact is deleted:
    1.  The system re-sequences all primary keys (`UserID` and `ContactID`) continuously starting from `1` (`1, 2, 3...`).
    2.  It resets the MySQL `AUTO_INCREMENT` state to prevent gap fragmentation in the ID structure.
    3.  Operations are enclosed in database **Transactions** to ensure atomic consistency.

---

## 🛠️ Tech Stack

*   **Backend:** C# / ASP.NET Web Forms (.NET Framework)
*   **Frontend:** HTML5, CSS3, Vanilla JavaScript
*   **Database:** MySQL with ADO.NET (`MySql.Data`)
*   **Development Tools:** Visual Studio, IIS Express

---

## 📂 Project Structure

```text
project1/
├── App_Data/                # App data storage
├── bin/                     # Compiled binaries and references (MySQL dll)
├── obj/                     # Intermediate build output
├── img/                     # Static image assets
├── style.css                # Global stylesheet for layout & design aesthetics
│
├── Site.Master              # Main master page defining navbar and footer
├── index.aspx               # Main landing page
├── about.aspx               # About me/us section
├── achievements.aspx        # Achievements tracker
├── activities.aspx          # Portfolio activities list
├── contact.aspx             # Guest message form
│
├── signin.aspx              # Login portal
├── signup.aspx              # User registration portal
├── profile.aspx             # User dashboard / Profile management
├── managedb.aspx            # Administrative panel (User/Contact GridViews)
│
├── DatabaseHelper.cs        # MySQL connection, CRUD transactions, and sequence reordering
├── project1_db_init.sql     # Database creation and table schemas
├── Web.config               # ASP.NET configuration and DB connection strings
└── README.md                # Project documentation
```

---

## 🗄️ Database Schema

The system uses two main tables in the MySQL database:

### 1. `Users` Table
Holds registered user profiles:
| Field | Type | Attributes | Description |
| :--- | :--- | :--- | :--- |
| `UserID` | `INT` | `AUTO_INCREMENT`, `PRIMARY KEY` | Unique ID of the user |
| `Name` | `VARCHAR(255)` | `NOT NULL` | Full Name |
| `Username` | `VARCHAR(100)` | `NOT NULL`, `UNIQUE` | Login username |
| `Password` | `VARCHAR(255)` | `NOT NULL` | User password |
| `Email` | `VARCHAR(255)` | `NOT NULL`, `UNIQUE` | User email address |
| `Roll` | `VARCHAR(50)` | `NOT NULL`, `UNIQUE` | Roll/ID number |
| `Batch` | `VARCHAR(50)` | `NOT NULL` | Batch/Year |
| `Department` | `VARCHAR(100)` | `NOT NULL` | Academic department |
| `University` | `VARCHAR(255)` | `NOT NULL` | Institution name |
| `Phone` | `VARCHAR(20)` | | Optional contact number |
| `UserType` | `VARCHAR(50)` | `DEFAULT 'User'` | Role (`User`, `Admin`, etc.) |
| `Reason` | `TEXT` | `NOT NULL` | Statement of registration |
| `DateRegistered`| `DATETIME` | `DEFAULT CURRENT_TIMESTAMP`| Registration timestamp |
| `IsActive` | `TINYINT` | `DEFAULT 1` | Status (active vs. deactivated) |

### 2. `Contact` Table
Stores inquiry messages submitted via the contact form:
| Field | Type | Attributes | Description |
| :--- | :--- | :--- | :--- |
| `ContactID` | `INT` | `AUTO_INCREMENT`, `PRIMARY KEY` | Unique message ID |
| `Name` | `VARCHAR(255)` | `NOT NULL` | Submitter name |
| `Email` | `VARCHAR(255)` | `NOT NULL` | Submitter email |
| `Roll` | `VARCHAR(50)` | `NOT NULL` | Submitter roll |
| `Department` | `VARCHAR(100)` | | Submitter department |
| `Message` | `TEXT` | `NOT NULL` | Core message content |
| `DateSubmitted` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP`| Submission timestamp |
| `IsRead` | `TINYINT` | `DEFAULT 0` | 0 = Unread, 1 = Read |
| `Status` | `VARCHAR(50)` | `DEFAULT 'New'` | Status tracking state |

---

## ⚙️ Installation & Setup

### Prerequisites
1.  **Visual Studio** (2019 / 2022) with *ASP.NET and web development* workload.
2.  **MySQL Server** (version 8.0 or later).
3.  **MySQL Workbench** or similar client database tool.

### Step 1: Database Setup
1.  Open your MySQL client and connect to your local MySQL server.
2.  Run the queries in [project1_db_init.sql](file:///c:/web_ass/project1/project1_db_init.sql) to initialize the database `project1_db` and establish the tables:
    ```sql
    CREATE DATABASE IF NOT EXISTS project1_db;
    USE project1_db;
    -- Run definitions for Users and Contact tables
    ```

### Step 2: Configure Web Connection String
1.  Open `Web.config` in the project root.
2.  Update the `connectionStrings` setting with your local MySQL credentials:
    ```xml
    <connectionStrings>
      <add name="DBConnection" 
           connectionString="Server=localhost;Database=project1_db;Uid=YOUR_MYSQL_USERNAME;Pwd=YOUR_MYSQL_PASSWORD;" 
           providerName="MySql.Data.MySqlClient" />
    </connectionStrings>
    ```

### Step 3: Run the Application
1.  Double-click `project1.sln` to open the project in Visual Studio.
2.  Restore any NuGet packages if prompted (requires `MySql.Data`).
3.  Press **F5** or click **IIS Express** to build and run the site.
4.  Navigate to `index.aspx` to browse the app, or `managedb.aspx` to manage database records.
