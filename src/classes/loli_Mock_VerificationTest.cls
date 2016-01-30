@isTest
public with sharing class loli_Mock_VerificationTest {

    //----------------------------- addInvokation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void addInvokation() {
        String methodName = 'testMethod';
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation >();
        loli_Mock_Verification testDetails = new loli_Mock_Verification(methodName, invokations);

        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  newInvokation = new loli_Mock_Invokation (methodName, invokationParameters);

        testDetails.addInvokation(newInvokation);

        System.assertEquals(1, testDetails.invokations.size());
        System.assertEquals(newInvokation, testDetails.invokations.get(0));
    }

    //--------- calledCount --------//

    //---- Happy path ----//

    private static TestMethod void calledCount_Single() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetails = new loli_Mock_Verification(methodName, invokations);

        System.assertEquals(1, invokationDetails.calledCount);
    }

    private static TestMethod void calledCount_Multiple() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation, invokation, invokation, invokation};

        loli_Mock_Verification invokationDetails = new loli_Mock_Verification(methodName, invokations);

        System.assertEquals(4, invokationDetails.calledCount);
    }

    private static TestMethod void calledCount_NoCall() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};

        loli_Mock_Verification invokationDetails = new loli_Mock_Verification(methodName, null);

        System.assertEquals(0, invokationDetails.calledCount);
    }


    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void Equals() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetailsBase = new loli_Mock_Verification(methodName, invokations);
        loli_Mock_Verification invokationDetailsCompare = new loli_Mock_Verification(methodName, invokations);

        System.assertEquals(invokationDetailsBase, invokationDetailsCompare);
    }

    private static TestMethod void Equals_NotEquals_Methodname() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetailsBase = new loli_Mock_Verification('otherName', invokations);
        loli_Mock_Verification invokationDetailsCompare = new loli_Mock_Verification(methodName, invokations);

        System.assertNotEquals(invokationDetailsBase, invokationDetailsCompare);
    }

    private static TestMethod void Equals_NotEquals_InvokationValues() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetailsBase = new loli_Mock_Verification(methodName, invokations);
        loli_Mock_Verification invokationDetailsCompare = new loli_Mock_Verification(methodName,
                new List<loli_Mock_Invokation > {new loli_Mock_Invokation ('otherName', invokationParameters)});

        System.assertNotEquals(invokationDetailsBase, invokationDetailsCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetailsBase = new loli_Mock_Verification(methodName, null);
        loli_Mock_Verification invokationDetailsCompare = new loli_Mock_Verification(methodName, invokations);

        System.assertNotEquals(invokationDetailsBase, invokationDetailsCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null_Compare() {
        String methodName = 'testMethod';
        List<Object> invokationParameters = new List<Object> {10, 12};
        loli_Mock_Invokation  invokation = new loli_Mock_Invokation (methodName, invokationParameters);
        List<loli_Mock_Invokation > invokations = new List<loli_Mock_Invokation > {invokation};

        loli_Mock_Verification invokationDetailsBase = new loli_Mock_Verification(methodName, invokations);
        loli_Mock_Verification invokationDetailsCompare = new loli_Mock_Verification(methodName, null);

        System.assertNotEquals(invokationDetailsBase, invokationDetailsCompare);
    }
}