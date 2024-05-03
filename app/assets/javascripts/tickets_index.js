$(document).ready(function() {
    $('#tickets-table').DataTable({
        "order": [[0, 'asc'], [3, 'desc']], // Sort by user id and then by status
        "columnDefs": [
            { "orderable": false, "targets": [4] }, // Disable sorting for the Actions column
            {
                "targets": 2, // The index of the priority column
                "render": function(data, type, row, meta) {
                    return data.substring(4); // Hide the first four characters
                }
            }
        ]
    });
});