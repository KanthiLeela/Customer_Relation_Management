<cfcomponent>
 <cfset this.name = "CRMv2"> 
    <cfset this.sessionManagement = true>
    <cfset this.applicationTimeout = createTimeSpan(0, 2, 0, 0)>
    <cfset this.sessionTimeout = createTimeSpan(0, 0, 30, 0)>
</cfcomponent>
