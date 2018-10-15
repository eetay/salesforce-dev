public without sharing class SL1JobBatcher implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    final public String batchId;
    final public SL1Connection sl1;

    public SL1JobBatcher( String batchId, SL1Connection sl1 ) {
        this.batchId = batchId;
        this.sl1 = sl1;
    }

    public void execute(Database.BatchableContext bc, List<SL1Job__c> scope) {
        List<SObject> objectsToUpdate = new List<SObject>();
        List<SObject> objectsToInsert = new List<SObject>();
        for (SL1Job__c job: scope) {
            this.sl1.jsonCallout( new SL1Request(job, new SL1GetAssetHandler(objectsToUpdate, objectsToInsert)) );
        }
        if (objectsToUpdate.size()>0) update objectsToUpdate;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Path__c, Result__c FROM SL1Job__c WHERE BatchId__c = :batchId ]);
    }

    public void finish(Database.BatchableContext bc) {
    }
}
