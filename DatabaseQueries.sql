-- ============================================
-- CONTACT FORM TABLE & QUERIES
-- ============================================

-- Create Contact Table
CREATE TABLE IF NOT EXISTS Contact (
    ContactID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL,
    Phone TEXT,
    Subject TEXT NOT NULL,
    Message TEXT NOT NULL,
    DateSubmitted DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsRead INTEGER DEFAULT 0,
    Status TEXT DEFAULT 'New'
);

-- Insert Contact Message
INSERT INTO Contact (Name, Email, Phone, Subject, Message) 
VALUES (?, ?, ?, ?, ?);

-- Select All Contact Messages
SELECT * FROM Contact ORDER BY DateSubmitted DESC;

-- Select Contact by ID
SELECT * FROM Contact WHERE ContactID = ?;

-- Select Unread Contacts
SELECT * FROM Contact WHERE IsRead = 0 ORDER BY DateSubmitted DESC;

-- Update Contact as Read
UPDATE Contact SET IsRead = 1 WHERE ContactID = ?;

-- Update Contact Status
UPDATE Contact SET Status = ? WHERE ContactID = ?;

-- Delete Contact Message
DELETE FROM Contact WHERE ContactID = ?;

-- Count Total Contacts
SELECT COUNT(*) as TotalContacts FROM Contact;

-- Get Contacts by Date Range
SELECT * FROM Contact 
WHERE DateSubmitted BETWEEN ? AND ? 
ORDER BY DateSubmitted DESC;


-- ============================================
-- SIGN-UP / USER REGISTRATION TABLE & QUERIES
-- ============================================

-- Create Users Table
CREATE TABLE IF NOT EXISTS Users (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    Username TEXT NOT NULL UNIQUE,
    Email TEXT NOT NULL UNIQUE,
    Password TEXT NOT NULL,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Phone TEXT,
    DateRegistered DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsActive INTEGER DEFAULT 1,
    IsVerified INTEGER DEFAULT 0,
    LastLogin DATETIME
);

-- Insert New User (Sign-up)
INSERT INTO Users (Username, Email, Password, FirstName, LastName, Phone) 
VALUES (?, ?, ?, ?, ?, ?);

-- Select All Users
SELECT UserID, Username, Email, FirstName, LastName, Phone, DateRegistered, IsActive 
FROM Users ORDER BY DateRegistered DESC;

-- Select User by ID
SELECT * FROM Users WHERE UserID = ?;

-- Select User by Username
SELECT * FROM Users WHERE Username = ?;

-- Select User by Email
SELECT * FROM Users WHERE Email = ?;

-- Verify Login (Select by Username and Password)
SELECT UserID, Username, FirstName, LastName, Email 
FROM Users 
WHERE Username = ? AND Password = ? AND IsActive = 1;

-- Update User Profile
UPDATE Users 
SET FirstName = ?, LastName = ?, Phone = ? 
WHERE UserID = ?;

-- Update User Email
UPDATE Users SET Email = ? WHERE UserID = ?;

-- Update User Password
UPDATE Users SET Password = ? WHERE UserID = ?;

-- Update Last Login
UPDATE Users SET LastLogin = CURRENT_TIMESTAMP WHERE UserID = ?;

-- Verify User Email
UPDATE Users SET IsVerified = 1 WHERE UserID = ?;

-- Deactivate User
UPDATE Users SET IsActive = 0 WHERE UserID = ?;

-- Delete User Account
DELETE FROM Users WHERE UserID = ?;

-- Count Total Users
SELECT COUNT(*) as TotalUsers FROM Users;

-- Get Active Users
SELECT * FROM Users WHERE IsActive = 1 ORDER BY DateRegistered DESC;

-- Get Unverified Users
SELECT * FROM Users WHERE IsVerified = 0 ORDER BY DateRegistered DESC;

-- Check if Username Exists
SELECT COUNT(*) as UserCount FROM Users WHERE Username = ?;

-- Check if Email Exists
SELECT COUNT(*) as EmailCount FROM Users WHERE Email = ?;

-- Get Users Registered in Date Range
SELECT * FROM Users 
WHERE DateRegistered BETWEEN ? AND ? 
ORDER BY DateRegistered DESC;
