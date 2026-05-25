using System;
using System.Data;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace project1
{
    public class DatabaseHelper
    {
        private static bool _isInitialized = false;
        private static readonly object _lock = new object();
        private readonly string _connectionString;

        public DatabaseHelper()
        {
            // Read from Web.config, fall back to default localhost if not specified
            _connectionString = ConfigurationManager.ConnectionStrings["MySqlConnection"]?.ConnectionString 
                ?? "server=localhost;port=3306;database=project1_db;uid=root;password=;";

            // Automatically initialize the database and tables
            InitializeDatabase();
        }

        /// <summary>
        /// Automatically creates the database and the required tables if they do not exist.
        /// </summary>
        public void InitializeDatabase()
        {
            if (_isInitialized) return;

            lock (_lock)
            {
                if (_isInitialized) return;

                try
                {
                // 1. First, connect to localhost without a specific database to ensure the database exists
                var connStringBuilder = new MySqlConnectionStringBuilder(_connectionString)
                {
                    Database = "" // Clear database to connect to root
                };

                using (MySqlConnection conn = new MySqlConnection(connStringBuilder.ConnectionString))
                {
                    conn.Open();
                    string createDbQuery = "CREATE DATABASE IF NOT EXISTS project1_db;";
                    using (MySqlCommand cmd = new MySqlCommand(createDbQuery, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }

                // 2. Now connect to project1_db and create the tables if they don't exist
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();

                    // Create Contact Table
                    string createContactTable = @"
                        CREATE TABLE IF NOT EXISTS Contact (
                            ContactID INT AUTO_INCREMENT PRIMARY KEY,
                            Name VARCHAR(255) NOT NULL,
                            Email VARCHAR(255) NOT NULL,
                            Roll VARCHAR(50) NOT NULL,
                            Department VARCHAR(100),
                            Message TEXT NOT NULL,
                            DateSubmitted DATETIME DEFAULT CURRENT_TIMESTAMP,
                            IsRead TINYINT DEFAULT 0,
                            Status VARCHAR(50) DEFAULT 'New'
                        );";

                    using (MySqlCommand cmd = new MySqlCommand(createContactTable, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    // Create Users Table (Sign-Up)
                    string createUsersTable = @"
                        CREATE TABLE IF NOT EXISTS Users (
                            UserID INT AUTO_INCREMENT PRIMARY KEY,
                            Name VARCHAR(255) NOT NULL,
                            Email VARCHAR(255) NOT NULL UNIQUE,
                            Roll VARCHAR(50) NOT NULL UNIQUE,
                            Batch VARCHAR(50) NOT NULL,
                            Department VARCHAR(100) NOT NULL,
                            University VARCHAR(255) NOT NULL,
                            Phone VARCHAR(20),
                            Reason TEXT NOT NULL,
                            DateRegistered DATETIME DEFAULT CURRENT_TIMESTAMP,
                            IsActive TINYINT DEFAULT 1,
                            IsVerified TINYINT DEFAULT 0,
                            LastLogin DATETIME
                        );";

                    using (MySqlCommand cmd = new MySqlCommand(createUsersTable, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    // Check if Phone column exists in Users table, and add it if it doesn't
                    string checkPhoneColumnQuery = "SHOW COLUMNS FROM Users LIKE 'Phone';";
                    bool phoneColumnExists = false;
                    using (MySqlCommand cmd = new MySqlCommand(checkPhoneColumnQuery, conn))
                    {
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                phoneColumnExists = true;
                            }
                        }
                    }

                    if (!phoneColumnExists)
                    {
                        string addPhoneColumnQuery = "ALTER TABLE Users ADD COLUMN Phone VARCHAR(20);";
                        using (MySqlCommand cmd = new MySqlCommand(addPhoneColumnQuery, conn))
                        {
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                // Mark as successfully initialized to prevent subsequent checks
                _isInitialized = true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Database initialization error: " + ex.Message);
                // Also write to console for easier debugging
                Console.WriteLine("Database initialization error: " + ex.Message);
            }
            }
        }

        // ============================================
        // CONTACT OPERATIONS
        // ============================================

        public bool InsertContact(string name, string email, string roll, string department, string message)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Contact (Name, Email, Roll, Department, Message) 
                                   VALUES (@name, @email, @roll, @department, @message)";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@roll", roll);
                        cmd.Parameters.AddWithValue("@department", department ?? "");
                        cmd.Parameters.AddWithValue("@message", message);
                        
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error inserting contact: " + ex.Message);
                return false;
            }
        }

        public DataTable GetAllContacts()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    string query = "SELECT * FROM Contact ORDER BY DateSubmitted DESC";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error getting contacts: " + ex.Message);
                return null;
            }
        }

        public DataTable GetUnreadContacts()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    string query = "SELECT * FROM Contact WHERE IsRead = 0 ORDER BY DateSubmitted DESC";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error getting unread contacts: " + ex.Message);
                return null;
            }
        }

        public bool MarkContactAsRead(int contactId)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Contact SET IsRead = 1 WHERE ContactID = @id";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", contactId);
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error marking contact as read: " + ex.Message);
                return false;
            }
        }

        public bool DeleteContact(int contactId)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Contact WHERE ContactID = @id";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", contactId);
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error deleting contact: " + ex.Message);
                return false;
            }
        }

        // ============================================
        // USER/SIGN-UP OPERATIONS
        // ============================================

        public bool InsertUser(string name, string email, string roll, string batch, string department, string university, string phone, string reason)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Users (Name, Email, Roll, Batch, Department, University, Phone, Reason) 
                                   VALUES (@name, @email, @roll, @batch, @department, @university, @phone, @reason)";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@roll", roll);
                        cmd.Parameters.AddWithValue("@batch", batch);
                        cmd.Parameters.AddWithValue("@department", department);
                        cmd.Parameters.AddWithValue("@university", university);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@reason", reason);
                        
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error inserting user: " + ex.Message);
                return false;
            }
        }

        public bool CheckUsernameExists(string roll)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM Users WHERE Roll = @roll";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@roll", roll);
                        long count = Convert.ToInt64(cmd.ExecuteScalar());
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error checking username (roll): " + ex.Message);
                return false;
            }
        }

        public bool CheckEmailExists(string email)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "SELECT COUNT(*) FROM Users WHERE Email = @email";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@email", email);
                        long count = Convert.ToInt64(cmd.ExecuteScalar());
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error checking email: " + ex.Message);
                return false;
            }
        }

        public DataTable GetAllUsers()
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    string query = @"SELECT UserID, Name, Email, Roll, Batch, Department, University, Phone, DateRegistered, IsActive 
                                   FROM Users ORDER BY DateRegistered DESC";
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error getting users: " + ex.Message);
                return null;
            }
        }

        public bool DeactivateUser(int userId)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Users SET IsActive = 0 WHERE UserID = @userId";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@userId", userId);
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error deactivating user: " + ex.Message);
                return false;
            }
        }

        public bool DeleteUser(int userId)
        {
            try
            {
                using (MySqlConnection conn = new MySqlConnection(_connectionString))
                {
                    conn.Open();
                    string query = "DELETE FROM Users WHERE UserID = @userId";
                    
                    using (MySqlCommand cmd = new MySqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@userId", userId);
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error deleting user: " + ex.Message);
                return false;
            }
        }
    }
}
