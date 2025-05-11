<?php
session_start();
include '../config/db.php';

$email = trim($_POST['email']);
$password = $_POST['password'];

$stmt = $conn->prepare("SELECT id, name, password, role, status FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows == 1) {
    $stmt->bind_result($id, $name, $hashed_password, $role, $status);
    $stmt->fetch();

    if ($status != 'active') {
        die("Account is not active.");
    }

    if (password_verify($password, $hashed_password)) {
        $_SESSION['user_id'] = $id;
        $_SESSION['name'] = $name;
        $_SESSION['role'] = $role;
        header("Location: ../dashboard/" . $role . ".php");
        exit;
    } else {
        die("Incorrect password.");
    }
} else {
    die("User not found.");
}
$stmt->close();
$conn->close();
?>
