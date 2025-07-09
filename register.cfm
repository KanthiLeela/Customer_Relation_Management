<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
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

        .register-container {
            background: #bd7948;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            width: 350px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            font-weight: bold;
            display: block;
            margin: 10px 0 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 15px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #72361a;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #72361a;
        }

        .login-link {
            margin-top: 15px;
            text-align: center;
        }

        .login-link a {
            color: #5a00a3;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .message {
            text-align: center;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .message.error {
            color: red;
        }

        .message.success {
            color: green;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Register</h2>

    <!-- CFML Success/Error Messages -->
    <cfif structKeyExists(url, "error")>
        <cfif url.error EQ "username">
            <p class="message error">Username already exists or registration failed.</p>
        <cfelseif url.error EQ "password">
            <p class="message error">Password mismatch.</p>
        </cfif>
    <cfelseif structKeyExists(url, "success")>
        <p class="message success">Registration successful!</p>
    </cfif>

    <!-- Registration Form -->
    <form method="post" action="register_process.cfm">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="password" name="cpassword" placeholder="Confirm Password" required>
        <input type="submit" value="Register">
    </form>

    <div class="login-link">
        Already have an account? <a href="login.cfm">Login here</a>
    </div>
</div>

</body>
</html>
