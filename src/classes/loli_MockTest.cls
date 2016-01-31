@isTest
public with sharing class loli_MockTest {

    //----------------------------- Classes/Interfaces ----------------------------------//

    private class TestException extends Exception{}

    public class Mock extends loli_Mock_MockBase {

        public String mockMethod(Object param1, Object param2) {
            return (String) super.doInvocation('mockMethod', new List<Object> {param1, param2});
        }

        public String mockMethodEmptyParameters() {
            return (String) super.doInvocation('mockMethodEmptyParameters');
        }

    }

    private class Answer implements loli_Mock_IAnswer {

        private Object answer;

        public Answer() {}

        public Answer(Object answer) {
            this.answer = answer;
        }

        public Object onInvocation(loli_Mock_Invocation invocation) {
            return answer;
        }

    }

    //----------------------------- AddCannedResponse ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void addCannedResponse_Single() {
        String methodName = 'mockMethod';
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
    }


    public static TestMethod void addCannedResponse_Multiple() {
        String methodName = 'mockMethod';
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 16});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(2, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
        System.assert(cannedResponseList.get(1).invocationMatcher.matches(otherInvocation));
    }

    public static TestMethod void addCannedResponse_Multiple_SameParameters() {
        String methodName = 'mockMethod';
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assert(cannedResponseList.get(0).invocationMatcher.matches(invocation));
    }

    public static TestMethod void addCannedResponse_Multiple_DifferentMethod() {
        String methodName = 'mockMethod';
        String otherMethodName = 'otherMethod';
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(otherMethodName, new List<Object> {16, 20});

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocation, cannedResponseAnswer);
        testMock.addCannedResponse(otherInvocation, cannedResponseAnswer);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

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
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);

        List<loli_Mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
    }

    public static TestMethod void when_Single_MethodWithNoParameters() {
        String methodName = 'mockMethodEmptyParameters';
        String answer = 'hello World';
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethodEmptyParameters()).thenReturn(answer);

        List<loli_Mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
    }

    public static TestMethod void when_Multiple() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        List<Object> otherParams = new List<Object> {16, 18};
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, otherParams);

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);
        testMock.when().invocation(testMock.mockMethod(otherParams.get(0), otherParams.get(1))).thenReturn(answer);

        List<loli_Mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(2, cannedResponses.size());
        System.assert(cannedResponses.get(0).invocationMatcher.matches(invocationExpected));
        System.assert(cannedResponses.get(1).invocationMatcher.matches(otherInvocation));
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


    //----------------------------- verify/that ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void verify_Single() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        List<loli_Mock_Invocation> invocationExpectedList = new List<loli_Mock_Invocation> {invocationExpected};
        loli_Mock_Verification verficationExpected = new loli_Mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.addCannedResponse(invocationExpected, cannedResponseAnswer);
        testMock.mockMethod(params.get(0), params.get(1));

        loli_Mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_EmptyParams() {
        String methodName = 'mockMethodEmptyParameters';
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName);
        List<loli_Mock_Invocation> invocationExpectedList = new List<loli_Mock_Invocation> {invocationExpected};
        loli_Mock_Verification verficationExpected = new loli_Mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethodEmptyParameters();

        loli_Mock_Verification verfication = testMock.verify().that(testMock.mockMethodEmptyParameters());

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_Multiple() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        List<loli_Mock_Invocation> invocationExpectedList = new List<loli_Mock_Invocation> {invocationExpected, invocationExpected};
        loli_Mock_Verification verficationExpected = new loli_Mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        loli_Mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    private static TestMethod void verify_Multiple_Different() {
        String methodName = 'mockMethod';
        List<Object> params = new List<Object> {12, 16};
        List<Object> otherParams = new List<Object> {18, 20};
        loli_Mock_IAnswer cannedResponseAnswer = new Answer();
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation otehrInvocationParams = new loli_Mock_Invocation(methodName, otherParams);
        loli_Mock_Invocation otherInvocationMethodName = new loli_Mock_Invocation('mockMethodEmptyParameters', params);
        List<loli_Mock_Invocation> invocationExpectedList = new List<loli_Mock_Invocation> {invocationExpected};
        loli_Mock_Verification verficationExpected = new loli_Mock_Verification(methodName, invocationExpectedList);

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(otherParams.get(0), otherParams.get(1));
        testMock.mockMethodEmptyParameters();

        loli_Mock_Verification verfication = testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1)));

        System.assert(verfication != null);
        System.assertEquals(verficationExpected, verfication);
    }

    //----------------------------- called ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void called() {
        List<Object> params = new List<Object> {12, 16};

        Mock testMock = new Mock();
        testMock.mockMethod(params.get(0), params.get(1));
        testMock.mockMethod(params.get(0), params.get(1));

        System.assertEquals(2, testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).calledCount);
        testMock.verify().that(testMock.mockMethod(params.get(0), params.get(1))).called(2);
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

    }

}