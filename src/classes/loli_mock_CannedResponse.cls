/**
 * Specifies the mock answer for a specific request
 */
public with sharing class loli_mock_CannedResponse {

    public loli_mock_IMatcher invocationMatcher {get; private set;}
    public loli_mock_IAnswer answer {get; private set;}

    public loli_mock_CannedResponse(loli_mock_Invocation invocationToResponseTo,
            loli_mock_IAnswer answer) {
        this.invocationMatcher = new loli_mock_InvocationMatcher(invocationToResponseTo);
        this.answer = answer;
    }
}