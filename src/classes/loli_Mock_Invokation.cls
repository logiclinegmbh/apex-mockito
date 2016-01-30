/**
 * Contains details about a specific invokation
 */
public with sharing class loli_Mock_Invokation {

    public String methodName {get; private set;}
    public List<Object> parameters {get; private set;}

    public loli_Mock_Invokation(String methodName, List<Object> parameters) {
        this.methodName = methodName;
        this.parameters = parameters;
    }

    public loli_Mock_Invokation(String methodName) {
        this(methodName, new List<Object>());
    }


    public Boolean equals(Object compare) {
        if (!(compare instanceof loli_Mock_Invokation)) {
            return false;
        }

        loli_Mock_Invokation invokationCompare = (loli_Mock_Invokation) compare;
        return methodName == invokationCompare.methodName && areParametersEqual(invokationCompare.parameters);
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