<cftry>

    <!-- 🦜PDF Query -->
    <cfquery name="getreq" datasource="user">
        SELECT title, description FROM requests ORDER BY id DESC
    </cfquery>

    <!--🦜 Generate PDF -->
    <cfdocument format="pdf" filename="requests.pdf" overwrite="yes">

        <h2 style="text-align: center;">Submitted Requests</h2>
        <table border="1" cellpadding="8" cellspacing="0" width="100%">
            <thead>
                <tr style="background-color: #72361a; color: white;">
                    <th>Title</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="getreq">
                    <tr>
                        <td>#title#</td>
                        <td>#description#</td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>

    </cfdocument>

    <!--🦜 Auto-download -->
    <cfheader name="Content-Disposition" value="attachment; filename=requests.pdf">
    <cfcontent type="application/pdf" file="#expandPath('./requests.pdf')#" deleteFile="no">

<cfcatch>
    <cfoutput>
        <h3>Error occurred!</h3>
        <p>#cfcatch.message#</p>
        <p>#cfcatch.detail#</p>
    </cfoutput>
</cfcatch>
</cftry>
