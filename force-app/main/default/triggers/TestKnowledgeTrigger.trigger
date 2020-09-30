trigger TestKnowledgeTrigger on Knowledge__kav (after insert,after update, before insert, before update) {
    System.debug('**********TestKnowledgeTrigger************');
}