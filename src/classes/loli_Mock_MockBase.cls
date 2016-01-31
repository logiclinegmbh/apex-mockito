/**
 * Base class for mocking
 */
public abstract with sharing class loli_Mock_MockBase implements loli_IMock {

    private enum Status {
        inWhen, inExecution, inVerify
    }


    private Status mockStatus = Status.inExecution;
    private loli_Mock_Invocation invocationHolder;

    private Map<String, List<loli_Mock_CannedResponse>> cannedResponseByMethodName = new Map<String, List<loli_Mock_CannedResponse>>();
    private Map<String, List<loli_Mock_Invocation>> invocationsByMethodName = new Map<String, List<loli_Mock_Invocation>>();

    public void addCannedResponse(loli_Mock_Invocation invocation, loli_Mock_IAnswer answer) {
        loli_Mock_CannedResponse newCannedResponse = new loli_Mock_CannedResponse(invocation, answer);
        List<loli_Mock_CannedResponse> cannedResponseList = cannedResponseByMethodName.get(invocation.methodName);

        // In case canned responses do not yet exist for method add method and new canned response
        if (cannedResponseList == null) {
            cannedResponseList = new List<loli_Mock_CannedResponse>();
            cannedResponseByMethodName.put(invocation.methodName, cannedResponseList);
            cannedResponseList.add(newCannedResponse);
        } else {
            addCannedResponseForMethod(invocation, newCannedResponse, cannedResponseList);
        }
    }

    public List<loli_Mock_CannedResponse> getResponses(String methodName) {
        return cannedResponseByMethodName.get(methodName);
    }

    public loli_IMock when() {
        mockStatus = Status.inWhen;
        return this;
    }

    public loli_IMock verify() {
        mockStatus = Status.inVerify;
        return this;
    }

    public loli_Mock_Expectation invocation(Object fromInvocation) {
        loli_Mock_Expectation expectation = new loli_Mock_Expectation(this, invocationHolder);
        invocationHolder = null;
        mockStatus = Status.inExecution;
        return expectation;
    }

    public loli_Mock_Verification that(Object fromInvocation) {
        return null;
    }

    public Object doInvocation(String methodName, List<Object> parameters) {
        if (mockStatus == Status.inExecution) {
            return invokeCannedResponse(new loli_Mock_Invocation(methodName, parameters));
        } else if (mockStatus == Status.inWhen) {
            invocationHolder = new loli_Mock_Invocation(methodName, parameters);
            return null;
        } else if (mockStatus == Status.inVerify) {
            return null;
        }
        return null;
    }

    public Object doInvocation(String methodName) {
        return doInvocation(methodName, new List<Object>());
    }


    /**
     * Adds a new canned response for a method to existing list of canned responses
     * In case a canned method with the same paramters already exists is is overwritten
     */
    private void addCannedResponseForMethod(loli_Mock_Invocation invocation, loli_Mock_CannedResponse newCannedResponse,
            List<loli_Mock_CannedResponse> cannedResponsesForMethod) {
        Boolean isCannedResponseAlreadyExisiting = false;
        Integer cannedResponseIndex = 0;
        Integer cannedResponseExistingIndex;

        // Search for identical canned response
        while (!isCannedResponseAlreadyExisiting && cannedResponseIndex < cannedResponsesForMethod.size()) {
            loli_Mock_CannedResponse cannedResponseExisting = cannedResponsesForMethod.get(cannedResponseIndex);
            if (cannedResponseExisting.invocationMatcher.matches(invocation)) {
                isCannedResponseAlreadyExisiting = true;
                cannedResponseExistingIndex = cannedResponseIndex;
            }
            cannedResponseIndex++;
        }

        // Replace old canned response in case it already exists, otherwise add the new one
        if (isCannedResponseAlreadyExisiting) {
            cannedResponsesForMethod[cannedResponseExistingIndex] = newCannedResponse;
        } else {
            cannedResponsesForMethod.add(newCannedResponse);
        }
    }

    /**
     * Returns the mocked response for a mock and method call
     * If no canned response exists for the method/method call then null is returned
     */
    private Object invokeCannedResponse(loli_Mock_Invocation invocation) {
        List<loli_Mock_CannedResponse> cannedResponsesForMethod = cannedResponseByMethodName.get(invocation.methodName);
        if (cannedResponsesForMethod == null || cannedResponsesForMethod.isEmpty()) {
            return null;
        }

        // In case a canned response is found invoke mocked answer
        for (loli_Mock_CannedResponse cannedResponse : cannedResponsesForMethod) {
            if (cannedResponse.invocationMatcher.matches(invocation)) {
                return cannedResponse.answer.onInvocation(invocation);
            }
        }
        return null;

    }

    private void recordInvocation(loli_Mock_Invocation invocation) {
           
    }

}