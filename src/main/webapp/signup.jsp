<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Signup Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding: 20px;
                background-color: #f8f9fa;
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

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
            Add New Users
        </button>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add User Information</h5>
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
                                                    <label for="id">ID <span style="color: red;">*</span></label>
                                                    <input type="text" class="form-control" id="id" name="id" placeholder="Enter ID" required>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="username">Username <span style="color: red;">*</span></label>
                                                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter Username" required>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="password">Password <span style="color: red;">*</span></label>
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="chat_id">Chat ID</label>
                                                    <input type="text" class="form-control" id="chat_id" name="chat_id" placeholder="Enter Chat ID">
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="email">Email <span style="color: red;">*</span></label>
                                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" required>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="clients">Clients <span style="color: red;">*</span></label>
                                                    <input type="text" class="form-control" id="clients"  name="clients" placeholder="Enter Clients" required>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label for="status">Status <span style="color: red;">*</span></label>
                                                    <select id="status" name="status" class="form-control" required>

                                                        <option selected value="true">true</option>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="user_type">User Type <span style="color: red;">*</span></label>
                                                    <select id="user_type" name="user_type" class="form-control" required>
                                                        <option >Choose...</option>
                                                        <option value="admin">admin</option>
                                                        <option value="PMJAY">PMJAY</option>
                                                        <option value="ABDM">ABDM</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="links">Links <span style="color: red;">*</span></label>
                                                <input type="text" class="form-control" id="links"  name="links" placeholder="Enter Links" required>
                                            </div>
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
                <h1 class="mb-4" style="text-align: center">NHA Users Details</h1>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">USERNAME</th>
                                <th scope="col">PASSWORD</th>
                                <th scope="col">CHAT ID</th>
                                <th scope="col">EMAIL</th>
                                <th scope="col">CLIENTS</th>
                                <th scope="col">STATUS</th>
                                <th scope="col">USER TYPE</th>
                                <th scope="col">LINKS</th>
                                <th scope="col">ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody id="userTableBody">
                            <!-- Rows will be populated here by AJAX -->
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Bootstrap Bundle with Popper -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script>
            $(document).ready(function () {
                // Variable to store currently edited row
                var currentlyEditing = null;

                // Load users on page load
                loadUsers();

                // Function to load users
                function loadUsers() {
                    $.ajax({
                        url: 'getAllUsers',
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

                                row.append(createCell("ID", user.id, false));
                                row.append(createCell("USERNAME", user.username, true));
                                row.append(createCell("PASSWORD", user.password, true));
                                row.append(createCell("CHAT ID", user.chat_id, true));
                                row.append(createCell("EMAIL", user.email, true));
                                row.append(createCell("CLIENTS", user.clients, true));
                                row.append(createCell("STATUS", user.status, true));
                                row.append(createCell("USER TYPE", user.user_type, true));
                                row.append(createCell("LINKS", user.links, true));

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
                        // Convert label to snake_case format
                        updatedData[label.toLowerCase().replace(' ', '_')] = value;
                    });

                    console.log("Sending update data:", updatedData);

                    // Send update request
                    $.ajax({
                        url: 'updateUserDetails',
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
                        url: 'deleteUsers?id=' + userId,
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


        <!-- Form Submission with Validation and AJAX -->
        <script>
            document.getElementById("userForm").addEventListener("submit", function (event) {
                event.preventDefault(); // Prevent normal form submission

                // Get form field values
                const id = document.getElementById("id").value;
                const username = document.getElementById("username").value;
                const password = document.getElementById("password").value;
                const email = document.getElementById("email").value;
                const clients = document.getElementById("clients").value;
                const status = document.getElementById("status").value;
                const userType = document.getElementById("user_type").value;
                const links = document.getElementById("links").value;
                const chatId = document.getElementById("chat_id").value;

                // Validate required fields
                if (!id || !username || !password || !email || !clients || !status || !userType || !links) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'Please fill out all required fields.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Validate ID (must be an integer)
                if (!/^\d+$/.test(id)) {
                    Swal.fire({
                        title: 'Error!',
                        text: 'ID must be an integer.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                    return;
                }

                // Convert Clients and Links to uppercase or lowercase based on conditions
                let upperClients = clients;
                let upperLinks = links;

                if (clients.toUpperCase() === "PMJAY" || clients.toUpperCase() === "ABDM") {
                    upperClients = clients.toUpperCase();
                    upperLinks = links.toUpperCase();
                } else {
                    upperClients = clients.toLowerCase();
                    upperLinks = links.toLowerCase();
                }

                // Update the form data with uppercase Clients and Links
                document.getElementById("clients").value = upperClients;
                document.getElementById("links").value = upperLinks;

                // Send the AJAX request using fetch
                const formData = new FormData(this);

                fetch('addUserRecord', {
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




        <!-- Add SweetAlert2 CSS in your <head> -->
        <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.min.css" rel="stylesheet">

        <!-- Add SweetAlert2 JS before closing body tag -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.5.0/dist/sweetalert2.all.min.js"></script>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



    </body>
</html>