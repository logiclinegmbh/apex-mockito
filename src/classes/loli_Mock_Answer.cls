/**
 * Default answers
 */

public with sharing class loli_Mock_Answer {

    /**
     * Answer class for wrapping parameter answers
     */
    public class ThenReturnAnswer implements loli_Mock_IAnswer {

        private Object answer;

        public ThenReturnAnswer(Object answer) {
            this.answer = answer;
        }

        public Object onInvocation(loli_Mock_Invocation invocation) {
            if (!(answer instanceof Exception)) {
                return answer;
            } else {
                throw (Exception) answer;
            }
        }

    }

}