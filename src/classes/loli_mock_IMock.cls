/**
 * Basic mock interface
 */
public interface loli_mock_IMock {

    /**
     * Adds a canned response to the mock
     */
    void addCannedResponse(loli_mock_Invocation invocation, loli_mock_IAnswer answer);

    /**
     * Returns mocked responses for a method
     */
    List<loli_mock_CannedResponse> getResponses(String methodName);

    /**
     * Handles when() invocation
     */
    loli_mock_PostAnswer invocation(Object fromInvocation);

    /**
     * Handles when() in case answer provided before defining invocation
     */
    loli_mock_IMock answerFor(Object answer);

    /**
     * Starts mocking
     */
    loli_mock_IMock when();

    /**
     * Starts verification
     */
    loli_mock_IMock verify();

    /**
     * Handles verify() invocation
     */
    loli_mock_Verification that(Object fromInvocation);

    /**
     * Handles verify() in case expectation provided before defining invocation
     */
    Object expectationFor(loli_mock_Expectation expectation);

    /**
     * Invocation handler for calls to mock methods
     */
    Object doInvocation(String methodName, List<Object> parameters);

    /**
     * Invocation handler for calls to mock methods
     */
    Object doInvocation(String methodName);
}