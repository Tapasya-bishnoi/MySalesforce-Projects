public with sharing class MyName {

    @InvocableMethod(
        label='Say Hello'
        description='Returns a hello message'
    )
    public static List<String> sayHello(List<String> names) {

        return new List<String>{'Hello Tapasya!'};
    }
}