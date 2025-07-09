<cfcomponent>

  <!-- Get Customers -->
<cffunction name="getCustomers" access="remote" returnformat="json" output="false">
  <cfargument name="name" required="false" default="">
  <cfargument name="email" required="false" default="">
  <cfargument name="phone" required="false" default="">
  <cfargument name="startRow" type="numeric" required="true">
  <cfargument name="perPage" type="numeric" required="true">

  <cfquery name="getCustomers" datasource="user">
    SELECT id, name, email, phone FROM customers
    WHERE 1=1
    <cfif len(trim(arguments.name))>
      AND name LIKE <cfqueryparam value="%#arguments.name#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif len(trim(arguments.email))>
      AND email LIKE <cfqueryparam value="%#arguments.email#%" cfsqltype="cf_sql_varchar">
    </cfif>
    <cfif len(trim(arguments.phone))>
      AND phone LIKE <cfqueryparam value="%#arguments.phone#%" cfsqltype="cf_sql_varchar">
    </cfif>
    ORDER BY id DESC
    LIMIT <cfqueryparam value="#arguments.perPage#" cfsqltype="cf_sql_integer">
    OFFSET <cfqueryparam value="#arguments.startRow#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfset result = []>
  <cfloop query="getCustomers">
    <cfset arrayAppend(result, {
      "id": getCustomers.id,
      "name": getCustomers.name,
      "email": getCustomers.email,
      "phone": getCustomers.phone
    })>
  </cfloop>

  <cfreturn serializeJSON(result)>
</cffunction>
<cffunction name="getCustomerCount" access="remote" returntype="numeric" returnformat="plain" output="false">
  <cfquery name="countQuery" datasource="user">
    SELECT COUNT(*) AS total FROM customers
  </cfquery>
  <cfreturn countQuery.total>
</cffunction>



  <!-- 🦜Add Customer -->
  <cffunction name="addCustomer" access="remote" returntype="any" output="false">
    <cfargument name="name" type="string" required="true">
    <cfargument name="email" type="string" required="true">
    <cfargument name="phone" type="string" required="true">

    <cfquery datasource="user">
      INSERT INTO customers (name, email, phone)
      VALUES (
        <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
      )
    </cfquery>

    <cfreturn {status="success"}>
  </cffunction>

  <!-- 🦜Delete Customer -->
  <cffunction name="deleteCustomer" access="remote" returntype="any" output="false">
    <cfargument name="id" type="numeric" required="true">

    <cfquery datasource="user">
      DELETE FROM customers WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
    </cfquery>

    <cfreturn {status="success"}>
  </cffunction>
  <cffunction name="updateCustomer" access="remote" returnType="any" returnFormat="json">
  <cfargument name="id" type="numeric" required="yes">
  <cfargument name="name" type="string" required="yes">
  <cfargument name="email" type="string" required="yes">
  <cfargument name="phone" type="string" required="yes">

  <cfquery datasource="user">
    UPDATE customers
    SET name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar">,
        email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">,
        phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">
    WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
  </cfquery>

  <cfreturn {"status": "success"}>
</cffunction>




</cfcomponent>
