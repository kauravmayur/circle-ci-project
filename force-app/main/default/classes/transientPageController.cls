public class transientPageController {
    dateTime t1;
    transient dateTime t2;
    public String getT2() {
        if (t2 == null) t2 = System.now();
        return '' + t2;

    }


    public String getT1() {
        if (t1 == null) t1 = System.now();
        return '' + t1;

    }

}