<cfif structKeyExists(form, "profile_pic") AND len(form.profile_pic)>

  <!--- Define the folder and file --->
  <cfset uploadDir = expandPath("uploads/")>
  <cfset fileResult = "">

  <!--- Create the folder if it doesn't exist --->
  <cffile action="upload"
          destination="#uploadDir#"
          nameconflict="makeunique"
          filefield="profile_pic"
          result="fileResult">

  <!--- Save filename to user's record --->
  <cfquery datasource="user">
    UPDATE users
    SET profile_pic = <cfqueryparam value="#fileResult.serverFile#" cfsqltype="cf_sql_varchar">
    WHERE id = <cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfoutput>
    <p style="color: green;">File uploaded successfully!</p>
    <img src="uploads/#fileResult.serverFile#" style="width: 150px; border-radius: 50%;">
    <br>
    <a href="user_account.cfm">Go to Profile</a>
  </cfoutput>

<cfelse>
  <cfoutput>
    <p style="color: red;">No file selected.</p>
    <a href="user_account.cfm">Back to Profile</a>
  </cfoutput>
</cfif>
