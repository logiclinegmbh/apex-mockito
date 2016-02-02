/**
 * Defines expecations related to method calls
 */
public with sharing class loli_Mock_Expectation {


    public enum ExpectationType {
        called
    }

    public ExpectationType expectedType {get; private set;}
    public Integer expectedCount {get; private set;}


    public loli_Mock_Expectation(ExpectationType expectedType, Integer expectedCount) {
        this.expectedType = expectedType;
        this.expectedCount = expectedCount;
    }

    /**
     * Utility method for creating a called expectation
     */
    public static loli_Mock_Expectation called(Integer count) {
        return new loli_Mock_Expectation(ExpectationType.called, count);
    }


    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_Mock_Expectation)) {
            return false;
        }

        loli_Mock_Expectation expectationCompare = (loli_Mock_Expectation) compare;
        return expectedType == expectationCompare.expectedType &&
                expectedCount == expectationCompare.expectedCount;
    }



}