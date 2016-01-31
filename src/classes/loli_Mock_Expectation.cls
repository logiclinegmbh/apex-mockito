/**
 * Contains methods for defining expectations
 */
public with sharing class loli_Mock_Expectation {

    private class ThenReturnAnswer implements loli_Mock_IAnswer {

        private Object answer;

        public ThenReturnAnswer(Object answer) {
            this.answer = answer;
        }

        public Object onInvocation(loli_Mock_Invocation invocation) {
            if (!(answer instanceof Exception)) {
                return answer;
            } else {
                throw (Exception) answer;
            }
        }

    }

    private loli_IMock mock;
    private loli_Mock_Invocation invocation;

    public loli_Mock_Expectation(loli_IMock mock, loli_Mock_Invocation invocation) {
        this.mock = mock;
        this.invocation = invocation;
    }

    public void thenReturn(Object answer) {
        mock.addCannedResponse(invocation, new ThenReturnAnswer(answer));
    }

    public void thenAnswer(loli_Mock_IAnswer answer) {
        mock.addCannedResponse(invocation, answer);
    }

}