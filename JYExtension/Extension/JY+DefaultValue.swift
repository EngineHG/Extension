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
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension Default: Equatable where T.Value: Equatable { }
extension Default: Hashable where T.Value: Hashable { }


extension KeyedDecodingContainer {
    public func decode<T>(_ type: Default<T>.Type, forKey key: Key) throws -> Default<T> where T: DefaultValue {
        try decodeIfPresent(type, forKey: key) ?? Default()
    }
}

//MARK: - 以下是定义的一些 DefaultValue


///空数组
///
/// 声明方式
///
///     @Default<EmptyAry<T>>
public struct EmptyAry<T>: DefaultValue where T: Codable{
    public static var defaultValue: [T]{
        return []
    }
}

extension Bool{
    public enum False: DefaultValue {
        public static let defaultValue: Bool = false
    }
    public enum True: DefaultValue {
        public static let defaultValue: Bool = true
    }
}

extension String{
    public enum Empty: DefaultValue {
        public static let defaultValue: String = ""
    }
    public enum Zero: DefaultValue {
        public static let defaultValue: String = "0"
    }
}

extension Int{
    public enum Zero: DefaultValue {
        public static let defaultValue: Int = 0
    }
}
extension Double{
    public enum Zero: DefaultValue {
        public static let defaultValue: Double = 0
    }
}

