@IsTest
private class loli_Mock_InvocationMatcherTest {


    //----------------------------- matches ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void matches() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation(methodName, params);

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        System.assert(matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_DifferentMethodName() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation('otherMethod', params);

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_DifferentParameters() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation(methodName, new List<Object> {12, 16});

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }


}