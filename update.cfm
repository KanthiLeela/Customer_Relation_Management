<cfparam name="form.id" default="0">
<cfparam name="form.title" default="">
<cfparam name="form.description" default="">

<cfif structkeyexists(form, "id") AND structkeyexists(form, "title") AND structkeyexists(form, "description")>
  
  <!-- Perform Update -->
  <cfquery name="upquery" datasource="user">
    UPDATE requests
    SET title = <cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">,
        description = <cfqueryparam value="#form.description#" cfsqltype="cf_sql_varchar">
    WHERE id = <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">
  </cfquery>

  <!--  Log the update action -->
  <cfquery datasource="user">
    INSERT INTO logs (username, action, request_id, details)
    VALUES (
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="UPDATE" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#form.id#" cfsqltype="cf_sql_integer">,
        <cfqueryparam value="User #session.userid# updated request ID #form.id# with title '#form.title#'" cfsqltype="cf_sql_varchar">
    )
  </cfquery>

  <!-- Redirect back with success -->
  <cflocation url="edit.cfm?id=#form.id#&success=true">

<cfelse>
  <!-- Redirect back with error -->
  <cflocation url="edit.cfm?id=#form.id#&error=true">
</cfif>
