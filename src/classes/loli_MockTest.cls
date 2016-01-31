@isTest
public with sharing class loli_MockTest {

    //----------------------------- Classes/Interfaces ----------------------------------//

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

}