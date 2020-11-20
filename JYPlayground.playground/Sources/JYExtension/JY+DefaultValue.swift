//
//  JY+DefaultValue.swift
//  使用 Property Wrapper 为 Codable 解码设定默认值
//
//  特别鸣谢 喵神 https://onevcat.com/2020/11/codable-default/
//  Created by CodeMan on 2020/9/23.
//

import UIKit

protocol DefaultValue {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

@propertyWrapper
struct Default<T: DefaultValue> {
    var wrappedValue: T.Value
}

extension Default: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension KeyedDecodingContainer {
    func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

//MARK: - 以下是定义的一些 DefaultValue
extension Bool{
    enum Flase: DefaultValue {
        static let defaultValue = false
    }
    enum True: DefaultValue {
        static let defaultValue = true
    }
}

extension String{
    enum Empty: DefaultValue {
        static let defaultValue = ""
    }
    enum Zero {
        static let defaultValue = "0"
    }
}

extension Int{
    enum Zero {
        static let defaultValue = 0
    }
}
extension Double{
    enum Zero {
        static let defaultValue = 0
    }
}

