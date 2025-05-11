<?php include('includes/header.php'); ?>

<section class="py-5">
  <div class="container">
    <h2 class="mb-4 text-center">Register</h2>
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form method="POST" action="register_process.php">
          <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          <div class="mb-3">
            <label for="role" class="form-label">I am a</label>
            <select class="form-select" id="role" name="role" required>
              <option value="">Select role</option>
              <option value="publisher">Publisher</option>
              <option value="advertiser">Advertiser</option>
            </select>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Create Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
          <button type="submit" class="btn btn-primary w-100">Register</button>
        </form>
        <p class="text-center mt-3">
          Already have an account? <a href="login.php">Login here</a>
        </p>
      </div>
    </div>
  </div>
</section>

<?php include('includes/footer.php'); ?>
