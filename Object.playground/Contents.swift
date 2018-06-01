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

obj.v["toPrint"] = "Hello World!"
obj.f["print"] = { _ in return print(obj.v("toPrint")) }

obj.f("print")(nil)
