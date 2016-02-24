/**
 * Default answers
 */

public with sharing class loli_mock_Answer {

    /**
     * Answer class for wrapping parameter answers
     */
    public class ThenReturnAnswer implements loli_mock_IAnswer {

        private Object answer;

        public ThenReturnAnswer(Object answer) {
            this.answer = answer;
        }

        public Object onInvocation(loli_mock_Invocation invocation) {
            if (!isException(answer)) {
                return answer;
            } else {
                throw (Exception) answer;
            }
        }

        /**
         * Checks if the provided object is an instance of exception
         */
        private Boolean isException(Object answer) {
            /**
             * Please do not change to instanceof if clause since this leads to random test errors
             * Below "solution" is considered as workaround and is subject to future improvements
             */
            try {
                Exception forWorkaround = (Exception) answer;
                return true;
            } catch (Exception e) {
                return false;
            }
        }

    }

}