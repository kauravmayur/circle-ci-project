trigger PriorityUpdateOnTicketTrigger on ticket__c (before insert, before update) {
    if(trigger.isInsert || trigger.isUpdate){
        Map<String, priority__c> priorityMap = new Map<String, priority__c>();
        Map<Id, String> priorityIdNameMap = new Map<Id, String>();
        List<priority__c> priorityList = [SELECT Id, Name, impact__c,impact__r.name, urgency__c, urgency__r.name FROM priority__c];
        for(priority__c priority: priorityList){
            priorityMap.put(priority.impact__r.name+'-'+priority.urgency__r.name, priority);
            priorityIdNameMap.put(priority.impact__c, priority.impact__r.Name);
            priorityIdNameMap.put(priority.urgency__c, priority.urgency__r.Name);
        }
        
        for(ticket__c ticket: trigger.New){
            if(ticket.impact__c != null && ticket.urgency__c != null){
                string impactUrgency = priorityIdNameMap.get(ticket.impact__c)+'-'+priorityIdNameMap.get(ticket.urgency__c);
                if(priorityMap.containsKey(impactUrgency)){
                	ticket.priority__c = priorityMap.get(impactUrgency).id;
                }
            }
        }
    }
}