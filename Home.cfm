<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>CRM Home Page</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #c0a48e;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #72361a; 
      padding: 15px 20px;
      color: white;
    }
    h2{
      color: #72361a;
    }

    /* Custom Menu Icon (three lines) */
    .menu-icon {
      cursor: pointer;
      display: flex;
      flex-direction: column;
      gap: 5px;
    }

    .menu-bars {
      width: 25px;
      height: 3px;
      background-color: white;
      border-radius: 2px;
    }

    .logout-btn a {
      background-color: transparent;
      color: white;
      font-weight: bold;
      text-decoration: none;
      font-size: 16px;
    }

    .logout-btn a:hover {
      text-decoration: underline;
    }

    .container {
      text-align: center;
      padding: 60px 20px;
    }

    #menu {
      display: none;
      position: absolute;
      top: 60px;
      left: 20px;
      background:white;
      border-radius: 6px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
      padding: 10px 0;
      width: 200px;
      z-index: 999;
    }

    #menu ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
    }

    #menu li {
      padding: 12px 16px;
      font-weight: bold;
      color: #333;
    }

    #menu li:hover {
      background-color: #c0a48e;
    }

    #menu a {
      text-decoration: none;
      color: #72361a;
      display: block;
      width: 100%;
    }

    .open #menu {
      display: block;
    }

    hr {
      margin: 0;
      border: none;
      border-top: 1px solid #eee;
    }

  </style>
</head>
<body>

<!-- Top Navbar -->
<div class="navbar">
  <div id="toggleBtn" class="menu-icon">
    <div class="menu-bars"></div>
    <div class="menu-bars"></div>
    <div class="menu-bars"></div>
  </div>

  <div class="logout-btn">
    <a href="logout.cfm">Logout</a>
  </div>
</div>

<!-- 🦜User Content -->
<cfif structkeyexists(session, "userid")>
  <div class="container">
    <h2><cfoutput>Welcome To your profile <br> #session.username# <br>Have a Good Day!</cfoutput></h2>

    <!-- Dropdown Menu -->
    <div id="menu">
      <ul>
        <li><a href="user_account.cfm">Go to My Profile</a></li>
        <hr>
        <li><a href="requests.cfm">Submit Request</a></li>
        <hr>
        <li><a href="submitted_requests.cfm">View Requests</a></li>
        <hr>
        <li><a href="view_logs.cfm" class="menu-link">View Logs</a></li>
        <hr>
        <li><a href="customers.cfm">Customers</a></li>

      </ul>
    </div>
  </div>
<cfelse>
  <cflocation url="login.cfm">
</cfif>

<!--🦜 JS for Menu Toggle -->
<script>
  const toggleBtn = document.getElementById("toggleBtn");
  const body = document.body;

  toggleBtn.addEventListener("click", function () {
    body.classList.toggle("open");
  });
</script>

</body>
</html>
