@isTest
public with sharing class loli_mock_VerificationTest {

    //----------------------------- addInvokation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void addInvokation() {
        String methodName = 'testMethod';
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation >();
        loli_mock_Verification testVerification = new loli_mock_Verification(methodName, invocations);

        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation newInvocation = new loli_mock_Invocation (methodName, invocationParameters);

        testVerification.addInvokation(newInvocation);

        System.assertEquals(1, testVerification.invocations.size());
        System.assertEquals(newInvocation, testVerification.invocations.get(0));
    }

    //--------- calledCount --------//

    //---- Happy path ----//

    private static TestMethod void calledCount_Single() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verification = new loli_mock_Verification(methodName, invocations);

        System.assertEquals(1, verification.calledCount);
    }

    private static TestMethod void calledCount_Multiple() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation, invocation, invocation, invocation};

        loli_mock_Verification verification = new loli_mock_Verification(methodName, invocations);

        System.assertEquals(4, verification.calledCount);
    }

    private static TestMethod void calledCount_NoCall() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};

        loli_mock_Verification verification = new loli_mock_Verification(methodName);

        System.assertEquals(0, verification.calledCount);
    }

    //--------- called --------//

    //---- Happy path ----//

    private static TestMethod void called() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verification = new loli_mock_Verification(methodName, invocations);

        verification.called(1);
    }

    //--------- never --------//

    //---- Happy path ----//

    private static TestMethod void never() {
        String methodName = 'testMethod';

        loli_mock_Verification verification = new loli_mock_Verification(methodName);

        verification.never();
    }

    //--------- atLeast --------//

    //---- Happy path ----//

    private static TestMethod void atLeast() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation >
            {invocation, invocation, invocation, invocation};

        loli_mock_Verification verification = new loli_mock_Verification(methodName, invocations);

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
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation >
        {invocation, invocation, invocation, invocation};

        loli_mock_Verification verification = new loli_mock_Verification(methodName, invocations);

        verification.atMost(20);
        verification.atMost(4);
    }

    //----------------------------- verifyExpectation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verifyExpectation_called() {
        loli_mock_Expectation expectation = loli_mock_Expectation.called(1);
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification testVerification = new loli_mock_Verification(methodName, invocations);
        testVerification.verifyExpectation(expectation);
    }

    private static TestMethod void verifyExpectation_never() {
        loli_mock_Expectation expectation = loli_mock_Expectation.never();
        String methodName = 'testMethod';

        loli_mock_Verification testVerification = new loli_mock_Verification(methodName);
        testVerification.verifyExpectation(expectation);
    }

    private static TestMethod void verifyExpectation_atLeast() {
        loli_mock_Expectation expectation = loli_mock_Expectation.atLeast(2);
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation, invocation, invocation};

        loli_mock_Verification testVerification = new loli_mock_Verification(methodName, invocations);
        testVerification.verifyExpectation(expectation);
    }

    private static TestMethod void verifyExpectation_atMost() {
        loli_mock_Expectation expectation = loli_mock_Expectation.atMost(4);
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation, invocation, invocation};

        loli_mock_Verification testVerification = new loli_mock_Verification(methodName, invocations);
        testVerification.verifyExpectation(expectation);
    }


    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void Equals() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verificationBase = new loli_mock_Verification(methodName, invocations);
        loli_mock_Verification verificationCompare = new loli_mock_Verification(methodName, invocations);

        System.assertEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Methodname() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verificationBase = new loli_mock_Verification('otherName', invocations);
        loli_mock_Verification verificationCompare = new loli_mock_Verification(methodName, invocations);

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_InvokationValues() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verificationBase = new loli_mock_Verification(methodName, invocations);
        loli_mock_Verification verificationCompare = new loli_mock_Verification(methodName,
                new List<loli_mock_Invocation > {new loli_mock_Invocation ('otherName', invocationParameters)});

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verificationBase = new loli_mock_Verification(methodName);
        loli_mock_Verification verificationCompare = new loli_mock_Verification(methodName, invocations);

        System.assertNotEquals(verificationBase, verificationCompare);
    }

    private static TestMethod void Equals_NotEquals_Invokations_Null_Compare() {
        String methodName = 'testMethod';
        List<Object> invocationParameters = new List<Object> {10, 12};
        loli_mock_Invocation invocation = new loli_mock_Invocation (methodName, invocationParameters);
        List<loli_mock_Invocation> invocations = new List<loli_mock_Invocation > {invocation};

        loli_mock_Verification verificationBase = new loli_mock_Verification(methodName, invocations);
        loli_mock_Verification verificationCompare = new loli_mock_Verification(methodName);

        System.assertNotEquals(verificationBase, verificationCompare);
    }
}