Mock library for Apex inspired by [mockito](https://github.com/mockito/mockito) focused on easy mock setup
Supports stubbing as well as verification  
# Create Mocks
Mock are prepared by calling the ```doInvocation``` method of the ```loli_mock_MockBase``` class which implements the ```loli_mock_IMock``` interface(You can also provide your own implementation).  
The method name is provided as ```String```, the parameters as ```List<Object>``` (apex does not allow an automatic discovery of the method name and paramters).  

```java
// Implements the interface to mock
public class MyMock extends loli_mock_MockBase implements MyInterface {


    public Integer getInteger(String param1, Integer param2) {
        // Casting to return type
        return (Integer) super.doInvocation('getInteger', new List<Object> {param1, param2});
    }

    public void doSomething() {
        return super.doInvocation('doSomething', new List<Object> {requestedSlotsCount});
    }

}
```

# Stubbing
## thenReturn ##
There are two alternatives for stubbing behaviour:

```java
MyMock mock = new MyMock();
mock.when().invocation(mock.getInteger('Hello World', 0)).thenReturn(1);
```

```java
MyMock mock = new MyMock();
((MyMock) batchActionMock.when().answerFor(1)).getInteger('Hello World', 0);
```
**Important**: Although the first option is more clear it *does not work* with methods returning ```void``` (some apex limits again). Therefore

```java
MyMock mock = new MyMock();
mock.when().invocation(mock.doSomething().thenReturn(new MyException());
```
leads to a compile error. In such cases the second alternative needs to be used

```java
MyMock mock = new MyMock();
((MyMock) mock.when().answerFor(new MyException())).doNothing();
```
You can stub simple types, complex types and exceptions (by providing an instance of the exception as in the example above.
## thenAnswer ##
Use ```thenAnswer``` in case you want to execute additional logic while providing the answer.  
Answers are provided by implementing the ```loli_mock_IAnswer``` interface e.g.

```java
public class MyAnswer implements loli_mock_IAnswer {

    public Object onInvocation(loli_mock_Invocation invocation) {
        // doSome stuff
        return 1;
    }
}

MyMock mock = new MyMock();
mock.when().invocation(mock.getInteger('Hello World', 0).thenAnswer(new MyAnswer());
// OR
((MyMock) mock.when().answerFor(new MyAnswer())).getInteger('Hello World', 0);
```
## Argument matchers
Instead of providing concrete arguments/parameters you can also use argument matchers. For example:

```java
mock.when().invocation(mock.getInteger(mock.anyString(), mock.anyInteger()).thenAnswer(1);
((MyMock) mock.when().answerFor(1)).getInteger(mock.anyString(), mock.anyInteger());
```
There are matchers for any simple types (Integer, String, Double and the like). For custom classes the ```anyObject``` can be leveraged by casting the response (again some apex limits).

```java
mock.when().invocation(mock.getInteger((String) mock.anyObject(), (Integer) mock.anyObject()).thenAnswer(1);
((MyMock) mock.when().answerFor(1)).getInteger((String) mock.anyObject(), (Integer) mock.anyObject());
```

In case a matcher is used all other arguments also need to be matchers. Therefore

```java
mock.when().invocation(mock.getInteger(mock.anyString(), 1).thenAnswer(1);
((MyMock) mock.when().answerFor(1)).getInteger(mock.anyString(), 1);
```
leads to an exception.  
In such cases use the ```anyValue``` matcher (again casting the returned value is required)

```java
mock.when().invocation(mock.getInteger(mock.anyString(), (Integer) mock.anyValue(1)).thenAnswer(1);
((MyMock) mock.when().answerFor(1)).getInteger(mock.anyString(), (Integer) mock.anyValue(1));
```
### Custom matchers ###
By implementing the ```loli_mock_IMatcher``` interface you can provide your own matcher implementation.

```java
public class MyMatcher implements loli_mock_IMatcher {

    public Boolean matches(Object compare) {
        // Matcher logic goes here
        return true;
    }
}

MyMock mock = new MyMock();
mock.when().invocation(mock.getInteger(mock.matcher(new MyMatcher()), mock.anyInteger()).thenReturn(new TestException());
((MyMock) mock.when().answerFor(1)).getInteger(mock.matcher(new MyMatcher()), mock.anyInteger());
```

# Verifying #
As for stubbing two alternatives for verifying behaviour

```java
mock.verify().that(mock.getInteger('Hello World', 1)).called(1);
((MyMock) mock.verify().expectationFor(loli_mock_Expectation.called(1))).getInteger('Hello World', 1);
```
*Again: The first option does not work for methods returning void*

## Verifying called, atMost, atLeast ##
You can verify the exact number of invocations, at least and at most.

### Exact number ###

```java
mock.verify().that(mock.getInteger('Hello World', 1)).called(1);
((MyMock) mock.verify().expectationFor(loli_mock_Expectation.called(1))).getInteger('Hello World', 1);
```
### At most ###
```java
mock.verify().that(mock.getInteger('Hello World', 1)).atMost(1);
((MyMock) mock.verify().expectationFor(loli_mock_Expectation.atMost(1))).getInteger('Hello World', 1);
```
### At least ###
```java
mock.verify().that(mock.getInteger('Hello World', 1)).atLeast(1);
((MyMock) mock.verify().expectationFor(loli_mock_Expectation.atLeast(1))).getInteger('Hello World', 1);
```
# Other #
Mocking has not been tested for all apex objects/methods. Please feel free to report any bugs.