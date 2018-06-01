//: Playground - noun: a place where people can play

struct Object {
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
}

func objExample() -> Object {
    var obj = Object()
    //Setting values
    obj.v["abc"] = "How are you"
    obj.v["pi"] = 3.14
    obj.f["nothing"] = { _ in
        return 1
    }
    return obj
}

var obj = objExample()

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

let print = obj.f("print")
print("gdsg")

let add = obj.f("incBy")
add(3)
add(1)
print(obj.v("sum"))

print(obj.v("pi"))
print(obj.v("pi", ofType: Float.self))