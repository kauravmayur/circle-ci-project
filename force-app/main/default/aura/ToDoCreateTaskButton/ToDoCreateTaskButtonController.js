({
    handleCreateNewTask : function(component, event, helper) {
        //const input = document.getElementById('task-input').value;
        var input = component.get('v.inputValue');
        alert(input);
        let tasks = component.get('v.taskList');
        tasks.push(input);
        component.set('v.taskList',tasks);
    }
})