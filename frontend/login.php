<?php include('includes/header.php'); ?>

<section class="py-5">
  <div class="container">
    <h2 class="mb-4 text-center">Login</h2>
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form method="POST" action="login_process.php">
          <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
          <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <p class="text-center mt-3">
          Don't have an account? <a href="register.php">Register here</a>
        </p>
      </div>
    </div>
  </div>
</section>

<?php include('includes/footer.php'); ?>
