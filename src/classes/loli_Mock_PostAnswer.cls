/**
 * Posting answers
 */

public with sharing class loli_Mock_PostAnswer {

    private loli_IMock mock;
    private loli_Mock_Invocation invocation;

    public loli_Mock_PostAnswer(loli_IMock mock, loli_Mock_Invocation invocation) {
        this.mock = mock;
        this.invocation = invocation;
    }

    public void thenReturn(Object answer) {
        mock.addCannedResponse(invocation, new loli_Mock_Answer.ThenReturnAnswer(answer));
    }

    public void thenAnswer(loli_Mock_IAnswer answer) {
        mock.addCannedResponse(invocation, answer);
    }

}