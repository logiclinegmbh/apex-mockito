/**
 * Defines an answer provided by the mock
 */

public interface loli_Mock_IAnswer {

    /**
     * Called on mock invocation
     */
    Object onInvocation(loli_Mock_Invocation invocation);

}