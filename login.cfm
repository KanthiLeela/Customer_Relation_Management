<!DOCTYPE html>
<html>
<head>
  <title>CRM Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #c0a48e;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .login-container {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 300px;
    }
    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #1a1a1a;
    }
    label {
      font-weight: bold;
      display: block;
      margin-top: 10px;
    }
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    input[type="submit"] {
      width: 100%;
      margin-top: 15px;
      background-color: #72361a;;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 4px;
      font-weight: bold;
      cursor: pointer;
    }
    input[type="submit"]:hover {
      background-color: #72361a;;
    }
  </style>
</head>
<body>

<div class="login-container">
  <h2>Login</h2>

  <form id="loginform" action="authenticate.cfm" method="post">
  
    <label for="username">Username</label>
    <input type="text" name="username" id="username" required>

    <label for="password">Password</label>
    <input type="password" name="password" id="password" required>

    <input type="submit" value="Login">
  </form>

  <form action="register.cfm" method="get">
    <input type="submit" value="Registration">
  </form>
</div>

<script>
  if (window.location.search.includes("error=true")) {
    alert("Invalid username or password.");
  }
</script>

</body>
</html>
