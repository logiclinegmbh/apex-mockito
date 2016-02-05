@isTest
public with sharing class loli_mock_MockTest {

    //----------------------------- Classes/Interfaces ----------------------------------//

    private class TestException extends Exception{}

    private class Mock extends loli_mock_MockBase {

        public String mockMethod(Object param1, Object param2) {
            return (String) super.doInvocation('mockMethod', new List<Object> {param1, param2});
        }

        public String mockMethodEmptyParameters() {
            return (String) super.doInvocation('mockMethodEmptyParameters');
        }

        public String mockAllTypes(Integer param1, String param2, Boolean param3,
                Decimal param4, List<String> param5, Date param6, DateTime param7, Double param8, Id param9,
                Long param10, String param11, Account param12) {
            return (String) super.doInvocation('mockTyped', new List<Object> {param1, param2, param3, param4, param5,
                    param6, param7, param8, param9, param10, param11, param12});
        }

        public void mockVoidMethod(Integer param1) {
            super.doInvocation('mockVoidMethod', new List<Object> {param1});
        }

    }

    private class Answer implements loli_mock_IAnswer {

        private Object answer;

        public Answer() {}

        public Answer(Object answer) {
            this.answer = answer;
        }

        public Object onInvocation(loli_mock_Invocation invocation) {
            return answer;
        }

    }

    private class Matcher implements loli_mock_IMatcher {

        private Boolean isMatching = false;

        public Matcher(Boolean isMatching) {
            this.isMatching = isMatching;
        }

        public Boolean matches(Object compare) {
            return isMatching;
        }

    }

    //----------------------------- AddCannedResponse ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void addCannedResponse_Single() {
        String methodName = 'mockMethod';
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocation = new loli_mock_Invocation(methodName, new List<Object> {10, 12});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);

        List<loli_mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
    }


    public static TestMethod void addCannedResponse_Multiple() {
        String methodName = 'mockMethod';
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocation = new loli_mock_Invocation(methodName, new List<Object> {10, 12});
        loli_mock_Invocation otherInvocation = new loli_mock_Invocation(methodName, new List<Object> {10, 16});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(2, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
        System.assert(cannedResponseList.get(1).invocationMatcher.matches(otherInvocation));
    }

    public static TestMethod void addCannedResponse_Multiple_SameParameters() {
        String methodName = 'mockMethod';
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocation = new loli_mock_Invocation(methodName, new List<Object> {10, 12});
        loli_mock_Invocation otherInvocation = new loli_mock_Invocation(methodName, new List<Object> {10, 12});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
    }

    public static TestMethod void addCannedResponse_Multiple_DifferentMethod() {
        String methodName = 'mockMethod';
        String otherMethodName = 'otherMethod';
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocation = new loli_mock_Invocation(methodName, new List<Object> {10, 12});
        loli_mock_Invocation otherInvocation = new loli_mock_Invocation(otherMethodName, new List<Object> {16, 20});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
    }


    //----------------------------- when/invocation ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void when_Single() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
    }

    public static TestMethod void when_Single_MethodWithNoParameters() {
        String methodName = 'mockMethodEmptyParameters';
        String answer = 'hello World';
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethodEmptyParameters()).thenReturn(answer);

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
    }

    public static TestMethod void when_Multiple() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        List<Object> otherParams = new List<Object> {16, 18};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation otherInvocation = new loli_mock_Invocation(methodName, otherParams);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);
        testMock.when().invocation(testMock.mockMethod(otherParams.get(0), otherParams.get(1))).thenReturn(answer);

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(2, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
        System.assert(cannedResponses.get(1).invocationMatcher.matches(otherInvocation));
    }

    //----------------------------- when/answerFor ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void when_answerFor_Single() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);

        Mock testMock = new Mock();
        ((Mock) testMock.when().answerFor(answer)).mockMethod(params.get(0), params.get(1));

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);
        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
        System.assertEquals(answer, answerReturned);
    }

    public static TestMethod void when_answerFor_Matchers() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);

        Mock testMock = new Mock();
        ((Mock) testMock.when().answerFor(answer)).mockMethod(testMock.anyInteger(), testMock.anyValue(params.get(1)));

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);
        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
        System.assertEquals(answer, answerReturned);
    }

    public static TestMethod void when_answerFor_Single_thenAnswer() {
        String methodName = 'mockMethod';
        String answerString = 'hello World';
        Answer answer = new Answer(answerString);
        List<Object> params = new List<Object> {10, 12};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);

        Mock testMock = new Mock();
        ((Mock) testMock.when().answerFor(answer)).mockMethod(params.get(0), params.get(1));
        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        List<loli_mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
        System.assertEquals(answerString, answerReturned);
    }




    //----------------------------- doInvocation ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void doInvocation_When_Single() {
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);

        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(answerReturned != null);
        System.assertEquals(answer, answerReturned);
    }

    public static TestMethod void doInvocation_When_NoParameters() {
        String answer = 'hello World';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethodEmptyParameters()).thenReturn(answer);

        String answerReturned = testMock.mockMethodEmptyParameters();

        System.assert(answerReturned != null);
        System.assertEquals(answer, answerReturned);
    }

    public static TestMethod void doInvocation_When_Multiple() {
        String answer = 'hello World';
        Integer otherAnswer = 0;
        List<Object> params = new List<Object> {10, 12};
        List<Object> otherParams = new List<Object> {16, 18};

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);
        testMock.when().invocation(testMock.mockMethod(otherParams.get(0), otherParams.get(1))).thenReturn(otherAnswer);

        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(answerReturned != null);
        System.assertEquals(answer, answerReturned);

    }

    public static TestMethod void doInvocation_No_Response() {
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(10, 20)).thenReturn(answer);

        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(answerReturned == null);
    }

    public static TestMethod void doInvocation_thenAnswer() {
        String answer = 'hello World';
        Answer answerImplementation = new Answer(answer);
        List<Object> params = new List<Object> {10, 12};

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenAnswer(answerImplementation);

        String answerReturned = testMock.mockMethod(params.get(0), params.get(1));

        System.assert(answerReturned != null);
        System.assertEquals(answer, answerReturned);
    }


    //----------------------------- verify/that ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verify_Single() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        List<loli_mock_Invocation> invocationExpectedList = new List<loli_mock_Invocation> {invocationExpected};
        loli_mock_Verification verficationExpected = new loli_mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocationExpected, cannedResponseAnswer);
        testMock.mockMethod(params.get(0), params.get(1));

        loli_mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_EmptyParams() {
        String methodName = 'mockMethodEmptyParameters';
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName);
        List<loli_mock_Invocation> invocationExpectedList = new List<loli_mock_Invocation> {invocationExpected};
        loli_mock_Verification verficationExpected = new loli_mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethodEmptyParameters();

        loli_mock_Verification verfication = testMock.verify().that(testMock.mockMethodEmptyParameters());

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_Multiple() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        List<loli_mock_Invocation> invocationExpectedList = new List<loli_mock_Invocation> {invocationExpected, invocationExpected};
        loli_mock_Verification verficationExpected = new loli_mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        loli_mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_Multiple_Different() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        List<Object> otherParams = new List<Object> {18, 20};
        loli_mock_IAnswer cannedResponseAnswer = new Answer();
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        loli_mock_Invocation otehrInvocationParams = new loli_mock_Invocation(methodName, otherParams);
        loli_mock_Invocation otherInvocationMethodName = new loli_mock_Invocation('mockMethodEmptyParameters', params);
        List<loli_mock_Invocation> invocationExpectedList = new List<loli_mock_Invocation> {invocationExpected};
        loli_mock_Verification verficationExpected = new loli_mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(otherParams.get(0), otherParams.get(1));
        testMock.mockMethodEmptyParameters();

        loli_mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }


    //----------------------------- verify/that with expectation ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void that_Expectation() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));

        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.called(1))).mockMethod(params.get(0), params.get(1));
    }

    private static TestMethod void that_Expectation_VoidMethod() {
        String methodName = 'mockMethod';
        Integer param = 4;

        Mock testMock = new Mock();
        testMock.mockVoidMethod(param);
        testMock.mockVoidMethod(param);

        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.called(2))).mockVoidMethod(param);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.called(2))).mockVoidMethod(testMock.anyInteger());
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.called(2))).mockVoidMethod((Integer) testMock.anyValue(4));
    }

    //----------------------------- verifyCalled ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void called() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        System.assertEquals(2, testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).calledCount);
        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).called(2);
    }

    //----------------------------- verifyNever ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verifyNever() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).called(1);
        testMock.verify().that(testMock.mockMethod(-1, -1)).never();
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.never())).mockMethod(-1, -1);
    }

    private static TestMethod void verifyNever_NoInvocation() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).never();
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.never())).mockMethod(-1, -1);
    }

    //----------------------------- verifyAtLeast ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verify_atLeast() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).atLeast(4);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.atLeast(4))).mockMethod(params.get(0), params.get(1));
    }

    private static TestMethod void verify_atLeast_NoInvocation() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).atLeast(0);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.atLeast(0))).mockMethod(params.get(0), params.get(1));
    }

    //----------------------------- verifyAtMost ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verify_atMost() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).atMost(4);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.atMost(4))).mockMethod(params.get(0), params.get(1));
    }

    private static TestMethod void verify_atMost_NoInvocation() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).atMost(0);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.atMost(0))).mockMethod(params.get(0), params.get(1));
    }

    //----------------------------- Any ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void anyTest_AllValues() {
        String answerExpected = 'works';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockAllTypes(testMock.anyInteger(), testMock.anyString(),
                testMock.anyBoolean(), testMock.anyDecimal(), (List<String>) testMock.anyIterable(), testMock.anyDate(), testMock.anyDateTime(),
                testMock.anyDouble(), testMock.anyId(), testMock.anyLong(), (String) testMock.anyObject(), (Account) testMock.anySObject())).
                thenReturn(answerExpected);

        String answer = testMock.mockAllTypes(10, 'test', true, 10.0, new List<String> {'hello', 'world'},
                Date.today(), DateTime.now(), 10, '01p58000001Or8d', 10l, 'objectString', new Account());
        System.assertEquals(answerExpected, answer);
        testMock.verify().that(testMock.mockAllTypes(testMock.anyInteger(), testMock.anyString(),
                testMock.anyBoolean(), testMock.anyDecimal(), (List<String>) testMock.anyIterable(), testMock.anyDate(), testMock.anyDateTime(),
                testMock.anyDouble(), testMock.anyId(), testMock.anyLong(), (String) testMock.anyObject(), (Account) testMock.anySObject())).called(1);
        ((Mock) testMock.verify().expectationFor(loli_mock_Expectation.called(1))).mockAllTypes(testMock.anyInteger(), testMock.anyString(),
                testMock.anyBoolean(), testMock.anyDecimal(), (List<String>) testMock.anyIterable(), testMock.anyDate(), testMock.anyDateTime(),
                testMock.anyDouble(), testMock.anyId(), testMock.anyLong(), (String) testMock.anyObject(), (Account) testMock.anySObject());

    }

    private static TestMethod void anyTest_ValueHolder() {
        String answerExpected = 'works';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(testMock.anyInteger(), testMock.anyValue(16))).thenReturn(answerExpected);

        String answer = testMock.mockMethod(25, 16);
        System.assertEquals(answerExpected, answer);
        testMock.verify().that(testMock.mockMethod(testMock.anyValue(25), testMock.anyInteger())).called(1);
        testMock.verify().that(testMock.mockMethod(testMock.anyInteger(), testMock.anyString())).never();
    }

    private static TestMethod void anyTest_NotMatching() {
        String answerExpected = 'works';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(testMock.anyInteger(), testMock.anyInteger())).thenReturn(answerExpected);

        String answer = testMock.mockMethod(16, 25);
        System.assertEquals(answerExpected, answer);
        testMock.verify().that(testMock.mockMethod(testMock.anyInteger(), testMock.anyString())).never();
    }

    //----------------------------- CustomMatcher ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void matcher() {
        String answerExpected = 'works';
        loli_mock_IMatcher testMatcher = new Matcher(true);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(testMock.anyInteger(), testMock.matcher(testMatcher))).thenReturn(answerExpected);

        String answer = testMock.mockMethod(10, 20);

        System.assert(answer != null);
        System.assertEquals(answerExpected, answer);
        testMock.verify().that(testMock.mockMethod(testMock.matcher(testMatcher), testMock.matcher(testMatcher))).called(1);
    }

    private static TestMethod void matcher_NotMatching() {
        String answerExpected = 'works';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(testMock.matcher(new Matcher(true)), testMock.matcher(new Matcher(false))))
                .thenReturn(answerExpected);

        String answer = testMock.mockMethod(10, 20);

        System.assert(answer == null);
        System.assertEquals(0,
                testMock.verify().that(testMock.mockMethod(testMock.matcher(new Matcher(true)), testMock.matcher(new Matcher(false)))).calledCount);
    }

    //----------------------------- roundTrip ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void rountTrip() {
        List<Object> params = new List<Object> {12, 16};
        List<Object> otherParams = new List<Object> {12, 26};
        List<Object> exceptionParameters = new List<Object> {-1, -1};
        String cannedReponse = 'works';
        String otherCannedResponse = 'works also';

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(cannedReponse);
        testMock.when().invocation(testMock.mockMethodEmptyParameters()).thenReturn(otherCannedResponse);
        testMock.when().invocation(testMock.mockMethod(exceptionParameters.get(0), exceptionParameters.get(1))).thenReturn(new TestException());

        String response = testMock.mockMethod(params.get(0), params.get(1));
        System.assertEquals(cannedReponse, response);
        response = testMock.mockMethodEmptyParameters();
        System.assertEquals(otherCannedResponse, response);
        response = testMock.mockMethod(otherParams.get(0), otherParams.get(1));
        System.assert(response == null);
        testMock.mockVoidMethod((Integer) params.get(0));

        try {
            testMock.mockMethod(exceptionParameters.get(0), exceptionParameters.get(1));
            System.assert(false);
        } catch (TestException e) {
            System.assert(true);
        } catch (Exception e) {
            System.assert(false);
        }

        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).called(1);
        testMock.verify().that(testMock.mockMethod(otherParams.get(0), otherParams.get(1))).called(1);
        testMock.verify().that(testMock.mockMethod(exceptionParameters.get(0), exceptionParameters.get(1))).called(1);
        testMock.verify().that(testMock.mockMethodEmptyParameters()).called(1);
        System.assertEquals(0, testMock.verify().that(testMock.mockMethod(100, 200)).calledCount);
        testMock.verify().that(testMock.mockMethod(100, 200)).never();

    }

}