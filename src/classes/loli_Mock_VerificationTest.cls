@isTest
public with sharing class loli_Mock_VerificationTest {

    //----------------------------- addInvokation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void addInvokation() {
        String methodName = 'testMethod';
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation >();
        loli_Mock_Verification testVerification = new loli_Mock_Verification(methodName, invocations);

        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation newInvocation = new loli_Mock_Invocation (methodName, invocationParameters);

        testVerification.addInvokation(newInvocation);

        System.assertEquals(1, testVerification.invocations.size());
        System.assertEquals(newInvocation, testVerification.invocations.get(0));
    }

    //--------- calledCount --------//

    //---- Happy path ----//

    private static TestMethod void calledCount_Single() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName, invocations);

        System.assertEquals(1, verification.calledCount);
    }

    private static TestMethod void calledCount_Multiple() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation, invocation, invocation, invocation};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName, invocations);

        System.assertEquals(4, verification.calledCount);
    }

    private static TestMethod void calledCount_NoCall() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName);

        System.assertEquals(0, verification.calledCount);
    }

    //--------- called --------//

    //---- Happy path ----//

    private static TestMethod void called() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName, invocations);

        verification.called(1);
    }

    //--------- never --------//

    //---- Happy path ----//

    private static TestMethod void never() {
        String methodName = 'testMethod';

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName);

        verification.never();
    }

    //--------- atLeast --------//

    //---- Happy path ----//

    private static TestMethod void atLeast() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation >
            {invocation, invocation, invocation, invocation};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName, invocations);

        verification.atLeast(4);
        verification.atLeast(2);
        verification.atLeast(0);
        verification.atLeast(-20);
    }

    //--------- atMost --------//

    //---- Happy path ----//

    private static TestMethod void atMost() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation >
        {invocation, invocation, invocation, invocation};

        loli_Mock_Verification verification = new loli_Mock_Verification(methodName, invocations);

        verification.atMost(20);
        verification.atMost(4);
    }

    //----------------------------- verifyExpectation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verifyExpectation_called() {
        loli_Mock_Expectation expectation = loli_Mock_Expectation.called(1);
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification testVerification = new loli_Mock_Verification(methodName, invocations);
        testVerification.verifyExpectation(expectation);
    }


    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void Equals() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verificationBase = new loli_Mock_Verification(methodName, invocations);
        loli_Mock_Verification verificationCompare = new loli_Mock_Verification(methodName, invocations);

        System.assertEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Methodname() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verificationBase = new loli_Mock_Verification('otherName', invocations);
        loli_Mock_Verification verificationCompare = new loli_Mock_Verification(methodName, invocations);

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_InvokationValues() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verificationBase = new loli_Mock_Verification(methodName, invocations);
        loli_Mock_Verification verificationCompare = new loli_Mock_Verification(methodName,
                new List<loli_Mock_Invocation > {new loli_Mock_Invocation ('otherName', invocationParameters)});

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verificationBase = new loli_Mock_Verification(methodName);
        loli_Mock_Verification verificationCompare = new loli_Mock_Verification(methodName, invocations);

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null_Compare() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation (methodName, invocationParameters);
        List<loli_Mock_Invocation> invocations = new List<loli_Mock_Invocation > {invocation};

        loli_Mock_Verification verificationBase = new loli_Mock_Verification(methodName, invocations);
        loli_Mock_Verification verificationCompare = new loli_Mock_Verification(methodName);

        System.assertNotEquals(verificationBase, verificationCompare);
    }
}