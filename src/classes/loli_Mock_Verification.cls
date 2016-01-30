/**
 * Contains details about a (sub) set of invokations for a specific method
 */
public with sharing class loli_Mock_Verification {

    public String methodName {get; private set;}
    public List<loli_Mock_Invokation> invokations {get; private set;}
    public Integer calledCount {
        get {
            if (invokations != null && !invokations.isEmpty()) {
                return invokations.size();
            } else {
                return 0;
            }
        }
    }

    public loli_Mock_Verification(String methodName) {
        invokations = new List<loli_Mock_Invokation>();
        this.methodName = methodName;
    }

    public loli_Mock_Verification(String methodName, List<loli_Mock_Invokation> invokations) {
        this(methodName);
        this.invokations = invokations;
    }

    public void addInvokation(loli_Mock_Invokation invokationElement) {
        invokations.add(invokationElement);
    }

    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_Mock_Verification)) {
            return false;
        }

        loli_Mock_Verification invokationDetailsCompare = (loli_Mock_Verification) compare;
        return methodName == invokationDetailsCompare.methodName && areInvokationsEqual(invokationDetailsCompare.invokations);
    }

        /**
         * Compares the number of time called with the actual invocations
         */
    public void called(Integer count) {
        System.assertEquals(count, calledCount);
    }

    private Boolean areInvokationsEqual(List<loli_Mock_Invokation> invokationsCompare) {
        if (invokations != null) {
            if (invokationsCompare == null || invokations.size() != invokationsCompare.size()) {
                return false;
            }

            for (Integer invokationIndex = 0; invokationIndex < invokations.size(); invokationIndex++) {
                loli_Mock_Invokation loli_Mock_Invokation = invokations.get(invokationIndex);
                loli_Mock_Invokation invokationCompare = invokationsCompare.get(invokationIndex);
                if (loli_Mock_Invokation != invokationCompare) {
                    return false;
                }
            }
            return true;
        } else if (invokationsCompare != null){
            return false;
        }

        return true;
    }

}