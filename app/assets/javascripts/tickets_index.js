$(document).ready(function() {
    $('#tickets-table').DataTable({
        "order": [[0, 'asc'], [4, 'desc']], // Sort by ticket id and then by status
        "columnDefs": [
            { "orderable": false, "targets": [5] }, // Disable sorting for the Actions column
            {
                "targets": 3, // The index of the priority column
                "render": function(data, type, row, meta) {
                    if (type === 'display') {
                        return data.substring(4); // Hide the first four characters
                    }
                    return data; // Use original data for sorting
                }
            }
        ]
    });
});
