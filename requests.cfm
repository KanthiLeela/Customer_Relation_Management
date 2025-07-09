<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Submit Request</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #f2f4f7;
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #72361a;
      padding: 15px 20px;
      color: white;
    }

    .menu-icon {
      font-size: 26px;
      cursor: pointer;
      user-select: none;
    }

    .logout-btn a {
      background-color: white;
      color: #72361a;
      padding: 8px 16px;
      border-radius: 5px;
      font-weight: bold;
      text-decoration: none;
    }

    .logout-btn a:hover {
      background-color: #e0e0e0;
    }

    .form-container {
      max-width: 500px;
      margin: 50px auto;
      background: #c0a48e;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #72361a;
    }

    label {
      display: block;
      margin: 10px 0 5px;
      font-weight: bold;
      color: #72361a;
    }

    input[type="text"],
    textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: #72361a;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      width: 100%;
      font-size: 16px;
    }

    input[type="submit"]:hover {
      background-color: #bd7948;
    }

    .back-link {
      display: block;
      text-align: center;
      margin-top: 15px;
    }

    .back-link a {
      color: #72361a;
      text-decoration: none;
      font-size: 16px;
    }

    .back-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<!-- Top Navbar -->
<div class="navbar">
  <div class="menu-icon" onclick="toggleMenu()">&#9776;</div>
  <div class="logout-btn">
    <a href="submitted_requests.cfm">View Requests</a>
    <a href="logout.cfm">Logout</a>
  </div>
</div>

<!-- Form processing logic -->
<cfparam name="form.title" default="">
<cfparam name="form.description" default="">

<cfif structkeyexists(form, "submit")>
  <!-- Insert the request -->
  <cfquery name="ourquery" datasource="user">
    INSERT INTO requests (title, description)
    VALUES (
      <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
      <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">
    )
  </cfquery>

  <!-- Get last inserted ID -->
  <cfquery name="getId" datasource="user">
    SELECT MAX(id) AS rid FROM requests
  </cfquery>
  <cfset requestId = getId.rid>

  <!-- Log this action -->
  <cfquery datasource="user">
    INSERT INTO logs (username, action, request_id, details)
    VALUES (
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="Submit Request" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#requestId#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="Created request with title '#form.title#'" cfsqltype="cf_sql_varchar">
    )
  </cfquery>

  <!-- Redirect after submission -->
  <cflocation url="submitted_requests.cfm?success=true">
</cfif>

<!-- Form Container -->
<div class="form-container">
  <h2>Submit a New Request</h2>

  <form method="post">
    <label>Title</label>
    <input type="text" name="title" placeholder="Enter Title" required>

    <label>Description</label>
    <textarea name="description" placeholder="Enter Description" rows="4"></textarea>

    <input type="submit" name="submit" value="Submit">
  </form>

  <div class="back-link">
    <a href="home.cfm">Back to Home</a>
  </div>
</div>

<!-- JavaScript -->
<script>
  function toggleMenu() {
    var menu = document.getElementById("toggleMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
  }
</script>

</body>
</html>
