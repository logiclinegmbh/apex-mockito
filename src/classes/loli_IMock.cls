/**
 * Basic mock interface
 */
public interface loli_IMock {

    /**
     * Adds a canned response to the mock
     */
    void addCannedResponse(loli_Mock_CannedResponse newCannedResponse);

    /**
     * Hanles an invocation
     */
    loli_Mock_Expectation invocation(Object fromInvocation);
}