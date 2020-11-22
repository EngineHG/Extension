//
//  JY+DefaultValue.swift
//  使用 Property Wrapper 为 Codable 解码设定默认值
//
//  特别鸣谢 喵神 https://onevcat.com/2020/11/codable-default/
//  Created by CodeMan on 2020/9/23.
//

import UIKit

public protocol DefaultValue {
    associatedtype Value: Codable
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Default<T: DefaultValue> {
    public var wrappedValue: T.Value
    public init(){
        self.wrappedValue = T.defaultValue
    }
}

extension Default: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.Value.self)) ?? T.defaultValue
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default()
    }
}

//MARK: - 以下是定义的一些 DefaultValue
extension Bool{
    public enum False: DefaultValue {
        public static let defaultValue = false
    }
    public enum True: DefaultValue {
        public static let defaultValue = true
    }
}

extension String{
    public enum Empty: DefaultValue {
        public static let defaultValue = ""
    }
    public enum Zero: DefaultValue {
        public static let defaultValue = "0"
    }
}

extension Int{
    public enum Zero: DefaultValue {
        public static let defaultValue = 0
    }
}
extension Double{
    public enum Zero: DefaultValue {
        public static let defaultValue = 0
    }
}

