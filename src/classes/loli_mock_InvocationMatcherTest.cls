@IsTest
private class loli_mock_InvocationMatcherTest {

    private static Boolean isMatcherCalled = false;

    //----------------------------- Classes ----------------------------------//

    private class TestMatcher implements loli_mock_IMatcher {

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
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(methodName, params);

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        System.assert(matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_WithMatcher() {
        String methodName = 'testMethod';
        TestMatcher paramMatcher = new TestMatcher(true);
        List<Object> params = new List<Object> {10, 12};
        List<Object> paramsMatcher = new List<Object> {paramMatcher, paramMatcher};
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, paramsMatcher);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(methodName, params);

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        Boolean isMatching = matcher.matches(invocationCompare);

        System.assert(isMatcherCalled);
        System.assert(isMatching);
    }

    private static TestMethod void matches_Not_DifferentMethodName() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation('otherMethod', params);

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_DifferentParameters() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(methodName, new List<Object> {12, 16});

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_DifferentParameters_Number() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(methodName, new List<Object> {10, 12, 16});

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        System.assert(!matcher.matches(invocationCompare));
    }

    private static TestMethod void matches_Not_WithMatcher() {
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {10, 12};
        List<Object> paramsMatcher = new List<Object> {new TestMatcher(true), new TestMatcher(false)};
        loli_mock_Invocation invocationBase = new loli_mock_Invocation(methodName, paramsMatcher);
        loli_mock_Invocation invocationCompare = new loli_mock_Invocation(methodName, params);

        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocationBase);
        Boolean isMatching = matcher.matches(invocationCompare);

        System.assert(isMatcherCalled);
        System.assert(!isMatching);
    }




}