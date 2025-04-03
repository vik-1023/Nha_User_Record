<%-- 
    Document   : AddNhaAccountsDetails
    Created on : 28 Mar, 2025, 10:55:12 AM
    Author     : vikram
--%>
<%
    response.setHeader("Cache-Control", "no-store");

    HttpSession s = request.getSession(false);

    String LogUsername = null;

    if (s != null) {
        LogUsername = (String) s.getAttribute("LogUsername");
        System.out.println(LogUsername);
        if (LogUsername == null) {
            response.sendRedirect("Login");
            return;
        }
    } else {
        response.sendRedirect("Login");
        return;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AddNhaAccountsDetails</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Add SweetAlert2 CSS in your <head> -->
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">

        <!-- Add SweetAlert2 JS before closing body tag -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.all.min.js"></script>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                padding: 20px;
                background-color: #f8f9fa;
            }



            .table th, .table td {
                vertical-align: middle;
            }
            .table thead th {
                text-transform: uppercase;
            }



            .form-container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .form-group label {
                font-weight: 600;
            }

            /*================*/

            /* Responsive table styling */
            @media (max-width: 768px) {
                table {
                    border: 0;
                }

                table thead {
                    display: none;
                }

                table tr {
                    margin-bottom: 15px;
                    display: block;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }

                table td {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    text-align: right;
                    padding: 8px 15px;
                    border-bottom: 1px solid #eee;
                }

                table td:before {
                    content: attr(data-label);
                    font-weight: bold;
                    margin-right: 15px;
                }

                table td:last-child {
                    border-bottom: 0;
                }

                /* Stack buttons vertically on small screens */
                .d-flex.flex-nowrap.gap-1 {
                    flex-direction: column;
                    gap: 0.3rem !important;
                }

                .btn-sm {
                    padding: 0.25rem 0.5rem;
                    font-size: 0.75rem;
                }
            }

            /* Hover effect for better UX */
            .table-hover tbody tr:hover {
                background-color: rgba(0, 0, 0, 0.05);
            }
        </style>

        <style>
            /* Highlight editable cells */
            .editable-cell {
                background-color: #fff8e1;
            }

            /* Editing mode row highlight */
            tr.table-warning {
                background-color: #fff3cd !important;
            }

            /* Input fields in edit mode */
            .editable-cell input {
                width: 100%;
                padding: 0.25rem 0.5rem;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .d-flex.flex-nowrap.gap-3 {
                    flex-direction: column;
                    gap: 0.3rem !important;
                }

                .btn-sm {
                    width: 100%;
                    margin-bottom: 0.2rem;
                }
            }
        </style>
    </head>
    <body>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
            Add New Account
        </button>
        <button type="button" class="btn btn-secondary"><a href="AddNhaUserDetails" style="color: white; text-decoration: none">Show Users</a></button>
        <button type="button" class="btn btn-danger"><a href="Logout"  style="color: white; text-decoration: none">Logout</a></button>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add Account</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-md-12">
                                    <div class="form-container">

                                        <form id="userForm">
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="accountid">Account Id<span style="color: red;">*</span></label>
                                                    <input type="text" class="form-control" id="accountid" name="accountid" placeholder="Enter accountid" required>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="accountname">Account Name <span style="color: red;">*</span></label>
                                                    <input type="text" class="form-control" id="accountname" name="accountname" placeholder="Enter accountname" required>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <label for="companyname">Company Name <span style="color: red;">*</span></label>
                                                <select id="companyname" name="companyname" class="form-control" required>
                                                    <option >Choose...</option>
                                                    <option value="National Health Authority">National Health Authority</option>

                                                </select>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="password">Password <span style="color: red;">*</span></label>
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="environment">Environment <span style="color: red;">*</span></label>

                                                    <select id="environment" name="environment" class="form-control" required>
                                                        <option >Choose...</option>
                                                        <option value="sandbox">sandbox</option>
                                                        <option value="production">production</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="setup">Setup</label>
                                                    <select id="setup" name="setup" class="form-control" required>
                                                        <option >Choose...</option>
                                                        <option value="-1">-1</option>
                                                        <option value="0">0</option>
                                                        <option value="9">9</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="department">Department<span style="color: red;">*</span></label>
                                                    <select id="department" name="department" class="form-control" required>
                                                        <option >Choose...</option>
                                                        <option value="PMJAY">PMJAY</option>
                                                        <option value="ABDM">ABDM</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <!--                                            <div class="form-group">
                                                                                            <label for="apiurl">Api Url <span style="color: red;">*</span></label>
                                                                                            <input type="text" class="form-control" id="apiurl"  name="apiurl" placeholder="Enter Api Url" required>
                                                                                        </div>-->
                                            <button type="submit" class="btn btn-primary btn-block">Submit</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>  
                    </div>

                </div>
            </div>
        </div>

        <div class="container-fluid">
            <section>
                <h1 class="mb-4 text-center">NHA Accounts Details</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark">
                            <tr class="text-center">
                                <th scope="col">ID</th>
                                <th scope="col">ACCOUNT NAME</th>
                                <th scope="col">COMPANY NAME</th>
                                <th scope="col">SETUP</th>
                                <th scope="col">PASSWORD</th>
                                <th scope="col">ENVIRONMENT</th>
                                <th scope="col">API URL</th>
                                <th scope="col">DEPARTMENT</th>
                                <th scope="col">ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody id="userTableBody" class="text-center">
                            <!-- Rows will be populated here by AJAX -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>


        <script>
            $(document).ready(function () {
                // Variable to store currently edited row
                var currentlyEditing = null;

                // Load users on page load
                loadUsers();

                // Function to load users
                function loadUsers() {
                    $.ajax({
                        url: 'getAllAccounts',
                        type: 'GET',
                        dataType: 'json',
                        success: function (data) {
                            var tableBody = $('#userTableBody');
                            tableBody.empty();

                            if (data.length === 0) {
                                tableBody.append('<tr><td colspan="10" class="text-center">No users found</td></tr>');
                                return;
                            }

                            $.each(data, function (index, user) {
                                var row = $('<tr></tr>');

                                // Helper function to create table cells
                                function createCell(label, value, editable) {
                                    var cell = $('<td>').attr('data-label', label);
                                    if (editable)
                                        cell.addClass('editable-cell');
                                    cell.text(value || '-');
                                    return cell;
                                }

                                row.append(createCell("id", user.id, false));
                                row.append(createCell("accountname", user.accountname, true));
                                row.append(createCell("companyname", user.companyname, true));
                                row.append(createCell("Setup", user.Setup, true));
                                row.append(createCell("password", user.password, true));
                                row.append(createCell("environment", user.environment, true));
                                row.append(createCell("api_url", user.api_url, true));
                                row.append(createCell("department", user.department, true));

                                // Actions column with buttons
                                var actions = $('<td>').attr('data-label', 'ACTIONS').append(
                                        $('<div>').addClass('d-flex flex-nowrap gap-3').append(
                                        $('<button>').addClass('btn btn-sm btn-primary edit-btn')
                                        .attr('data-id', user.id)
                                        .html('<i class="bi bi-pencil-square"></i> Edit'),
                                        $('<button>').addClass('btn btn-sm btn-success update-btn')
                                        .attr('data-id', user.id)
                                        .html('<i class="bi bi-check-circle"></i> Update')
                                        .hide(),
                                        $('<button>').addClass('btn btn-sm btn-secondary cancel-btn')
                                        .attr('data-id', user.id)
                                        .html('<i class="bi bi-x-circle"></i> Cancel')
                                        .hide(),
                                        $('<button>').addClass('btn btn-sm btn-danger delete-btn')
                                        .attr('data-id', user.id)
                                        .html('<i class="bi bi-trash"></i> Delete')
                                        )
                                        );

                                row.append(actions);
                                tableBody.append(row);
                            });
                        },
                        error: function (xhr, status, error) {
                            console.error('Error loading users:', error);
                            $('#userTableBody').html('<tr><td colspan="10" class="text-center text-danger">Error loading data</td></tr>');
                        }
                    });
                }

                // Event delegation for dynamic buttons
                $('#userTableBody')
                        .on('click', '.edit-btn', function () {
                            var row = $(this).closest('tr');
                            var userId = $(this).data('id');
                            console.log("Edit clicked for ID:", userId);

                            if (currentlyEditing && currentlyEditing.id !== userId) {
                                cancelEdit(currentlyEditing.row);
                            }
                            startEdit(row, userId);
                        })
                        .on('click', '.update-btn', function () {
                            var row = $(this).closest('tr');
                            var userId = $(this).data('id');
                            updateUser(row, userId);
                        })
                        .on('click', '.cancel-btn', function () {
                            var row = $(this).closest('tr');
                            cancelEdit(row);
                        })
                        .on('click', '.delete-btn', function () {
                            var userId = $(this).data('id');
                            deleteUser(userId);
                        });

                // Function to start editing a row
                function startEdit(row, userId) {
                    if (!userId) {
                        console.error("No user ID provided for editing");
                        return;
                    }

                    // Store the original values
                    var originalValues = {};
                    row.find('.editable-cell').each(function () {
                        var label = $(this).data('label');
                        originalValues[label] = $(this).text().trim();
                        $(this).html('<input type="text" class="form-control form-control-sm" value="' + $(this).text().trim() + '">');
                    });

                    // Toggle button visibility
                    row.find('.edit-btn, .delete-btn').hide();
                    row.find('.update-btn, .cancel-btn').show();

                    // Add editing class and store original values
                    row.addClass('table-warning');
                    row.data('original', originalValues);

                    // Set currently editing
                    currentlyEditing = {
                        id: userId,
                        row: row
                    };
                }

                // Function to cancel editing
                function cancelEdit(row) {
                    // Restore original values
                    var originalValues = row.data('original');
                    row.find('.editable-cell').each(function () {
                        var label = $(this).data('label');
                        $(this).text(originalValues[label]);
                    });

                    // Toggle button visibility
                    row.find('.edit-btn, .delete-btn').show();
                    row.find('.update-btn, .cancel-btn').hide();

                    // Remove editing class
                    row.removeClass('table-warning');

                    // Clear currently editing
                    currentlyEditing = null;
                }

                // Function to update user
                function updateUser(row, userId) {
                    if (!userId) {
                        console.error("No user ID provided for update");
                        return;
                    }

                    if (!confirm('Are you sure you want to update this user?')) {
                        return;
                    }

                    // Collect updated data
                    var updatedData = {
                        id: userId
                    };

                    row.find('.editable-cell').each(function () {
                        var label = $(this).data('label');
                        var value = $(this).find('input').val();
                        updatedData[label] = value;
                    });

                    console.log("Sending update data:", updatedData);

                    // Send update request
                    $.ajax({
                        url: 'updateAccountDetails',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(updatedData),
                        success: function (response) {
                            if (response.status === 'success') {
                                alert('User updated successfully');
                                cancelEdit(row);
                                loadUsers(); // Refresh the data
                            } else {
                                alert('Error: ' + response.message);
                                cancelEdit(row);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert('Error updating user: ' + error);
                            cancelEdit(row);
                        }
                    });
                }

                // Function to delete user
                function deleteUser(userId) {
                    if (!userId) {
                        console.error("No user ID provided for deletion");
                        return;
                    }

                    if (!confirm('Are you sure you want to delete this user?')) {
                        return;
                    }

                    $.ajax({
                        url: 'deleteAccountDetails?id=' + userId,
                        type: 'DELETE',
                        success: function (response) {
                            alert('User deleted successfully');
                            loadUsers(); // Refresh the data
                        },
                        error: function (xhr, status, error) {
                            alert('Error deleting user: ' + error);
                        }
                    });
                }
            });
        </script>



        <script>
            document.getElementById("userForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Prevent normal form submission

                // Get form field values
                const accountid = document.getElementById("accountid").value;
                const accountname = document.getElementById("accountname").value;
                const companyname = document.getElementById("companyname").value;
                const password = document.getElementById("password").value;
                const environment = document.getElementById("environment").value;
                const setup = document.getElementById("setup").value;
                const department = document.getElementById("department").value;


                // Validate required fields
                if (!accountid || !accountname || !companyname || !password || !environment || !setup || !department) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Please fill out all required fields.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Validate ID (must be an integer)
                if (!/^\d+$/.test(accountid)) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'ID must be an integer.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }





                // Send the AJAX request using fetch
                const formData = new FormData(this);

                fetch('AddAccountDetails', {
                    method: 'POST',
                    body: new URLSearchParams(new FormData(this)), // Convert FormData to URLSearchParams
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                Swal.fire({
                                    title: 'Success!',
                                    text: data.success,
                                    icon: 'success',
                                    confirmButtonText: 'OK'
                                });
                            } else if (data.error) {
                                Swal.fire({
                                    title: 'Error!',
                                    text: data.error,
                                    icon: 'error',
                                    confirmButtonText: 'OK'
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            Swal.fire({
                                title: 'An error occurred',
                                text: 'Something went wrong while processing your request.',
                                icon: 'error',
                                confirmButtonText: 'Try Again'
                            });
                        });
            });
        </script>
<script>
            document.addEventListener('DOMContentLoaded', function () {
                // Select the logout button
                const logoutButton = document.querySelector('a[href="Logout"]');

                // Add click event listener to the logout button
                logoutButton.addEventListener('click', function (event) {
                    event.preventDefault(); // Prevent the default link behavior

                    // Show SweetAlert confirmation popup
                    Swal.fire({
                        title: 'Are you sure?',
                        text: 'You are about to log out. Do you want to continue?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes, log out!',
                        cancelButtonText: 'Cancel'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Redirect to the logout URL if confirmed
                            window.location.href = logoutButton.href;
                        }
                    });
                });
            });
        </script>
        
        
         <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

        <!-- SweetAlert2 JS -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
