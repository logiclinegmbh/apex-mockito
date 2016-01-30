/**
 * Specifies the mock answer for a specific request
 */
public with sharing class loli_Mock_CannedResponse {

    String methodName;
    public loli_Mock_Invokation invokationToResponseTo {get; private set;}
    public loli_Mock_IAnswer answer {get; private set;}

    public loli_Mock_CannedResponse(String methodName, loli_Mock_Invokation invokationToResponseTo,
            loli_Mock_IAnswer answer) {
        this.methodName = methodName;
        this.invokationToResponseTo = invokationToResponseTo;
        this.answer = answer;
    }

    public loli_Mock_CannedResponse(String methodName, loli_Mock_IAnswer answer) {
        this(methodName, new loli_Mock_Invokation(methodName, new List<Object>()), answer);
    }

    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_Mock_CannedResponse)) {
            return false;
        }

        loli_Mock_CannedResponse cannedResponseCompare = (loli_Mock_CannedResponse) compare;
        return methodName == cannedResponseCompare.methodName &&
                invokationToResponseTo == cannedResponseCompare.invokationToResponseTo;
    }
}