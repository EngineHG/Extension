//
//  JY+NSNumber.swift
//
//  Created by CodeMan on 2020/9/23.
//

import UIKit

extension NSNumber: JYNameSpace{}

//MARK: - 数字/金额格式显示相关
extension JY where Base: NSNumber{
    
    ///金额转换显示
    /// - Parameters:
    ///   - style: 金额显示样式，默认 .currency ,即带逗号，例： 1,234
    ///   - ymbol: 显示金额符号 默认为空
    ///   - minimumIntegerDigits: 最小整数位数 默认1
    ///   - maximumIntegerDigits: 最大整数位数 默认99
    ///   - minimumFractionDigits: 最小小数位数 默认 0
    ///   - maximumFractionDigits: 最大小数位数 默认 8
    ///   - roundingMode： 取舍原则，默认.down向下取舍
    /// - Returns: 金额转换后的字符串
    public func style(_ style: NumberFormatter.Style = .currency,
                      symbol: String = "",
                      minimumIntegerDigits: Int = 1,
                      maximumIntegerDigits: Int = 99,
                      minimumFractionDigits: Int = 0,
                      maximumFractionDigits: Int = 8,
                      roundingMode: NumberFormatter.RoundingMode = .down) -> String{
        
        
        let format = NumberFormatter()
        format.numberStyle = style
        format.currencySymbol = symbol
        format.minimumIntegerDigits = minimumIntegerDigits
        format.maximumIntegerDigits = maximumIntegerDigits
        format.minimumFractionDigits = minimumFractionDigits
        format.maximumFractionDigits = maximumFractionDigits
        format.roundingMode = roundingMode
        
        return format.string(from: self.base) ?? "0"
    }
}
