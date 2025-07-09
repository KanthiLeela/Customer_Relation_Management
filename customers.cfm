<!DOCTYPE html>
<html>
<head>
  <title>Customer Management</title>
  <meta charset="UTF-8">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f4f7;
      margin: 0;
      padding: 0;
    }

    .header {
      background-color: #ffffff;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .header h2 {
      margin: 0;
      color: #333;
    }

    .header-buttons {
      display: flex;
      gap: 10px;
    }

    .btn {
      padding: 10px 16px;
      font-weight: bold;
      color: white;
      background-color: #72361a;
      border: none;
      border-radius: 15px;
      text-decoration: none;
      cursor: pointer;
    }

    .btn:hover {
      background-color: #c0a48e;
    }

    .btn-danger {
      background-color: #dc3545;
    }

    .btn-danger:hover {
      background-color: #c82333;
    }

    .btn-success {
      background-color: #bd7948;
    }

    .btn-success:hover {
      background-color: #72361a;
    }

    .container {
      max-width: 1000px;
      margin: 20px auto;
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .search-bar, .customer-form {
      display: flex;
      gap: 10px;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }

    input[type="text"] {
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 5px;
      width: 100%;
      max-width: 200px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      text-align: center;
      padding: 12px;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #72361a;
      color: white;
    }

    tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    .pagination {
      text-align: center;
      margin-top: 20px;
    }
  </style>

  <script>
    function fetchCustomers(page = 1) {
      const name = document.getElementById("search_name").value;
      const email = document.getElementById("search_email").value;
      const phone = document.getElementById("search_phone").value;
      const perPage = parseInt(document.getElementById("perPage").value);
      const startRow = (page - 1) * perPage;

      document.getElementById("currentPage").value = page;

      fetch("CustomerService.cfc?method=getCustomers&returnformat=json", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `name=${name}&email=${email}&phone=${phone}&startRow=${startRow}&perPage=${perPage}`
      })
      .then(res => res.json())
      .then(data => {
        const tbody = document.querySelector("#customerTable tbody");
        tbody.innerHTML = "";
        data.forEach(c => {
          tbody.innerHTML += `
            <tr>
              <td>${c.id}</td>
              <td>${c.name}</td>
              <td>${c.email}</td>
              <td>${c.phone}</td>
              <td>
                <button class='btn btn-success' onclick="editCustomer(${c.id}, '${c.name}', '${c.email}', '${c.phone}')">Edit</button>
                <button class='btn btn-danger' onclick="deleteCustomer(${c.id})">Delete</button>
              </td>
            </tr>`;
        });
        renderPagination();
      });
    }

    function renderPagination() {
      const perPage = parseInt(document.getElementById("perPage").value);
      const currentPage = parseInt(document.getElementById("currentPage").value);

      fetch("CustomerService.cfc?method=getCustomerCount")
        .then(res => res.text())
        .then(total => {
          const totalPages = Math.ceil(total / perPage);
          const paginationDiv = document.getElementById("paginationControls");
          paginationDiv.innerHTML = "";

          if (currentPage > 1) {
            paginationDiv.innerHTML += `<button class='btn' onclick='fetchCustomers(${currentPage - 1})'>Prev</button>`;
          }

          for (let i = 1; i <= totalPages; i++) {
            const style = i === currentPage ? "style='font-weight:bold;'" : "";
            paginationDiv.innerHTML += `<button class='btn' onclick='fetchCustomers(${i})' ${style}>${i}</button>`;
          }

          if (currentPage < totalPages) {
            paginationDiv.innerHTML += `<button class='btn' onclick='fetchCustomers(${currentPage + 1})'>Next</button>`;
          }
        });
    }

    function addCustomer() {
      const id = document.getElementById("customerId").value;
      const name = document.getElementById("name").value;
      const email = document.getElementById("email").value;
      const phone = document.getElementById("phone").value;

      if (!name || !email || !phone) {
        alert("Please fill all fields");
        return;
      }

      let method = id ? "updateCustomer" : "addCustomer";
      let body = `name=${name}&email=${email}&phone=${phone}`;
      if (id) body += `&id=${id}`;

      fetch(`CustomerService.cfc?method=${method}&returnformat=json`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: body
      })
      .then(() => {
        document.getElementById("customerId").value = "";
        document.getElementById("name").value = "";
        document.getElementById("email").value = "";
        document.getElementById("phone").value = "";
        fetchCustomers();
      });
    }

    function deleteCustomer(id) {
      if (confirm("Are you sure you want to delete this customer?")) {
        fetch("CustomerService.cfc?method=deleteCustomer&returnformat=json", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: `id=${id}`
        }).then(() => fetchCustomers());
      }
    }

    function editCustomer(id, name, email, phone) {
      document.getElementById("customerId").value = id;
      document.getElementById("name").value = name;
      document.getElementById("email").value = email;
      document.getElementById("phone").value = phone;
    }

    window.onload = fetchCustomers;
  </script>
</head>
<body>

<div class="header">
  <div class="header-buttons">
    <a href="home.cfm" class="btn">Back to Home</a>
    <a href="download_customers_pdf.cfm" class="btn">Download PDF</a>
  </div>
</div>

<div class="container">
  <h2>Customer Management</h2>

  <input type="hidden" id="customerId">
  <input type="hidden" id="currentPage" value="1">
  <input type="hidden" id="perPage" value="5">

  <div class="search-bar">
    <input type="text" id="search_name" placeholder="Search by Name">
    <input type="text" id="search_email" placeholder="Search by Email">
    <input type="text" id="search_phone" placeholder="Search by Phone">
    <button class="btn" onclick="fetchCustomers()">Search</button>
  </div>

  <div class="customer-form">
    <input type="text" id="name" placeholder="Name">
    <input type="text" id="email" placeholder="Email">
    <input type="text" id="phone" placeholder="Phone">
    <button class="btn" onclick="addCustomer()">Add Customer</button>
  </div>

  <table id="customerTable">
    <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>

  <div id="paginationControls" class="pagination"></div>
</div>

</body>
</html>
