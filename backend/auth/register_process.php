<?php
include '../config/db.php';

$name = trim($_POST['name']);
$email = trim($_POST['email']);
$password = $_POST['password'];
$role = $_POST['role']; // publisher or advertiser

// Basic validation
if (!$name || !$email || !$password || !$role) {
    die("All fields are required.");
}

// Check if email already exists
$stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();
if ($stmt->num_rows > 0) {
    die("Email already registered.");
}
$stmt->close();

// Hash password
$hashed_password = password_hash($password, PASSWORD_BCRYPT);

// Insert user
$stmt = $conn->prepare("INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, 'active')");
$stmt->bind_param("ssss", $name, $email, $hashed_password, $role);
if ($stmt->execute()) {
    echo "Registration successful. You can now login.";
} else {
    echo "Error: " . $stmt->error;
}
$stmt->close();
$conn->close();
?>
