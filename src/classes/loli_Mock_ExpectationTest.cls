@isTest
public with sharing class loli_Mock_ExpectationTest {




    //----------------------------- called ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void called() {
        Integer calledCount = 4;
        loli_Mock_Expectation expectationExpected = new loli_Mock_Expectation(loli_Mock_Expectation.ExpectationType.called,
                calledCount);

        loli_Mock_Expectation expectationCompare = loli_Mock_Expectation.called(calledCount);

        System.assertEquals(expectationExpected, expectationCompare);

    }

    //----------------------------- never ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void never() {
        Integer calledCount = 0;
        loli_Mock_Expectation expectationExpected = new loli_Mock_Expectation(loli_Mock_Expectation.ExpectationType.never,
                calledCount);

        loli_Mock_Expectation expectationCompare = loli_Mock_Expectation.never();

        System.assertEquals(expectationExpected, expectationCompare);

    }

    //----------------------------- atLeast ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void atLeast() {
        Integer calledCount = 4;
        loli_Mock_Expectation expectationExpected = new loli_Mock_Expectation(loli_Mock_Expectation.ExpectationType.atLeast,
                calledCount);

        loli_Mock_Expectation expectationCompare = loli_Mock_Expectation.atLeast(calledCount);

        System.assertEquals(expectationExpected, expectationCompare);

    }

    //----------------------------- atMost ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void atMost() {
        Integer calledCount = 4;
        loli_Mock_Expectation expectationExpected = new loli_Mock_Expectation(loli_Mock_Expectation.ExpectationType.atMost,
                calledCount);

        loli_Mock_Expectation expectationCompare = loli_Mock_Expectation.atMost(calledCount);

        System.assertEquals(expectationExpected, expectationCompare);

    }


    //----------------------------- equals ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void equals() {
        Integer count = 4;
        loli_Mock_Expectation.ExpectationType expectType = loli_Mock_Expectation.ExpectationType.called;
        loli_Mock_Expectation expectationBase = new loli_Mock_Expectation(expectType, count);
        loli_Mock_Expectation expectationCompare = new loli_Mock_Expectation(expectType, count);

        System.assertEquals(expectationBase, expectationCompare);
    }

    private static TestMethod void equals_not_expectationType() {
        Integer count = 4;
        loli_Mock_Expectation.ExpectationType expectType = loli_Mock_Expectation.ExpectationType.called;
        loli_Mock_Expectation expectationBase = new loli_Mock_Expectation(expectType, count);
        loli_Mock_Expectation expectationCompare = new loli_Mock_Expectation(null, count);

        System.assertNotEquals(expectationBase, expectationCompare);
    }

    private static TestMethod void equals_not_count() {
        Integer count = 4;
        loli_Mock_Expectation.ExpectationType expectType = loli_Mock_Expectation.ExpectationType.called;
        loli_Mock_Expectation expectationBase = new loli_Mock_Expectation(expectType, count);
        loli_Mock_Expectation expectationCompare = new loli_Mock_Expectation(null, 26);

        System.assertNotEquals(expectationBase, expectationCompare);
    }



}