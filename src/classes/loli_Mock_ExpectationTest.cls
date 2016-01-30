@isTest
public with sharing class loli_Mock_ExpectationTest {

    private static Boolean isAddCannedResponseCalled = false;

    //----------------------------- Classes ----------------------------------//

    private class TestException extends Exception{}

    private class Mock implements loli_IMock {

        private MockValidator validator;

        public Mock(MockValidator validator) {
            this.validator = validator;
        }

        public void addCannedResponse(loli_Mock_CannedResponse newCannedResponse) {
            isAddCannedResponseCalled = true;
            validator.validateAddCannedResponse(newCannedResponse);
        }

        public loli_Mock_Expectation invocation(Object fromInvocation) {
            return null;
        }

        public List<loli_Mock_CannedResponse> getResponses(String methodName) {
            return null;
        }

        public loli_IMock when() {
            return null;
        }

        public Object doInvocation(String methodName, List<Object> parameters) {
            return null;
        }

        public Object doInvocation(String methodName) {
            return null;
        }

    }

    private class MockValidator {

        private loli_Mock_CannedResponse cannedResponseExpected;
        private Boolean isException = false;

        public MockValidator(loli_Mock_CannedResponse cannedResponseExpected) {
            this.cannedResponseExpected = cannedResponseExpected;
        }

        public MockValidator(loli_Mock_CannedResponse cannedResponseExpected, Boolean isException) {
            this(cannedResponseExpected);
            this.isException = isException;
        }

        public void validateAddCannedResponse(loli_Mock_CannedResponse newCannedResponse) {
            System.assert(newCannedResponse != null);
            System.assertEquals(cannedResponseExpected, newCannedResponse);

            if (!isException) {
                Object answerExpected = cannedResponseExpected.answer.onInvocation
                        (cannedResponseExpected.invocationToResponseTo);
                Object answerReceived = newCannedResponse.answer.onInvocation(newCannedResponse.invocationToResponseTo);
                System.assertEquals(answerExpected, answerReceived);
            } else {
                try {
                    newCannedResponse.answer.onInvocation(newCannedResponse.invocationToResponseTo);
                    System.assert(false);
                } catch (TestException e) {
                    System.assert(true);
                } catch (Exception e) {
                    System.assert(false);
                }
            }


        }


    }

    private class Answer implements loli_Mock_IAnswer {

        private Object toAnswer;
        private AnswerValidator validator;

        public Answer(AnswerValidator validator, Object toAnswer) {
            this.toAnswer = toAnswer;
            this.validator = validator;
        }

        public Object onInvocation(loli_Mock_Invocation invocation) {
            validator.validateOnInvokation(invocation);
            return toAnswer;
        }

    }

    private class AnswerValidator {

        private loli_Mock_Invocation invocationExpected;

        AnswerValidator(loli_Mock_Invocation invocationExpected) {
            this.invocationExpected = invocationExpected;
        }

        public void validateOnInvokation(loli_Mock_Invocation invocation) {
            System.assertEquals(invocationExpected, invocation);
        }


    }


    //----------------------------- ThenReturn ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void thenReturn() {
        String answer = 'hello World';
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocation);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName,
                invocation, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_Expectation expectation = new loli_Mock_Expectation(testMock, invocation);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    private static TestMethod void thenReturn_Exception() {
        Exception answer = new TestException();
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocation);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName,
                invocation, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, true);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_Expectation expectation = new loli_Mock_Expectation(testMock, invocation);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    //----------------------------- ThenAnswer ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void thenAnswer() {
        String answer = 'hello World';
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_Invocation invocation = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocation);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocation.methodName,
                invocation, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_Expectation expectation = new loli_Mock_Expectation(testMock, invocation);
        expectation.thenAnswer(invocationAnswer);

        System.assert(isAddCannedResponseCalled);
    }

}