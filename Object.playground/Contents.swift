//: Playground - noun: a place where people can play

class Object {
    var f: [String: (Any?) -> Any?] = [:]
    var v: [String: Any?] = [:]
    func f(_ named: String) -> (Any?) -> Any? {
        guard let function = f[named] else {
            return { _ in nil }
        }
        return function
    }
    func v(_ named: String) -> Any? {
        return v[named] ?? nil
    }
    func uv(_ named: String) -> Any {
        return v(named) ?? false
    }
    func v<E>(_ named: String, ofType: E) -> E? {
        guard let value = v(named) as? E else {
            return nil
        }
        return value
    }
    func av(_ named: String, value: Any) {
        v[named] = value
    }
    func af(named: String, value: @escaping (Any?) -> Any?) {
        f[named] = value
    }
    func rf(named: String, value: Any? = nil) -> Any? {
        return f(named)(value)
    }
}

func objExample() -> Object {
    let obj = Object()
    //Setting values
    obj.v["abc"] = "How are you"
    obj.v["pi"] = 3.14
    obj.f["nothing"] = { _ in
        return 1
    }
    return obj
}

let obj = objExample()

obj.v["pre"] = "LOG:"
obj.v["sum"] = 0
obj.f["print"] = { str in 
    return print("\(obj.uv("pre")) \(str ?? "")") 
}
obj.f["incBy"] = { toAdd in
    guard let sum = obj.v("sum") as? Int,
        let inc = toAdd as? Int else {
        return nil
    }
    return obj.v["sum"] = sum + inc
}

let prin = obj.f("print")
prin("gdsg")

let add = obj.f("incBy")
add(3)
add(1)
prin(obj.v("sum"))

prin(obj.v("pi"))
prin(obj.v("pi", ofType: Float.self))
