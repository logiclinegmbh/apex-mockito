/**
 * Defines an answer provided by the mock
 */

public interface loli_mock_IAnswer {

    /**
     * Called on mock invocation
     */
    Object onInvocation(loli_mock_Invocation invocation);

}