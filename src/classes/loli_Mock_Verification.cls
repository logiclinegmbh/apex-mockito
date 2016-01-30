/**
 * Contains details about a (sub) set of invocations for a specific method
 */
public with sharing class loli_Mock_Verification {

    public String methodName {get; private set;}
    public List<loli_Mock_Invocation> invocations {get; private set;}
    public Integer calledCount {
        get {
            if (invocations != null && !invocations.isEmpty()) {
                return invocations.size();
            } else {
                return 0;
            }
        }
    }

    public loli_Mock_Verification(String methodName) {
        invocations = new List<loli_Mock_Invocation>();
        this.methodName = methodName;
    }

    public loli_Mock_Verification(String methodName, List<loli_Mock_Invocation> invocations) {
        this(methodName);
        this.invocations = invocations;
    }

    public void addInvokation(loli_Mock_Invocation invokationElement) {
        invocations.add(invokationElement);
    }

    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_Mock_Verification)) {
            return false;
        }

        loli_Mock_Verification verificationCompare = (loli_Mock_Verification) compare;
        return methodName == verificationCompare.methodName && areInvocationsEqual(verificationCompare.invocations);
    }

        /**
         * Compares the number of time called with the actual invocations
         */
    public void called(Integer count) {
        System.assertEquals(count, calledCount);
    }

    private Boolean areInvocationsEqual(List<loli_Mock_Invocation> invocationsCompare) {
        if (invocations != null) {
            if (invocationsCompare == null || invocations.size() != invocationsCompare.size()) {
                return false;
            }

            for (Integer invokationIndex = 0; invokationIndex < invocations.size(); invokationIndex++) {
                loli_Mock_Invocation invocationBase = invocations.get(invokationIndex);
                loli_Mock_Invocation invocationCompare = invocationsCompare.get(invokationIndex);
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

}