trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {
    for(Session_Speaker__c sessionSpeaker : trigger.new) {
        //Retrieve session information including date and time
        session__c session = [SELECT Id, Session_Date__c FROM Session__c
                             WHERE Id =:sessionSpeaker.Session__c];
        
        //Retrieve conflicts; other assignments for that speaker at that same time
        List<Session_Speaker__c> conflicts = [SELECT Id FROM Session_Speaker__c
                                              WHERE Speaker__c = :sessionSpeaker.Speaker__c
                                              AND Session__r.Session_Date__c = :session.Session_Date__c];
        
        //If conflicts exist, add an error; reject the database operations
        if(!conflicts.isEmpty()){
            sessionSpeaker.addError('The Speaker is already booked at that time');
        }
    }

}