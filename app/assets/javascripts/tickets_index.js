$(document).ready(function() {
    $('#tickets-table').DataTable({
        "order": [[1, 'asc'], [2, 'asc']], // Sort by priority and then by status
        "columnDefs": [
            { "orderable": false, "targets": [3] } // Disable sorting for the Actions column
        ]
    });
});