import UIKit

/// Attempt to make a simple JavaScript-like Object in Swift
class Object {
    typealias ObjectFunction = (Any?) -> Any?
    typealias ObjectVariable = Any
    /// Functions of the object
    var f: [String: ObjectFunction] = [:]
    /// Variables of the object
    var v: [String: ObjectVariable] = [:]
    /// Retrieve a Function from the current object
    func f(_ named: String) -> ObjectFunction {
        guard let function = f[named] else {
            return { _ in NSNull() }
        }
        return function
    }
    /// Retrieve a Value from the current object
    func v(_ named: String) -> ObjectVariable {
        return unwrap(value: v[named] ?? NSNull())
    }
    /// Add a Value with a name to the current object
    func av(_ named: String, value: ObjectVariable) {
        v[named] = value
    }
    /// Add a Function with a name and a closure to the current object
    func af(named: String, value: @escaping ObjectFunction) {
        f[named] = value
    }
    /// Run a Function with or without a value
    func rf(named: String, value: ObjectVariable = NSNull()) -> ObjectVariable? {
        return f(named)(value)
    }
    ///Run a Function with a internal value
    func rf(named: String, withInteralValueName iValueName: String) -> ObjectVariable? {
        return f(named)(v(iValueName))
    }
    /// Unwraps the <Optional> Any type
    private func unwrap(value: ObjectVariable) -> ObjectVariable {
        let mValue = Mirror(reflecting: value)
        let isValueOptional = mValue.displayStyle != .optional
        let isValueEmpty = mValue.children.isEmpty
        if isValueOptional { return value }
        if isValueEmpty { return NSNull() }
        guard let (_, unwrappedValue) = mValue.children.first else { return NSNull() }
        return unwrappedValue
    }
}


var obj = Object()
obj.v["qwerty"] = 12456
obj.f["printy"] = { input in
    print("[[{ \(input) }]]")
    return "{ \(input) }"
}


obj.rf(named: "printy", value: obj.v("qwerty"))
obj.rf(named: "printy", withInteralValueName: "qwerty")
