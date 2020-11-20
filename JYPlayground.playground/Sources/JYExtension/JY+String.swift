//
//  JY+String.swift
//  TelegramUI
//
//  Created by 黄国坚 on 2019/9/29.
//  Copyright © 2019 Telegram. All rights reserved.
//

import Foundation
import CommonCrypto

//MARK: - 字符串加密相关
extension JY where Base == String {

    /// 字符串的md5属性
    public var md5: String {
        
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// base64编码
    public func base64Encoding() -> String {
        let plainData = base.data(using: .utf8)
        let base64String = plainData?.base64EncodedString()
        return base64String!
    }
    /// base64解码
   public func base64Decoding() -> String {
    
        let decodedData = Data(base64Encoded: base)
        let decodedString = String(data: decodedData!, encoding: .utf8)
        return decodedString!
    }
    ///
    public func base64Data() -> [UInt8] {
        
        return [UInt8](Data(base64Encoded: base)!)
    }
    
    // 签名
    public func signatureStr() -> String {
        let sign = self.md5

        let firstIndex = sign.index(sign.startIndex, offsetBy: 4)
        //1.只要0到34下标的字段 2.从下标4开始拿
        let signature = String(String(sign.prefix(35))[firstIndex...])
        let signatureUp = signature.uppercased()
        return signatureUp
    }
    
    /// 密码相关加密
    public func encryptStr(_ type: EncryptEnum) -> String {
        let sign = self.md5.uppercased()
        
        let range = type.range()
        
        let startIndex: String.Index = sign.index(sign.startIndex, offsetBy: range.start)
        let endIndex: String.Index = sign.index(sign.startIndex, offsetBy: range.end)
        
        let newSign = sign[startIndex...endIndex]
       
        return String(newSign)
    }
    
    ///密码相关的加密方式枚举
    public enum EncryptEnum{
        ///支付密码 5到12位
        case payPwd
        ///手势密码 6到12(现在也用于登录密码)
        case gesturesPwd
        
        func range() -> (start: Int, end: Int){
            switch self{
            case .payPwd:
                return (5, 12)
            case .gesturesPwd:
                return (6, 12)
            }
        }
    }
}

//MARK: - 数字/金额格式显示相关
extension JY where Base == String {
    
    ///金额转换显示
    /// - Parameters:
    ///   - style: 金额显示样式，默认 .currency ,即带逗号，例： 1,234
    ///   - symbol: 显示金额符号 默认为空
    ///   - minimumIntegerDigits: 最小整数位数 默认1
    ///   - maximumIntegerDigits: 最大整数位数 默认99
    ///   - minimumFractionDigits: 最小小数位数 默认 0
    ///   - maximumFractionDigits: 最大小数位数 默认 8
    ///   - roundingMode: 取舍原则，默认.down向下取舍
    /// - Returns: 金额转换后的字符串
    public func numberStyle(_ style: NumberFormatter.Style = .currency,
                            symbol: String = "",
                            minimumIntegerDigits: Int = 1,
                            maximumIntegerDigits: Int = 99,
                            minimumFractionDigits: Int = 0,
                            maximumFractionDigits: Int = 8,
                            roundingMode: NumberFormatter.RoundingMode = .down) -> String{
        
        
        return NSDecimalNumber(string: self.base).jy.style(style,
                                                           symbol: symbol,
                                                           minimumIntegerDigits: minimumIntegerDigits,
                                                           maximumIntegerDigits: maximumIntegerDigits,
                                                           minimumFractionDigits: minimumFractionDigits,
                                                           maximumFractionDigits: maximumFractionDigits,
                                                           roundingMode: roundingMode)
    }
}
