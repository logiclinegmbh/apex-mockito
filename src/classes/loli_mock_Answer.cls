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
            if (!(answer instanceof Exception)) {
                return answer;
            } else {
                throw (Exception) answer;
            }
        }

    }

}