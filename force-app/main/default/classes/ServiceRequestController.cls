public with sharing class ServiceRequestController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getServiceRequests(
        String searchKey,
        String status,
        String priority,
        String origin,
        String sortBy,
        String sortDirection,
        Integer pageSize,
        Integer pageNumber
    ) {

        if (pageSize == null || pageSize <= 0) {
            pageSize = 10;
        }

        if (pageNumber == null || pageNumber <= 0) {
            pageNumber = 1;
        }

        List<String> conditions = new List<String>();

        // Search by Case Number or Subject
        if (String.isNotBlank(searchKey)) {

            String searchValue = '%' + searchKey + '%';

            conditions.add(
                '(CaseNumber LIKE :searchValue OR Subject LIKE :searchValue)'
            );
        }

        // Status filter
        if (String.isNotBlank(status) && status != 'All') {
            conditions.add('Status = :status');
        }

        // Priority filter
        if (String.isNotBlank(priority) && priority != 'All') {
            conditions.add('Priority = :priority');
        }

        // Origin filter
        if (String.isNotBlank(origin) && origin != 'All') {
            conditions.add('Origin = :origin');
        }

        String query =
            'SELECT Id, CaseNumber, Subject, Status, Priority, Origin, ' +
            'Account.Name, Contact.Name, Owner.Name, Description, CreatedDate ' +
            'FROM Case';

        if (!conditions.isEmpty()) {
            query += ' WHERE ' + String.join(conditions, ' AND ');
        }

        // Allowed fields for sorting
        Set<String> allowedFields = new Set<String>{
            'CaseNumber',
            'Subject',
            'Status',
            'Priority',
            'Origin',
            'CreatedDate'
        };

        if (!allowedFields.contains(sortBy)) {
            sortBy = 'CreatedDate';
        }

        if (sortDirection != 'ASC' && sortDirection != 'DESC') {
            sortDirection = 'DESC';
        }

        query += ' ORDER BY ' + sortBy + ' ' + sortDirection;

        // Pagination
        Integer offsetValue = (pageNumber - 1) * pageSize;

        query += ' LIMIT ' + pageSize;
        query += ' OFFSET ' + offsetValue;

        return Database.query(query);
    }


    @AuraEnabled(cacheable=true)
    public static Integer getTotalRecords(
        String searchKey,
        String status,
        String priority,
        String origin
    ) {

        List<String> conditions = new List<String>();

        // Search
        if (String.isNotBlank(searchKey)) {

            String searchValue = '%' + searchKey + '%';

            conditions.add(
                '(CaseNumber LIKE :searchValue OR Subject LIKE :searchValue)'
            );
        }

        // Status
        if (String.isNotBlank(status) && status != 'All') {
            conditions.add('Status = :status');
        }

        // Priority
        if (String.isNotBlank(priority) && priority != 'All') {
            conditions.add('Priority = :priority');
        }

        // Origin
        if (String.isNotBlank(origin) && origin != 'All') {
            conditions.add('Origin = :origin');
        }

        String query = 'SELECT COUNT() FROM Case';

        if (!conditions.isEmpty()) {
            query += ' WHERE ' + String.join(conditions, ' AND ');
        }

        return Database.countQuery(query);
    }
}