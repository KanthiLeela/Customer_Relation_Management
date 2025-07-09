<!DOCTYPE html>
<html>
<head>
  <title>Scheduled Email Task</title>
  <meta charset="UTF-8">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f7f7f7;
      padding: 40px;
      color: #333;
    }

    .status-box {
      background-color: #fff;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      max-width: 600px;
      margin: auto;
    }

    h2 {
      color: #007BFF;
    }

    p {
      font-size: 16px;
    }

    .success {
      color: green;
      font-weight: bold;
    }

    .error {
      color: red;
      font-weight: bold;
    }

    .back {
      margin-top: 20px;
      display: inline-block;
      text-decoration: none;
      color: #007BFF;
      font-weight: bold;
    }

    .back:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<div class="status-box">
  <cfscript>
    try {
      // Step 1: Get today's request count
      requests = queryExecute(
        "SELECT COUNT(*) AS total FROM requests WHERE DATE(created_at) = CURDATE()",
        [],
        {datasource = "user"}
      );

      total = requests.total ?: 0;
      mailBody = "<h3>CRM Daily Report</h3><p>Total Requests Submitted Today: <strong>#total#</strong></p>";

      // Step 2: Send the email
      cfmail(
        to = "kanthileela18@gmail.com",          // Replace with actual HR email
        from = "leelanarayan1214@gmail.com",       // Replace with a valid sender
        subject = "CRM Daily Report",
        type = "html",
        server = "smtp.gmail.com"            // Or your actual mail server
      ) {
        writeOutput(mailBody);
      }

      // Step 3: Log this execution
      queryExecute(
        "INSERT INTO scheduler_logs (task_name, executed_at) VALUES (?, NOW())",
        ["DailyEmailReport"],
        {datasource = "user"}
      );

      // Step 4: Show success message
      writeOutput("<h2>Task Executed</h2>");
      writeOutput("<p class='success'>Email sent and task logged successfully.</p>");
    } catch (any e) {
      writeOutput("<h2>Error Occurred</h2>");
      writeOutput("<p class='error'>#e.message#</p>");
    }
  </cfscript>

  <a href="home.cfm" class="back">← Back to Home</a>
</div>

</body>
</html>
