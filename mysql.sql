-- Create database
CREATE DATABASE cpa_network;
USE cpa_network;

-- User Roles Table
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role_id INT,
    status ENUM('active', 'suspended', 'deleted') DEFAULT 'active',
    assigned_manager_id INT DEFAULT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (assigned_manager_id) REFERENCES users(id)
);

-- Offers Table
CREATE TABLE offers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    offer_type ENUM('CPA', 'CPL', 'CPS', 'RevShare'),
    payout DECIMAL(10, 2),
    tracking_url TEXT,
    advertiser_id INT,
    visible_to_all BOOLEAN DEFAULT TRUE,
    created_by INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (advertiser_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Clicks Table
CREATE TABLE clicks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    offer_id INT,
    publisher_id INT,
    click_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    subid VARCHAR(255),
    ip_address VARCHAR(50),
    tracking_domain VARCHAR(255),
    FOREIGN KEY (offer_id) REFERENCES offers(id),
    FOREIGN KEY (publisher_id) REFERENCES users(id)
);

-- Conversions Table
CREATE TABLE conversions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    click_id INT,
    offer_id INT,
    publisher_id INT,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    conversion_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    payout DECIMAL(10, 2),
    FOREIGN KEY (click_id) REFERENCES clicks(id),
    FOREIGN KEY (offer_id) REFERENCES offers(id),
    FOREIGN KEY (publisher_id) REFERENCES users(id)
);

-- Payments Table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_id INT,
    amount DECIMAL(10, 2),
    method ENUM('PayPal', 'Payoneer', 'Bank', 'Crypto'),
    status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
    transaction_id VARCHAR(100),
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    paid_at DATETIME,
    FOREIGN KEY (publisher_id) REFERENCES users(id)
);

-- Referrals Table
CREATE TABLE referrals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    referrer_id INT,
    referred_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (referrer_id) REFERENCES users(id),
    FOREIGN KEY (referred_id) REFERENCES users(id)
);

-- Tracking Domains
CREATE TABLE tracking_domains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domain VARCHAR(255) UNIQUE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Postbacks Table
CREATE TABLE postbacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    offer_id INT,
    click_id INT,
    ip_address VARCHAR(50),
    received_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    raw_data TEXT,
    FOREIGN KEY (offer_id) REFERENCES offers(id),
    FOREIGN KEY (click_id) REFERENCES clicks(id)
);

-- Suspension Logs
CREATE TABLE suspensions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action_by INT,
    reason TEXT,
    action ENUM('suspend', 'reactivate'),
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (action_by) REFERENCES users(id)
);
