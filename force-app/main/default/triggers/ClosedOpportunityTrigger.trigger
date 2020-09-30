Trigger ClosedOpportunityTrigger on Opportunity(After Insert, After Update){
    List<Task> taskList = new List<Task>();
    for(Opportunity opp: Trigger.New){
        if(opp.StageName == 'Closed Won'){
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatId = opp.Id;
            taskList.add(newTask);
        }
    }
    insert taskList;
}