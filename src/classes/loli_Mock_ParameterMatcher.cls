/**
 * Matchers for parameters
 */

public with sharing class loli_Mock_ParameterMatcher {

    /**
     * Any string matcher
     */
    public class AnyStringMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof String)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any integer matcher
     */
    public class AnyIntegerMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Integer)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any boolean matcher
     */
    public class AnyBooleanMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Boolean)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any date matcher
     */
    public class AnyDateMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Date)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any datetime matcher
     */
    public class AnyDateTimeMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof DateTime)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any decimal matcher
     */
    public class AnyDecimalMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Decimal)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any double matcher
     */
    public class AnyDoubleMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Double)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any id matcher
     */
    public class AnyIdMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof ID)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any long matcher
     */
    public class AnyLongMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Long)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any time matcher
     */
    public class AnyTimeMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Time)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any iterable matcher
     */
    public class AnyIterableMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            if ((compare instanceof Iterable<Object>)) {
                return true;
            } else {
                return false;
            }
        }

    }

    /**
     * Any object matcher
     */
    public class AnyObjectMatcher implements loli_Mock_IMatcher {

        public Boolean matches(Object compare) {
            return true;
        }

    }

    /**
     * Any value matcher
     */
    public class AnyValueMatcher implements loli_Mock_IMatcher {

        private Object valueBase;

        public AnyValueMatcher(Object valueBase) {
            this.valueBase = valueBase;
        }

        public Boolean matches(Object compare) {
            return valueBase == compare;
        }

    }

}