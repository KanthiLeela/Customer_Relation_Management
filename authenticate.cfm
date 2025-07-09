<cfparam name="form.username" default="">
<cfparam name="form.password" default="">

<cfif structKeyExists(form, "username") AND structKeyExists(form, "password")>

    <cfquery name="login" datasource="user">
        SELECT id, username, role
        FROM users
        WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
          AND password = <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif login.recordcount EQ 1>
        <!-- Store login info in session -->
        <cfset session.userid = login.id>
        <cfset session.username = login.username>
        <cfset session.role = login.role> <!-- admin or user -->

        <!-- Redirect to home -->
        <cflocation url="home.cfm">
    <cfelse>
        <!-- Invalid login -->
        <cflocation url="login.cfm?error=true">
    </cfif>

</cfif>
