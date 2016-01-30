@isTest
public with sharing class loli_Mock_CannedResponseTest {

    //----------------------------- Classes ----------------------------------//

    private class Answer implements loli_Mock_IAnswer {

        public Object onInvocation(loli_Mock_Invocation invocation) {
            return 'Hello World';
        }

    }


    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static Testmethod void Equal() {
        String methodName = 'testMethod';
        loli_Mock_Invocation invocationToResponseTo = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invocationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse(methodName, invocationToResponseTo, answer);

        System.assertEquals(cannedResponseBase, cannedResponseCompare);
    }

    private static Testmethod void Equal_NotEqal_MethodName() {
        String methodName = 'testMethod';
        loli_Mock_Invocation invocationToResponseTo = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invocationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse('other', invocationToResponseTo, answer);

        System.assertNotEquals(cannedResponseBase, cannedResponseCompare);
    }

    private static Testmethod void Equal_NotEqal_Invokation() {
        String methodName = 'testMethod';
        loli_Mock_Invocation invocationToResponseTo = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 16});
        loli_Mock_IAnswer answer = new Answer();

        loli_Mock_CannedResponse cannedResponseBase = new loli_Mock_CannedResponse(methodName, invocationToResponseTo, answer);
        loli_Mock_CannedResponse cannedResponseCompare = new loli_Mock_CannedResponse(methodName, otherInvocation, answer);

        System.assertNotEquals(cannedResponseBase, cannedResponseCompare);
    }

}