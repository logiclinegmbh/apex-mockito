/**
 * Invocation matcher
 */

public with sharing class loli_Mock_InvocationMatcher implements loli_Mock_IMatcher {

    loli_Mock_Invocation invocationToMatch;

    public loli_Mock_InvocationMatcher(loli_Mock_Invocation invocationToMatch) {
        this.invocationToMatch = invocationToMatch;
    }

    /**
     * Checks if invocation matches with expected invocation
     */
    public Boolean matches(Object compare) {
        if (!(compare instanceof loli_Mock_Invocation)) {
            return false;
        }

        loli_Mock_Invocation invocation = (loli_Mock_Invocation) compare;
        if (!isMethodMatching(invocationToMatch.methodName, invocation.methodName)) {
            return false;
        }

        return areParametersMatching(invocationToMatch, invocation);
    }

    /**
     * Checks if parameters are matching
     */
    private Boolean areParametersMatching(loli_Mock_Invocation invocationExpected, loli_Mock_Invocation invocation) {
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
        if (parameterExpected instanceof loli_Mock_IMatcher) {
            return ((loli_Mock_IMatcher) parameterExpected).matches(parameterReceived);
        } else {
            return parameterExpected == parameterReceived;
        }
    }

}