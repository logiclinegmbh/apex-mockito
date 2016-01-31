@IsTest
private class loli_Mock_InvocationMatcherTest {

    private static Boolean isMatcherCalled = false;

    //----------------------------- Classes ----------------------------------//

    private class TestMatcher implements loli_Mock_IMatcher {

        private Boolean isMatching;

        public TestMatcher(Boolean isMatching) {
            this.isMatching = isMatching;
        }

        public Boolean matches(Object compare) {
            isMatcherCalled = true;
            return isMatching;
        }

    }

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

    private static TestMethod void matches_WithMatcher() {
        String methodName = 'testMethod';
        TestMatcher paramMatcher = new TestMatcher(true);
        List<Object> params = new List<Object> {10, 12};
        List<Object> paramsMatcher = new List<Object> {paramMatcher, paramMatcher};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, paramsMatcher);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation(methodName, params);

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        Boolean isMatching = matcher.matches(invocationCompare);

        System.assert(isMatcherCalled);
        System.assert(isMatching);
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

    private static TestMethod void matches_Not_DifferentParameters_Number() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation(methodName, new List<Object> {10, 12, 16});

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_WithMatcher() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        List<Object> paramsMatcher = new List<Object> {new TestMatcher(true), new TestMatcher(false)};
        loli_Mock_Invocation invocationBase = new loli_Mock_Invocation(methodName, paramsMatcher);
        loli_Mock_Invocation invocationCompare = new loli_Mock_Invocation(methodName, params);

        loli_Mock_InvocationMatcher matcher = new loli_Mock_InvocationMatcher(invocationBase);
        Boolean isMatching = matcher.matches(invocationCompare);

        System.assert(isMatcherCalled);
        System.assert(!isMatching);
    }




}