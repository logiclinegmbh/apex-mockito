@isTest
public with sharing class loli_mock_PostAnswerTest {
    private static Boolean isAddCannedResponseCalled = false;

    //----------------------------- Classes ----------------------------------//

    private class loli_mock_TestException extends Exception{}

    private class Mock implements loli_mock_IMock {

        private MockValidator validator;

        public Mock(MockValidator validator) {
            this.validator = validator;
        }

        public void addCannedResponse(loli_mock_Invocation invocation, loli_mock_IAnswer answer) {
            isAddCannedResponseCalled = true;
            validator.validateAddCannedResponse(new loli_mock_CannedResponse(invocation, answer), invocation);
        }

        public loli_mock_PostAnswer invocation(Object fromInvocation) {
            return null;
        }

        public List<loli_mock_CannedResponse> getResponses(String methodName) {
            return null;
        }

        public loli_mock_IMock when() {
            return null;
        }

        public Object doInvocation(String methodName, List<Object> parameters) {
            return null;
        }

        public Object doInvocation(String methodName) {
            return null;
        }


        public loli_mock_IMock verify() {
            return null;
        }


        public loli_mock_Verification that(Object fromInvocation) {
            return null;
        }

        public Object expectationFor(loli_mock_Expectation expectation) {
            return null;
        }

        public loli_mock_IMock answerFor(Object answer) {
            return null;
        }

    }

    private class MockValidator {

        private loli_mock_Invocation invocationExpected;
        private loli_mock_CannedResponse cannedResponseExpected;
        private Boolean isException = false;

        public MockValidator(loli_mock_CannedResponse cannedResponseExpected, loli_mock_Invocation invocationExpected) {
            this.cannedResponseExpected = cannedResponseExpected;
            this.invocationExpected = invocationExpected;
        }

        public MockValidator(loli_mock_CannedResponse cannedResponseExpected, loli_mock_Invocation invocationExpected,
                Boolean isException) {
            this(cannedResponseExpected, invocationExpected);
            this.isException = isException;
        }

        public void validateAddCannedResponse(loli_mock_CannedResponse newCannedResponse, loli_mock_Invocation invocation) {
            System.assert(invocation != null);
            System.assertEquals(invocationExpected, invocation);

            if (!isException) {
                Object answerExpected = cannedResponseExpected.answer.onInvocation
                        (invocation);
                Object answerReceived = newCannedResponse.answer.onInvocation(invocation);
                System.assertEquals(answerExpected, answerReceived);
            } else {
                try {
                    newCannedResponse.answer.onInvocation(invocation);
                    System.assert(false);
                } catch (loli_mock_TestException e) {
                    System.assert(true);
                } catch (Exception e) {
                    System.assert(false);
                }
            }


        }


    }

    private class Answer implements loli_mock_IAnswer {

        private Object toAnswer;
        private AnswerValidator validator;

        public Answer(AnswerValidator validator, Object toAnswer) {
            this.toAnswer = toAnswer;
            this.validator = validator;
        }

        public Object onInvocation(loli_mock_Invocation invocation) {
            validator.validateOnInvokation(invocation);
            return toAnswer;
        }

    }

    private class AnswerValidator {

        private loli_mock_Invocation invocationExpected;

        AnswerValidator(loli_mock_Invocation invocationExpected) {
            this.invocationExpected = invocationExpected;
        }

        public void validateOnInvokation(loli_mock_Invocation invocation) {
            System.assertEquals(invocationExpected, invocation);
        }


    }


    //----------------------------- ThenReturn ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void thenReturn() {
        String answer = 'hello World';
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_mock_CannedResponse cannedResponseExpected = new loli_mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected);
        loli_mock_IMock testMock = new Mock(mockValidator);

        loli_mock_PostAnswer expectation = new loli_mock_PostAnswer(testMock, invocationExpected);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    private static TestMethod void thenReturn_Exception() {
        Exception answer = new loli_mock_TestException();
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_mock_CannedResponse cannedResponseExpected = new loli_mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected, true);
        loli_mock_IMock testMock = new Mock(mockValidator);

        loli_mock_PostAnswer expectation = new loli_mock_PostAnswer(testMock, invocationExpected);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    //----------------------------- ThenAnswer ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void thenAnswer() {
        String answer = 'hello World';
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_mock_Invocation invocationExpected = new loli_mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_mock_CannedResponse cannedResponseExpected = new loli_mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected);
        loli_mock_IMock testMock = new Mock(mockValidator);

        loli_mock_PostAnswer expectation = new loli_mock_PostAnswer(testMock, invocationExpected);
        expectation.thenAnswer(invocationAnswer);

        System.assert(isAddCannedResponseCalled);
    }

}