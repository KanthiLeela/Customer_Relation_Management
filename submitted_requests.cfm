<cfparam name="url.search" default="">
<cfparam name="url.department" default="">

<cfif structKeyExists(url, "success") AND url.success EQ "true">
  <script>alert("Successfully submitted a request!");</script>
</cfif>

<!DOCTYPE html>
<html>
<head>
  <title>Submitted Requests</title>
  <meta charset="UTF-8">
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
      padding: 12px 20px;
      color: white;
    }

    .navbar a {
      color: white;
      text-decoration: none;
      font-weight: bold;
      margin: 0 10px;
    }

    .navbar a:hover {
      text-decoration: underline;
    }

    .container {
      max-width: 900px;
      margin: 40px auto;
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #71361a;
      margin-bottom: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 12px 15px;
      border: 1px solid #ddd;
      text-align: center;
    }

    th {
      background-color: #72361a;
      color: white;
    }

    .actions {
      display: flex;
      justify-content: center;
      gap: 10px;
    }

    .btn-edit, .btn-delete {
      padding: 6px 12px;
      color: white;
      border-radius: 5px;
      text-decoration: none;
      font-weight: bold;
    }

    .btn-edit {
      background-color: #bd7948;
    }

    .btn-delete {
      background-color: red;
    }

    .btn-edit:hover, .btn-delete:hover {
      opacity: 0.9;
    }

    .back-btn {
      display: block;
      margin: 30px auto 0;
      background-color: #72361a;
      padding: 10px 20px;
      color: white;
      text-align: center;
      text-decoration: none;
      border-radius: 6px;
      font-weight: bold;
      width: fit-content;
    }

    .back-btn:hover {
      background-color: #c0a48e;
    }

    .page-link {
      margin: 0 5px;
      padding: 8px 14px;
      color: #72361a;
      text-decoration: none;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .page-link.active {
      background-color: #72361a;
      color: white;
      font-weight: bold;
      border-color: #71361a;
    }

    .pagination {
      text-align: center;
      margin-top: 20px;
    }

    .filter-bar {
      margin-bottom: 20px;
    }

    .filter-row {
      display: flex;
      gap: 15px;
      justify-content: center;
      flex-wrap: wrap;
      margin-bottom: 15px;
    }

    .filter-bar select,
    .filter-bar input[type="text"] {
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      width: 250px;
    }

    .filter-bar button {
      background-color: #72361a;
      color: white;
      padding: 10px 18px;
      font-weight: bold;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }

    .filter-bar button:hover {
      background-color: #c0a48e;
    }

    .btn-download-pdf {
      background-color: #72361a;
      color: white;
      padding: 10px 18px;
      font-weight: bold;
      border-radius: 6px;
      text-decoration: none;
    }

    .btn-download-pdf:hover {
      background-color: #c0a48e;
    }
  </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
  <div><a href="home.cfm">Home</a></div>
  <div><a href="requests.cfm">New Requests</a></div>
  <div><a href="logout.cfm">Logout</a></div>
</div>

<!-- MAIN CONTENT -->
<div class="container">
  <h2>Your Submitted Requests</h2>

  <!-- Filter Bar -->
  <div class="filter-bar">
    <form method="get" action="submitted_requests.cfm">
      <!-- Department & Download Row -->
      <div class="filter-row">
        <select name="department">
          <option value="">-- All Departments --</option>
          <option value="Frontend" <cfif url.department EQ "Frontend">selected</cfif>>Frontend</option>
          <option value="Backend" <cfif url.department EQ "Backend">selected</cfif>>Backend</option>
          <option value="Database" <cfif url.department EQ "Database">selected</cfif>>Database</option>
        </select>

        <a href="download_requests_pdf.cfm" target="_blank" class="btn-download-pdf">
          Download PDF
        </a>
      </div>

      <!-- Search Row -->
      <div class="filter-row">
        <input type="text" name="search" placeholder="Search title or description" value="<cfoutput>#url.search#</cfoutput>">
        <button type="submit">Search</button>
      </div>
    </form>
  </div>

  <!-- Pagination setup -->
  <cfparam name="url.page" default="1">
  <cfset currentPage = val(url.page)>
  <cfset perPage = 5>
  <cfset startRow = (currentPage - 1) * perPage + 1>

  <!-- Total Requests Count -->
  <cfquery name="totalRequests" datasource="user">
    SELECT COUNT(*) AS total FROM requests
    WHERE 1=1
    <cfif len(trim(url.search))>
      AND (title LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">
      OR description LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif len(trim(url.department))>
      AND department = <cfqueryparam value="#url.department#" cfsqltype="cf_sql_varchar">
    </cfif>
  </cfquery>

  <!-- Requests with Pagination -->
  <cfquery name="getreq" datasource="user">
    SELECT * FROM requests
    WHERE 1=1
    <cfif len(trim(url.search))>
      AND (title LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">
      OR description LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">)
    </cfif>
    <cfif len(trim(url.department))>
      AND department = <cfqueryparam value="#url.department#" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY id DESC
    LIMIT <cfqueryparam value="#perPage#" cfsqltype="cf_sql_integer">
    OFFSET <cfqueryparam value="#startRow - 1#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfset totalPages = ceiling(totalRequests.total / perPage)>

  <!-- Requests Table -->
  <table>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th>Actions</th>
    </tr>

    <cfoutput query="getreq">
      <tr>
        <td>#title#</td>
        <td>#description#</td>
        <td class="actions">
          <a href="edit.cfm?id=#id#" class="btn-edit">Edit</a>
          <a href="delete.cfm?id=#id#" class="btn-delete" onclick="return confirm('Are you sure you want to delete this request?')">Delete</a>
        </td>
      </tr>
    </cfoutput>
  </table>

  <!-- Pagination Links -->
  <div class="pagination">
    <cfoutput>
      <cfif currentPage GT 1>
        <a href="submitted_requests.cfm?page=#currentPage - 1#" class="page-link">Previous</a>
      </cfif>

      <cfloop from="1" to="#totalPages#" index="i">
        <cfif i EQ currentPage>
          <span class="page-link active">#i#</span>
        <cfelse>
          <a href="submitted_requests.cfm?page=#i#" class="page-link">#i#</a>
        </cfif>
      </cfloop>

      <cfif currentPage LT totalPages>
        <a href="submitted_requests.cfm?page=#currentPage + 1#" class="page-link">Next</a>
      </cfif>
    </cfoutput>
  </div>

  <!-- Back Button -->
  <a href="home.cfm" class="back-btn">Back to Home</a>
</div>

</body>
</html>
