/**
 * Specifies the mock answer for a specific request
 */
public with sharing class loli_Mock_CannedResponse {

    public loli_Mock_IMatcher invocationMatcher {get; private set;}
    public loli_Mock_IAnswer answer {get; private set;}

    public loli_Mock_CannedResponse(loli_Mock_Invocation invocationToResponseTo,
            loli_Mock_IAnswer answer) {
        this.invocationMatcher = new loli_Mock_InvocationMatcher(invocationToResponseTo);
        this.answer = answer;
    }
}