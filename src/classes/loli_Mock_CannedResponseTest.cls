@isTest
public with sharing class loli_Mock_CannedResponseTest {

    //----------------------------- Classes ----------------------------------//

    private class Answer implements loli_Mock_IAnswer {

        public Object onInvokation(loli_Mock_Invokation invokation) {
            return 'Hello World';
        }

    }


    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static Testmethod void Equal() {
        String methodName = 'testMethod';
        loli_Mock_Invokation invokationToResponseTo = new loli_Mock_Invokation(methodName, new List<Object> {10, 12});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invokationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse(methodName, invokationToResponseTo, answer);

        System.assertEquals(cannedResponseBase, cannedResponseCompare);
    }

    private static Testmethod void Equal_NotEqal_MethodName() {
        String methodName = 'testMethod';
        loli_Mock_Invokation invokationToResponseTo = new loli_Mock_Invokation(methodName, new List<Object> {10, 12});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invokationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse('other', invokationToResponseTo, answer);

        System.assertNotEquals(cannedResponseBase, cannedResponseCompare);
    }

    private static Testmethod void Equal_NotEqal_Invokation() {
        String methodName = 'testMethod';
        loli_Mock_Invokation invokationToResponseTo = new loli_Mock_Invokation(methodName, new List<Object> {10, 12});
        loli_Mock_Invokation otherInvokation = new loli_Mock_Invokation(methodName, new List<Object> {10, 16});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invokationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse(methodName, otherInvokation, answer);

        System.assertNotEquals(cannedResponseBase, cannedResponseCompare);
    }

}