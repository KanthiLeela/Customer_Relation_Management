<!DOCTYPE html>
<html>
<head>
  <title>CRM - Editing Request</title>
  <meta charset="UTF-8">
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
      background-color:  #72361a;;
      padding: 12px 20px;
      color: white;
    }

    .navbar a {
      color: white;
      text-decoration: none;
      font-weight: bold;
    }

    .navbar a:hover {
      text-decoration: underline;
    }

    .form-container {
      max-width: 500px;
      margin: 50px auto;
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    h2 {
      text-align: center;
      color: #333;
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    input[type="submit"] {
      background-color: #72361a;;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 20px;
      width: 100%;
      font-size: 16px;
    }

    input[type="submit"]:hover {
      background-color:  #c0a48e;
    }

    .success-msg {
      text-align: center;
      color: green;
      font-weight: bold;
      margin: 10px;
    }

    .error-msg {
      text-align: center;
      color: red;
      font-weight: bold;
      margin: 10px;
    }
  </style>
</head>
<body>

<!--🦜 NAVIGATION BAR -->
<div class="navbar">
  <div><a href="submitted_requests.cfm">Back</a></div>
  <div><a href="logout.cfm">Logout</a></div>
</div>

<!-- 🦜CHECK FOR ID -->
<cfif NOT structKeyExists(url, "id")>
  <div class="error-msg">No ID provided to edit.</div>
  <cfabort>
</cfif>

<!--🦜 SUCCESS ALERT -->
<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>alert("Successfully Updated");</script>
  <cflocation url="submitted_requests.cfm">
</cfif>

<!-- 🦜FETCH EXISTING RECORD -->
<cfquery name="myquery" datasource="user">
  SELECT title, description
  FROM requests
  WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>

<!--🦜 EDIT FORM -->
<div class="form-container">
  <h2>Edit Your Request</h2>
  <cfoutput>
    <form action="update.cfm" method="post">
      <input type="hidden" name="id" value="#url.id#">

      <label>Title</label>
      <input type="text" name="title" value="#myquery.title#" required>

      <label>Description</label>
      <input type="text" name="description" value="#myquery.description#">

      <input type="submit" value="Submit">
    </form>
  </cfoutput>
</div>

</body>
</html>
