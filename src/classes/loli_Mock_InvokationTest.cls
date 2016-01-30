@isTest
public with sharing class loli_Mock_InvokationTest {

    //----------------------------- Equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void Equals() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_Mock_Invokation invokationBase = new loli_Mock_Invokation(testMethodName, testParameters);
        loli_Mock_Invokation invokationCompare = new loli_Mock_Invokation(testMethodName, testParameters);

        System.assertEquals(invokationBase, invokationCompare);
    }

    private static TestMethod void Equals_NotEquals_MethodName() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_Mock_Invokation invokationBase = new loli_Mock_Invokation(testMethodName, testParameters);
        loli_Mock_Invokation invokationCompare = new loli_Mock_Invokation('otherName', testParameters);

        System.assertNotEquals(invokationBase, invokationCompare);
    }

    private static TestMethod void Equals_NotEquals_Parameters_Values() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_Mock_Invokation invokationBase = new loli_Mock_Invokation(testMethodName, testParameters);
        loli_Mock_Invokation invokationCompare = new loli_Mock_Invokation(testMethodName, new List<Object> {16, 20});

        System.assertNotEquals(invokationBase, invokationCompare);
    }

    private static TestMethod void Equals_NotEquals_ParametersNull() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_Mock_Invokation invokationBase = new loli_Mock_Invokation(testMethodName, null);
        loli_Mock_Invokation invokationCompare = new loli_Mock_Invokation(testMethodName, testParameters);

        System.assertNotEquals(invokationBase, invokationCompare);
    }

    private static TestMethod void Equals_NotEquals_ParametersNullCompare() {
        String testMethodName = 'testMethod';
        List<Object> testParameters = new List<Integer> {10, 12};

        loli_Mock_Invokation invokationBase = new loli_Mock_Invokation(testMethodName, testParameters);
        loli_Mock_Invokation invokationCompare = new loli_Mock_Invokation(testMethodName, null);

        System.assertNotEquals(invokationBase, invokationCompare);
    }
}