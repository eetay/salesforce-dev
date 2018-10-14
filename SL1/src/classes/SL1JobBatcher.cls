public without sharing class SL1JobBatcher implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    final public String batchId;
    final public SL1Connection sl1;

    public SL1JobBatcher( String batchId, SL1Connection sl1 ) {
        this.batchId = batchId;
        this.sl1 = sl1;
    }
    public void execute(Database.BatchableContext bc, List<SL1Job__c> scope) {
        for (SL1Job__c job: scope) {
            this.sl1.jsonCallout( new SL1Request(job.Path__c, new SL1GetAssetHandler(job)) );
        }
        update scope;
    }
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Path__c, Result__c FROM SL1Job__c WHERE BatchId__c = :batchId]);
    }
    public void finish(Database.BatchableContext bc) {
    }
}
