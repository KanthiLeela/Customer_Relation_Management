<cfif structKeyExists(url, "id") AND isNumeric(url.id)>
  
  <!-- Optional: Verify the record exists -->
  <cfquery name="checkRequest" datasource="user">
    SELECT id, title FROM requests
    WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfif checkRequest.recordcount EQ 1>
    <!-- 🦜Record exists, proceed to delete -->
    <cfquery name="deleteRequest" datasource="user">
      DELETE FROM requests
      WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
    </cfquery>

    <!-- 🦜Log the delete action -->
    <cfquery datasource="user">
      INSERT INTO logs (username, action, request_id, details)
      VALUES (
          <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="DELETE" cfsqltype="cf_sql_varchar">,
          <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">,
          <cfqueryparam value="User #session.userid# deleted request ID #url.id#" cfsqltype="cf_sql_varchar">
      )
    </cfquery>

    <!-- 🦜Redirect after deletion -->
    <cflocation url="submitted_requests.cfm?deleted=true">

  <cfelse>
    <!-- Record not found -->
    <cfoutput>
      <p style="color:red;">Request not found. Nothing was deleted.</p>
    </cfoutput>
  </cfif>

<cfelse>
  <!-- No ID passed -->
  <cfoutput>
    <p style="color:red;">Invalid or missing ID.</p>
  </cfoutput>
</cfif>
