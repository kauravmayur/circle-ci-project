global class Day1Class {
    Private integer count;
    public string name;
    global string industry;
    Public Day1Class(){
        count = 9;
        name = 'Mayur';
        industry = 'Engineering';
        System.debug('count : '+count);
        System.debug('name  : '+name );
        System.debug('industry : '+industry);
    }
    private string getAccount(){
        string collageName = 'ITM Collage';
        return collageName;
    }
}