// This is an empty Ballerina object autogenerated to represent the `org.yaml.snakeyaml.constructor.BaseConstructor` Java class.
//
// If you need the implementation of this class generated, please use the following command.
//
// $ ballerina bindgen [(-cp|--classpath) <classpath>...] [(-o|--output) <output>] (<class-name>...)
//
// E.g. $ ballerina bindgen org.yaml.snakeyaml.constructor.BaseConstructor


import ballerina/java;

# Ballerina object mapping for Java abstract class `org.yaml.snakeyaml.constructor.BaseConstructor`.
#
# + _BaseConstructor - The field that represents this Ballerina object, which is used for Java subtyping.
# + _Object - The field that represents the superclass object `Object`.
@java:Binding {
    'class: "org.yaml.snakeyaml.constructor.BaseConstructor"
}
class BaseConstructor {

    *java:JObject;

    BaseConstructorT _BaseConstructor = BaseConstructorT;
    ObjectT _Object = ObjectT;

    # The init function of the Ballerina object mapping `org.yaml.snakeyaml.constructor.BaseConstructor` Java class.
    #
    # + obj - The `handle` value containing the Java reference of the object.
    function init(handle obj) {
        self.jObj = obj;
    }

    # The function to retrieve the string value of a Ballerina object mapping a Java class.
    #
    # + return - The `string` form of the object instance.
    function toString() returns string {
        return java:jObjToString(self.jObj);
    }
}


