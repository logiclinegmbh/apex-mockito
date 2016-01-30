@isTest
public with sharing class loli_MockTest {

    //----------------------------- Classes/Interfaces ----------------------------------//

    public class Mock extends loli_Mock_MockBase {

        public String mockMethod(Object param1, Object param2) {
            return (String) super.doInvocation('mockMethod', new List<Object> {param1, param2});
        }

        public String mockMethodEmptyParameters() {
            return null;
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
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName, invocation, new Answer());

        Mock testMock = new Mock();
        testMock.addCannedResponse(cannedResponseExpected);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assertEquals(cannedResponseExpected, cannedResponseList.get(0));
    }


    public static TestMethod void addCannedResponse_Multiple() {
        String methodName = 'mockMethod';
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 16});
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName, invocation, new Answer());
        loli_Mock_CannedResponse otherCannedResponse = new loli_Mock_CannedResponse(invocation.methodName, otherInvocation, new Answer());

        Mock testMock = new Mock();
        testMock.addCannedResponse(cannedResponseExpected);
        testMock.addCannedResponse(otherCannedResponse);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(2, cannedResponseList.size());
        System.assertEquals(cannedResponseExpected, cannedResponseList.get(0));
        System.assertEquals(otherCannedResponse, cannedResponseList.get(1));
    }

    public static TestMethod void addCannedResponse_Multiple_SameParameters() {
        String methodName = 'mockMethod';
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName, invocation, new Answer());
        loli_Mock_CannedResponse otherCannedResponse = new loli_Mock_CannedResponse(invocation.methodName, otherInvocation, new Answer());

        Mock testMock = new Mock();
        testMock.addCannedResponse(otherCannedResponse);
        testMock.addCannedResponse(cannedResponseExpected);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assertEquals(cannedResponseExpected, cannedResponseList.get(0));
    }

    public static TestMethod void addCannedResponse_Multiple_DifferentMethod() {
        String methodName = 'mockMethod';
        String otherMethodName = 'otherMethod';
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, new List<Object> {10, 12});
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(otherMethodName, new List<Object> {16, 20});
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName, invocation, new Answer());
        loli_Mock_CannedResponse cannedResponseOther = new loli_Mock_CannedResponse(otherInvocation.methodName, otherInvocation, new Answer());

        Mock testMock = new Mock();
        testMock.addCannedResponse(cannedResponseExpected);
        testMock.addCannedResponse(cannedResponseOther);

        List<loli_Mock_CannedResponse> cannedResponseList = testMock.getResponses(methodName);

        System.assert(cannedResponseList != null);
        System.assertEquals(1, cannedResponseList.size());
        System.assertEquals(cannedResponseExpected, cannedResponseList.get(0));
    }


    //----------------------------- when/invocation ----------------------------------//

    //---- Happy path ----//

    public static TestMethod void when_Single() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocationExpected.methodName,
                invocationExpected, new Answer(answer));

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);

        List<loli_Mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(1, cannedResponses.size());
        System.assertEquals(cannedResponseExpected, cannedResponses.get(0));
    }

    public static TestMethod void when_Multiple() {
        String methodName = 'mockMethod';
        String answer = 'hello World';
        List<Object> params = new List<Object> {10, 12};
        List<Object> otherParams = new List<Object> {16, 18};
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        loli_Mock_Invocation otherInvocation = new loli_Mock_Invocation(methodName, otherParams);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocationExpected.methodName,
                invocationExpected, new Answer(answer));
        loli_Mock_CannedResponse otherCannedResponse = new loli_Mock_CannedResponse(otherInvocation.methodName,
                otherInvocation, new Answer(answer));

        Mock testMock = new Mock();
        testMock.when().invocation(testMock.mockMethod(params.get(0), params.get(1))).thenReturn(answer);
        testMock.when().invocation(testMock.mockMethod(otherParams.get(0), otherParams.get(1))).thenReturn(answer);

        List<loli_Mock_CannedResponse> cannedResponses = testMock.getResponses(methodName);

        System.assert(cannedResponses != null);
        System.assertEquals(2, cannedResponses.size());
        System.assertEquals(cannedResponseExpected, cannedResponses.get(0));
        System.assertEquals(otherCannedResponse, cannedResponses.get(1));
    }

}