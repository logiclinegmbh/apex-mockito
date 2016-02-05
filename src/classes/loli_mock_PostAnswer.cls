/**
 * Posting answers
 */

public with sharing class loli_mock_PostAnswer {

    private loli_mock_IMock mock;
    private loli_mock_Invocation invocation;

    public loli_mock_PostAnswer(loli_mock_IMock mock, loli_mock_Invocation invocation) {
        this.mock = mock;
        this.invocation = invocation;
    }

    public void thenReturn(Object answer) {
        mock.addCannedResponse(invocation, new loli_mock_Answer.ThenReturnAnswer(answer));
    }

    public void thenAnswer(loli_mock_IAnswer answer) {
        mock.addCannedResponse(invocation, answer);
    }

}