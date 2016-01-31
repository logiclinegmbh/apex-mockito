/**
 * Invocation matcher
 */

public with sharing class loli_Mock_InvocationMatcher {

    loli_Mock_Invocation invocationToMatch;

    public loli_Mock_InvocationMatcher(loli_Mock_Invocation invocationToMatch) {
        this.invocationToMatch = invocationToMatch;
    }

    /**
     * Checks if invocation matches with expected invocation
     */
    public Boolean matches(loli_Mock_Invocation invocation) {
        if (!isMethodMatching(invocationToMatch.methodName, invocation.methodName)) {
            return false;
        }

        for (Integer parameterIndex = 0; parameterIndex < invocationToMatch.parameters.size(); parameterIndex++) {
            Object parameterExpected = invocationToMatch.parameters.get(parameterIndex);
            Object parameterReceived = invocation.parameters.get(parameterIndex);
            if (!isParameterMatching(parameterExpected, parameterReceived)) {
                return false;
            }
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
        return parameterExpected == parameterReceived;
    }

}