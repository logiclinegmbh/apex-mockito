/**
 * Contains methods for defining expectations
 */
public with sharing class loli_Mock_Expectation {

    private class ThenReturnAnswer implements loli_Mock_IAnswer {

        private Object answer;

        public ThenReturnAnswer(Object answer) {
            this.answer = answer;
        }

        public Object onInvokation(loli_Mock_Invokation invokation) {
            if (!(answer instanceof Exception)) {
                return answer;
            } else {
                throw (Exception) answer;
            }
        }

    }

    private loli_IMock mock;
    private loli_Mock_Invokation invokation;

    public loli_Mock_Expectation(loli_IMock mock, loli_Mock_Invokation invokation) {
        this.mock = mock;
        this.invokation = invokation;
    }

    public void thenReturn(Object answer) {
        mock.addCannedResponse(new loli_Mock_CannedResponse(invokation.methodName, invokation,
                new ThenReturnAnswer(answer)));
    }

    public void thenAnswer(loli_Mock_IAnswer answer) {
        mock.addCannedResponse(new loli_Mock_CannedResponse(invokation.methodName, invokation, answer));
    }

}