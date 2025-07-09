<cfcontent type="application/pdf" />
<cfheader name="Content-Disposition" value="inline; filename=customers.pdf">

<cfquery name="getCustomers" datasource="user">
  SELECT id, name, email, phone FROM customers ORDER BY id DESC
</cfquery>

<cfdocument format="pdf" pagetype="A4" orientation="portrait" marginbottom="1" margintop="1" marginleft="1" marginright="1">

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin: 0 auto;
    }

    th, td {
      border: 1px solid #ccc;
      padding: 8px;
      text-align: center;
    }

    th {
      background-color: #72361a;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
  </style>

  <h2>Customer Report</h2>

  <table>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Email</th>
      <th>Phone</th>
    </tr>
    <cfoutput query="getCustomers">
      <tr>
        <td>#id#</td>
        <td>#name#</td>
        <td>#email#</td>
        <td>#phone#</td>
      </tr>
    </cfoutput>
  </table>
</cfdocument>
<cfquery datasource="user" name="logDownload">
    INSERT INTO report_downloads(user_id, username, downloaded_at)
    VALUES (
        <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
    )
</cfquery>
