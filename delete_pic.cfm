<cfquery name="getPic" datasource="user">
  SELECT profile_pic FROM users
  WHERE id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfif getPic.recordCount EQ 1 AND len(getPic.profile_pic)>
  <!--- 🦜Construct path to file --->
  <cfset filePath = expandPath("uploads/" & getPic.profile_pic)>

  <!---🦜 Check if file exists before deleting --->
  <cfif fileExists(filePath)>
    <cffile action="delete" file="#filePath#">
  </cfif>

  <!---🦜 Update DB to remove profile_pic reference --->
  <cfquery datasource="user">
    UPDATE users
    SET profile_pic = NULL
    WHERE id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
  </cfquery>
</cfif>

<!--- 🦜Redirect back to user_account page --->
<cflocation url="user_account.cfm">
