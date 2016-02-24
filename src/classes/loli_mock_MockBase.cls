/**
 * Base class for mocking
 */
public abstract with sharing class loli_mock_MockBase implements loli_mock_IMock {


    /**
     * Status values of mock
     */
    private enum Status {
        inWhen, inWhenAnswerFor, inExecution, inVerify, inVerifyExpectationFor
    }


    // Current mock status --> used to determine how to handle mock invocations
    private Status mockStatus = Status.inExecution;
    // Holds an invocation in case of when/verify
    private loli_mock_Invocation invocationHolder;
    // Holds expectation in case verify/expectationFor is used
    private loli_mock_Expectation expectationHolder;
    // Holds answer in case when/answerFor is used
    private loli_mock_IAnswer answerHolder;
    // Holds matchers for invocation (if any specified)
    private List<loli_mock_IMatcher> matchers = new List<loli_mock_IMatcher>();



    // Canned responses for each method
    private Map<String, List<loli_mock_CannedResponse>> cannedResponseByMethodName = new Map<String, List<loli_mock_CannedResponse>>();
    // Recorded responses for each method
    private Map<String, List<loli_mock_Invocation>> invocationsByMethodName = new Map<String, List<loli_mock_Invocation>>();

    public void addCannedResponse(loli_mock_Invocation invocation, loli_mock_IAnswer answer) {
        loli_mock_CannedResponse newCannedResponse = new loli_mock_CannedResponse(invocation, answer);
        List<loli_mock_CannedResponse> cannedResponseList = cannedResponseByMethodName.get(invocation.methodName);

        // In case canned responses do not yet exist for method add method and new canned response
        if (cannedResponseList == null) {
            cannedResponseList = new List<loli_mock_CannedResponse>();
            cannedResponseByMethodName.put(invocation.methodName, cannedResponseList);
            cannedResponseList.add(newCannedResponse);
        } else {
            addCannedResponseForMethod(invocation, newCannedResponse, cannedResponseList);
        }
    }

    public List<loli_mock_CannedResponse> getResponses(String methodName) {
        return cannedResponseByMethodName.get(methodName);
    }

    public loli_mock_IMock when() {
        mockStatus = Status.inWhen;
        return this;
    }

    public loli_mock_IMock verify() {
        mockStatus = Status.inVerify;
        return this;
    }

    public loli_mock_PostAnswer invocation(Object fromInvocation) {
        loli_mock_Invocation invocation = makeInvocation(invocationHolder);
        loli_mock_PostAnswer expectation = new loli_mock_PostAnswer(this, invocation);
        resetMockToDefault();
        return expectation;
    }

    public loli_mock_IMock answerFor(Object answer) {
        mockStatus = Status.inWhenAnswerFor;
        if (!(answer instanceof loli_mock_IAnswer)) {
            answerHolder = new loli_mock_Answer.ThenReturnAnswer(answer);
        } else {
            answerHolder = (loli_mock_IAnswer) answer;
        }
        return this;
    }

    public loli_mock_Verification that(Object fromInvocation) {
        loli_mock_Invocation invocation = makeInvocation(invocationHolder);
        loli_mock_Verification verification;
        if (mockStatus == Status.inVerify) {
            verification = makeVerify(invocation);
        }
        resetMockToDefault();
        return verification;
    }

    public Object expectationFor(loli_mock_Expectation expectation) {
        expectationHolder = expectation;
        mockStatus = Status.inVerifyExpectationFor;
        return this;
    }

    public Object doInvocation(String methodName, List<Object> parameters) {
        loli_mock_Invocation invocation = new loli_mock_Invocation(methodName, parameters);
        System.debug('Mock invocation with status: ' + mockStatus.name());
        // Perform invocation based on mock state:
        if (mockStatus == Status.inExecution) {
            recordInvocation(invocation);
            return invokeCannedResponse(invocation);
        } else if (mockStatus == Status.inWhen || mockStatus == Status.inVerify) {
            invocationHolder = invocation;
            return null;
        } else if (mockStatus == Status.inWhenAnswerFor) {
            invocation = makeInvocation(invocation);
            addCannedResponse(invocation, answerHolder);
            resetMockToDefault();
        } else if (mockStatus == Status.inVerifyExpectationFor) {
            // Verification is performed at the end of mock call chain
            // --> calling method performs verification then
            invocation = makeInvocation(invocation);
            loli_mock_Verification verification = makeVerify(invocation);
            verification.verifyExpectation(expectationHolder);
            resetMockToDefault();
        }
        return null;
    }

    public Object doInvocation(String methodName) {
        return doInvocation(methodName, new List<Object>());
    }

    public Object matcher(loli_mock_IMatcher customMatcher) {
        matchers.add(customMatcher);
        return null;
    }


    /**
     * Adds a new canned response for a method to existing list of canned responses
     * In case a canned method with the same paramters already exists is is overwritten
     */
    private void addCannedResponseForMethod(loli_mock_Invocation invocation, loli_mock_CannedResponse newCannedResponse,
            List<loli_mock_CannedResponse> cannedResponsesForMethod) {
        Boolean isCannedResponseAlreadyExisiting = false;
        Integer cannedResponseIndex = 0;
        Integer cannedResponseExistingIndex;

        // Search for identical canned response
        while (!isCannedResponseAlreadyExisiting && cannedResponseIndex < cannedResponsesForMethod.size()) {
            loli_mock_CannedResponse cannedResponseExisting = cannedResponsesForMethod.get(cannedResponseIndex);
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
    private Object invokeCannedResponse(loli_mock_Invocation invocation) {
        List<loli_mock_CannedResponse> cannedResponsesForMethod = cannedResponseByMethodName.get(invocation.methodName);
        if (cannedResponsesForMethod == null || cannedResponsesForMethod.isEmpty()) {
            return null;
        }

        // In case a canned response is found invoke mocked answer
        for (loli_mock_CannedResponse cannedResponse : cannedResponsesForMethod) {
            if (cannedResponse.invocationMatcher.matches(invocation)) {
                return cannedResponse.answer.onInvocation(invocation);
            }
        }
        return null;

    }

    /**
     * Records an invocation that happened on the mock
     */
    private void recordInvocation(loli_mock_Invocation invocation) {
        List<loli_mock_Invocation> invocationsForMethod = invocationsByMethodName.get(invocation.methodName);
        if (invocationsForMethod == null) {
            invocationsForMethod = new List<loli_mock_Invocation>();
            invocationsByMethodName.put(invocation.methodName, invocationsForMethod);
        }
        invocationsForMethod.add(invocation);
    }

    /**
     * Resets to mock to its default status
     */
    private void resetMockToDefault() {
        invocationHolder = null;
        expectationHolder = null;
        answerHolder = null;
        matchers = new List<loli_mock_IMatcher>();
        mockStatus = Status.inExecution;
    }

    /**
     * Performs verify
     */
    private loli_mock_Verification makeVerify(loli_mock_Invocation invocation) {
        // Check if there exists an invocations --> return verifications with empty verification list in case not
        List<loli_mock_Invocation> invocationsForMethod = invocationsByMethodName.get(invocation.methodName);
        if (invocationsForMethod == null || invocationsForMethod.isEmpty()) {
            return new loli_mock_Verification(invocation.methodName);
        }

        // Gather matching invocations
        List<loli_mock_Invocation> invocationsMatching = new List<loli_mock_Invocation>();
        loli_mock_InvocationMatcher matcher = new loli_mock_InvocationMatcher(invocation);
        for (loli_mock_Invocation invocationRecorded : invocationsForMethod) {
            if (matcher.matches(invocationRecorded)) {
                invocationsMatching.add(invocationRecorded);
            }
        }
        return new loli_mock_Verification(invocation.methodName, invocationsMatching);
    }

    /**
     * Creates the invocation for when/verify
     * In case matchers are used these are set as parameters for the invocation, otherwise the real values
     */
    private loli_mock_Invocation makeInvocation(loli_mock_Invocation invocation) {
        if (matchers.isEmpty()) {
            return invocation;
        } else {
            if (matchers.size() != invocation.parameters.size()) {
                System.assert(false, 'You have to use any for all values');
            }

            return new loli_mock_Invocation(invocation.methodName, matchers);
        }
    }

    //----------------------------- Any ----------------------------------//

    public String anyString() {
        matchers.add(new loli_mock_ParameterMatcher.AnyStringMatcher());
        return null;
    }

    public Integer anyInteger() {
        matchers.add(new loli_mock_ParameterMatcher.AnyIntegerMatcher());
        return null;
    }

    public Boolean anyBoolean() {
        matchers.add(new loli_mock_ParameterMatcher.AnyBooleanMatcher());
        return null;
    }

    public Date anyDate() {
        matchers.add(new loli_mock_ParameterMatcher.AnyDateMatcher());
        return null;
    }

    public DateTime anyDateTime() {
        matchers.add(new loli_mock_ParameterMatcher.AnyDateTimeMatcher());
        return null;
    }

    public Decimal anyDecimal() {
        matchers.add(new loli_mock_ParameterMatcher.AnyDecimalMatcher());
        return null;
    }

    public Double anyDouble() {
        matchers.add(new loli_mock_ParameterMatcher.AnyDoubleMatcher());
        return null;
    }

    public Id anyId() {
        matchers.add(new loli_mock_ParameterMatcher.AnyIdMatcher());
        return null;
    }

    public Long anyLong() {
        matchers.add(new loli_mock_ParameterMatcher.AnyLongMatcher());
        return null;
    }

    public Time anyTime() {
        matchers.add(new loli_mock_ParameterMatcher.AnyTimeMatcher());
        return null;
    }

    public Iterable<Object> anyIterable() {
        matchers.add(new loli_mock_ParameterMatcher.AnyIterableMatcher());
        return null;
    }

    public sObject anySObject() {
        matchers.add(new loli_mock_ParameterMatcher.AnySObjectMatcher());
        return null;
    }

    public Object anyObject() {
        matchers.add(new loli_mock_ParameterMatcher.AnyObjectMatcher());
        return null;
    }


    public Object anyValue(Object valueHolder) {
        matchers.add(new loli_mock_ParameterMatcher.AnyValueMatcher(valueHolder));
        return null;
    }

}