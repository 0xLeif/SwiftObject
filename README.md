# SwiftObject


### Example
```
var obj = Object()

// Set variables and functions
obj.v["pre"] = "LOG:"
obj.v["sum"] = 0
obj.v["pi"] = 3.14
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

// Use functions
let print = obj.f("print")
print("gdsg")

let add = obj.f("incBy")
add(3)
add(1)
print(obj.v("sum"))

print(obj.v("pi"))
print(obj.v("pi", ofType: Float.self))
```
