/**
 * Basic mock interface
 */
public interface loli_IMock {

    /**
     * Adds a canned response to the mock
     */
    void addCannedResponse(loli_Mock_Invocation invocation, loli_Mock_IAnswer answer);

    /**
     * Returns mocked responses for a method
     */
    List<loli_Mock_CannedResponse> getResponses(String methodName);

    /**
     * Handles when() invocation
     */
    loli_Mock_PostAnswer invocation(Object fromInvocation);

    /**
     * Handles when() in case answer provided before defining invocation
     */
    loli_IMock answerFor(Object answer);

    /**
     * Starts mocking
     */
    loli_IMock when();

    /**
     * Starts verification
     */
    loli_IMock verify();

    /**
     * Handles verify() invocation
     */
    loli_Mock_Verification that(Object fromInvocation);

    /**
     * Handles verify() in case expectation provided before defining invocation
     */
    Object expectationFor(loli_Mock_Expectation expectation);

    /**
     * Invocation handler for calls to mock methods
     */
    Object doInvocation(String methodName, List<Object> parameters);

    /**
     * Invocation handler for calls to mock methods
     */
    Object doInvocation(String methodName);
}