@isTest
public with sharing class loli_mock_InvocationTest {

    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void Equals() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_mock_Invocation invocationBase = new loli_mock_Invocation(testMethodName, testParameters);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(testMethodName, testParameters);

        System.assertEquals(invocationBase, invocationCompare);
    }

    private static TestMethod void Equals_NotEquals_MethodName() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_mock_Invocation invocationBase = new loli_mock_Invocation(testMethodName, testParameters);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation('otherName', testParameters);

        System.assertNotEquals(invocationBase, invocationCompare);
    }

    private static TestMethod void Equals_NotEquals_Parameters_Values() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_mock_Invocation invocationBase = new loli_mock_Invocation(testMethodName, testParameters);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(testMethodName, new List<Object> {16, 20});

        System.assertNotEquals(invocationBase, invocationCompare);
    }

    private static TestMethod void Equals_NotEquals_ParametersNull() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_mock_Invocation invocationBase = new loli_mock_Invocation(testMethodName, null);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(testMethodName, testParameters);

        System.assertNotEquals(invocationBase, invocationCompare);
    }

    private static TestMethod void Equals_NotEquals_ParametersNullCompare() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_mock_Invocation invocationBase = new loli_mock_Invocation(testMethodName, testParameters);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(testMethodName, null);

        System.assertNotEquals(invocationBase, invocationCompare);
    }
}