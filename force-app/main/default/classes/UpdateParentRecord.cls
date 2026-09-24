public class UpdateParentRecord implements Queueable {

    private List<Account> accList;
    private Id parentAccId; 

    // Constructor
    public UpdateParentRecord(List<Account> recs, Id id) {
        this.accList = recs;
        this.parentAccId = id;
    }

    public void execute(System.QueueableContext qc) {

        for (Account acc : accList) {
            acc.ParentId = parentAccId;
        }

        update accList;
    }
}