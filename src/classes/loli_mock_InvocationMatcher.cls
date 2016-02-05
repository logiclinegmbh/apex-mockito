/**
 * Invocation matcher
 */

public with sharing class loli_mock_InvocationMatcher implements loli_mock_IMatcher {

    loli_mock_Invocation invocationToMatch;

    public loli_mock_InvocationMatcher(loli_mock_Invocation invocationToMatch) {
        this.invocationToMatch = invocationToMatch;
    }

    /**
     * Checks if invocation matches with expected invocation
     */
    public Boolean matches(Object compare) {
        if (!(compare instanceof loli_mock_Invocation)) {
            return false;
        }

        loli_mock_Invocation invocation = (loli_mock_Invocation) compare;
        if (!isMethodMatching(invocationToMatch.methodName, invocation.methodName)) {
            return false;
        }

        return areParametersMatching(invocationToMatch, invocation);
    }

    /**
     * Checks if parameters are matching
     */
    private Boolean areParametersMatching(loli_mock_Invocation invocationExpected, loli_mock_Invocation invocation) {
        if (invocationExpected.parameters != null) {
            if (invocation == null || invocationExpected.parameters.size() != invocation.parameters.size()) {
                return false;
            }

            for (Integer parameterIndex = 0; parameterIndex < invocationExpected.parameters.size(); parameterIndex++) {
                Object parameterExpected = invocationExpected.parameters.get(parameterIndex);
                Object parameterReceived = invocation.parameters.get(parameterIndex);
                if (!isParameterMatching(parameterExpected, parameterReceived)) {
                    return false;
                }
            }
            return true;
        } else if (invocation.parameters  != null) {
            return false;
        }
        return true;
    }

    /**
     * Checks if method of both invocation is matching
     */
    private Boolean isMethodMatching(String methodNameExpected, String methodNameReceived) {
        return methodNameExpected == methodNameReceived;
    }

    /**
     * Checks if parameter of invocation is matching
     */
    private static Boolean isParameterMatching(Object parameterExpected, Object parameterReceived) {
        // In case it is a matcher, call matcher method, otherwise test for equality
        if (parameterExpected instanceof loli_mock_IMatcher) {
            return ((loli_mock_IMatcher) parameterExpected).matches(parameterReceived);
        } else {
            return parameterExpected == parameterReceived;
        }
    }

}