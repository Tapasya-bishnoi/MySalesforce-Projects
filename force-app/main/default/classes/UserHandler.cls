public class UserHandler{

    @future
    public static void assignPermissionSet(List<Id> userIds) {

        PermissionSet ps = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Demo One PS'
            LIMIT 1
        ];

        List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();


        for(Id userId : userIds){
              psaList.add(
                new PermissionSetAssignment(
                    AssigneeId = userId,
                    PermissionSetId = ps.Id
                )
            );
        }

        if(!psaList.isEmpty()){
            insert psaList;
        }
    }
}