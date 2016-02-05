/**
 * Contains details about a (sub) set of invocations for a specific method
 */
public with sharing class loli_mock_Verification {

    public String methodName {get; private set;}
    public List<loli_mock_Invocation> invocations {get; private set;}
    public Integer calledCount;

    public loli_mock_Verification(String methodName) {
        invocations = new List<loli_mock_Invocation>();
        this.methodName = methodName;
        this.calledCount = 0;
    }

    public loli_mock_Verification(String methodName, List<loli_mock_Invocation> invocations) {
        this(methodName);
        this.invocations = invocations;
        this.calledCount = invocations.size();
    }

    public void addInvokation(loli_mock_Invocation invokationElement) {
        invocations.add(invokationElement);
    }

    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_mock_Verification)) {
            return false;
        }

        loli_mock_Verification verificationCompare = (loli_mock_Verification) compare;
        return methodName == verificationCompare.methodName && areInvocationsEqual(verificationCompare.invocations);
    }

    /**
     * Verifies expectation for the verification object (the invocations that are)
     */
    public void verifyExpectation(loli_mock_Expectation expectation) {
        if (loli_mock_Expectation.ExpectationType.called == expectation.expectedType) {
            called(expectation.expectedCount);
        } else if (loli_mock_Expectation.ExpectationType.never == expectation.expectedType) {
            never();
        } else if (loli_mock_Expectation.ExpectationType.atLeast == expectation.expectedType) {
            atLeast(expectation.expectedCount);
        } else if (loli_mock_Expectation.ExpectationType.atMost == expectation.expectedType) {
            atMost(expectation.expectedCount);
        }
    }

    /**
     * Asserts the number of time called with the actual invocations
     */
    public void called(Integer count) {
        System.assertEquals(count, calledCount, createInvocationString());
    }

    /**
     * Asserts no invocation happened
     */
    public void never() {
        System.assertEquals(0, calledCount, createInvocationString());
    }

    /**
     * Asserts at least the specified count of invocations happened
     */
    public void atLeast(Integer count) {
        System.assert(calledCount >= count, createInvocationString());
    }

    /**
     * Asserts at most the specified count of invocations happened
     */
    public void atMost(Integer count) {
        System.assert(calledCount <= count, createInvocationString());
    }

    private Boolean areInvocationsEqual(List<loli_mock_Invocation> invocationsCompare) {
        if (invocations != null) {
            if (invocationsCompare == null || invocations.size() != invocationsCompare.size()) {
                return false;
            }

            for (Integer invokationIndex = 0; invokationIndex < invocations.size(); invokationIndex++) {
                loli_mock_Invocation invocationBase = invocations.get(invokationIndex);
                loli_mock_Invocation invocationCompare = invocationsCompare.get(invokationIndex);
                if (invocationBase != invocationCompare) {
                    return false;
                }
            }
            return true;
        } else if (invocationsCompare != null){
            return false;
        }

        return true;
    }

    /**
     * Creates invocation string for assert message
     */
    private String createInvocationString() {
        return 'Invocations: ' + calledCount + ' --> ' + invocations;
    }

}