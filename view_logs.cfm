<!-- Protect this page so only admins can see it -->
<cfif NOT structKeyExists(session, "role") OR session.role NEQ "admin">
  <cflocation url="unauthorized.cfm">
</cfif>

<!-- The rest of your logs.cfm code goes below -->
<h2>Admin Logs Page</h2>

<cfparam name="url.page" default="1">
<cfset perPage = 10>
<cfset startRow = (url.page - 1) * perPage + 1>

<!-- Total log count -->
<cfquery name="totalLogs" datasource="user">
    SELECT COUNT(*) AS total FROM logs
</cfquery>

<!-- Fetch logs for the current page -->
<cfquery name="logs" datasource="user">
    SELECT * FROM logs
    ORDER BY id DESC
    LIMIT <cfqueryparam value="#perPage#" cfsqltype="cf_sql_integer">
    OFFSET <cfqueryparam value="#startRow - 1#" cfsqltype="cf_sql_integer">
</cfquery>

<!DOCTYPE html>
<html>
<head>
    <title>User Activity Logs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f4f7;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 90%;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: #72361a;
            color: white;
            padding: 12px;
        }

        td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a, .pagination strong {
            display: inline-block;
            margin: 0 5px;
            padding: 8px 14px;
            text-decoration: none;
            color: #72361a;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .pagination strong {
            background-color: #72361a;
            color: white;
            border-color: #71361a;
        }

        .pagination a:hover {
            background-color: #e9ecef;
        }

        .page-info {
            text-align: center;
            margin-top: 10px;
            color: #333;
            font-weight: bold;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
        }

        .back-link a {
            background-color: #71361a;
            padding: 10px 20px;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link a:hover {
            background-color: #c0a48e;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>User Activity Logs</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Action</th>
            <th>Request ID</th>
            <th>Timestamp</th>
            <th>Details</th>
        </tr>
        <cfoutput query="logs">
            <tr>
                <td>#id#</td>
                <td>#username#</td>
                <td>#action#</td>
                <td>#request_id#</td>
                <td>#timestamp#</td>
                <td>#details#</td>
            </tr>
        </cfoutput>
    </table>

    <!-- Page info -->
    <cfset totalPages = ceiling(totalLogs.total / perPage)>
    <div class="page-info">
        <cfoutput>Page #url.page# of #totalPages#</cfoutput>
    </div>

    <!-- Pagination with Previous and Next -->
<div class="pagination">
    <cfoutput>
        <!-- Previous button -->
        <cfif url.page GT 1>
            <a href="view_logs.cfm?page=#url.page - 1#">Previous</a>
        </cfif>

        <!-- Page numbers -->
        <cfloop from="1" to="#totalPages#" index="i">
            <cfif i EQ url.page>
                <strong>#i#</strong>
            <cfelse>
                <a href="view_logs.cfm?page=#i#">#i#</a>
            </cfif>
        </cfloop>

        <!-- Next button -->
        <cfif url.page LT totalPages>
            <a href="view_logs.cfm?page=#url.page + 1#">Next</a>
        </cfif>
    </cfoutput>
</div>
<!-- Back to home -->
<div class="back-link">
    <a href="home.cfm">Back to Home</a>
</div>

</body>
</html>
