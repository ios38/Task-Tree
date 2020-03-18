import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

struct User: Decodable {
    var name: String
    var age: Int
    var isDeveloper: Bool
}

struct UserData​: Decodable {
    let data: [User]
}

struct UserResult: Decodable {
    let result: [User]
}

protocol Parser {
    var next: Parser? { get set }
    func parse(_ data: Data) -> [User]?
}

class DataParser: Parser {
    var next: Parser?
    
    func parse(_ data: Data) -> [User]? {
        if let users = try? JSONDecoder().decode(UserData​.self, from: data).data, users.count > 0 {
            print("Data parsing completed")
            return users
        }
        else {
            return next?.parse(data)
        }
    }
}

class ResultParser: Parser {
    var next: Parser?
    
    func parse(_ data: Data) -> [User]? {
        if let users = try? JSONDecoder().decode(UserResult.self, from: data).result, users.count > 0 {
            print("Result parsing completed")
            return users
        }
        else {
            return next?.parse(data)
        }
    }
}

class ArrayParser: Parser {
    var next: Parser?
    
    func parse(_ data: Data) -> [User]? {
        if let users = try? JSONDecoder().decode([User].self, from: data), users.count > 0 {
            print("Array parsing completed")
            return users
        }
        else {
            return next?.parse(data)
        }
    }
}


let dataParser = DataParser()
let resultParser = ResultParser()
let arrayParser = ArrayParser()

dataParser.next = resultParser
resultParser.next = arrayParser
arrayParser.next = dataParser

let jsonData = [data1, data2, data3]
jsonData.forEach {
    print("User count: \(dataParser.parse($0)?.count ?? 0) \n")
}
