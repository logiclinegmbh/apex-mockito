@isTest
public with sharing class loli_Mock_PostAnswerTest {
    private static Boolean isAddCannedResponseCalled = false;

    //----------------------------- Classes ----------------------------------//

    private class TestException extends Exception{}

    private class Mock implements loli_IMock {

        private MockValidator validator;

        public Mock(MockValidator validator) {
            this.validator = validator;
        }

        public void addCannedResponse(loli_Mock_Invocation invocation, loli_Mock_IAnswer answer) {
            isAddCannedResponseCalled = true;
            validator.validateAddCannedResponse(new loli_Mock_CannedResponse(invocation, answer), invocation);
        }

        public loli_Mock_PostAnswer invocation(Object fromInvocation) {
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


        public loli_IMock verify() {
            return null;
        }


        public loli_Mock_Verification that(Object fromInvocation) {
            return null;
        }

        public Object expectationFor(loli_Mock_Expectation expectation) {
            return null;
        }

        public loli_IMock answerFor(Object answer) {
            return null;
        }

    }

    private class MockValidator {

        private loli_Mock_Invocation invocationExpected;
        private loli_Mock_CannedResponse cannedResponseExpected;
        private Boolean isException = false;

        public MockValidator(loli_Mock_CannedResponse cannedResponseExpected, loli_Mock_Invocation invocationExpected) {
            this.cannedResponseExpected = cannedResponseExpected;
            this.invocationExpected = invocationExpected;
        }

        public MockValidator(loli_Mock_CannedResponse cannedResponseExpected, loli_Mock_Invocation invocationExpected,
                Boolean isException) {
            this(cannedResponseExpected, invocationExpected);
            this.isException = isException;
        }

        public void validateAddCannedResponse(loli_Mock_CannedResponse newCannedResponse, loli_Mock_Invocation invocation) {
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
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_PostAnswer expectation = new loli_Mock_PostAnswer(testMock, invocationExpected);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    private static TestMethod void thenReturn_Exception() {
        Exception answer = new TestException();
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected, true);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_PostAnswer expectation = new loli_Mock_PostAnswer(testMock, invocationExpected);
        expectation.thenReturn(answer);

        System.assert(isAddCannedResponseCalled);
    }

    //----------------------------- ThenAnswer ----------------------------------//

    //---- Happy path ----//

    private static TestMethod void thenAnswer() {
        String answer = 'hello World';
        String methodName = 'testMethod';
        List<Object> params = new List<Object> {12, 16};
        loli_Mock_Invocation invocationExpected = new loli_Mock_Invocation(methodName, params);
        AnswerValidator answerValidator = new AnswerValidator(invocationExpected);
        loli_Mock_IAnswer invocationAnswer = new Answer(answerValidator, answer);
        loli_Mock_CannedResponse cannedResponseExpected = new loli_Mock_CannedResponse(invocationExpected, invocationAnswer);

        MockValidator mockValidator = new MockValidator(cannedResponseExpected, invocationExpected);
        loli_IMock testMock = new Mock(mockValidator);

        loli_Mock_PostAnswer expectation = new loli_Mock_PostAnswer(testMock, invocationExpected);
        expectation.thenAnswer(invocationAnswer);

        System.assert(isAddCannedResponseCalled);
    }

}