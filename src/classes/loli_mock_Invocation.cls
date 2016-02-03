/**
 * Contains details about a specific invocation
 */
public with sharing class loli_mock_Invocation {

    public String methodName {get; private set;}
    public List<Object> parameters {get; private set;}

    public loli_mock_Invocation(String methodName, List<Object> parameters) {
        this.methodName = methodName;
        this.parameters = parameters;
    }

    public loli_mock_Invocation(String methodName) {
        this(methodName, new List<Object>());
    }


    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_mock_Invocation)) {
            return false;
        }

        loli_mock_Invocation invocationCompare = (loli_mock_Invocation) compare;
        return methodName == invocationCompare.methodName && areParametersEqual(invocationCompare.parameters);
    }

        /**
         * Compares parameter of Invokation details with list of parameters
         */
    private Boolean areParametersEqual(List<Object> parametersCompare) {
        if (parameters != null) {
            if (parametersCompare == null || parameters.size() != parametersCompare.size()) {
                return false;
            }
            for (Integer parameterIndex = 0; parameterIndex < parameters.size(); parameterIndex++) {
                Object parameter = parameters.get(parameterIndex);
                Object parameterCompare = parametersCompare.get(parameterIndex);
                if (parameter != parameterCompare) {
                    return false;
                }
            }
            return true;
        } else if (parametersCompare != null){
            return false;
        }
        return true;
    }
}