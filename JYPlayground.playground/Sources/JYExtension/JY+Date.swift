//
//  JY+Date.swift
//
//  Created by CodeMan on 2019/9/29.
//  Copyright © 2019 Telegram. All rights reserved.
//

import Foundation

// 时间格式
public enum DateFormatType: String {
    ///yyyy-MM-dd HH:mm:ss
    case allDateType1 = "yyyy-MM-dd HH:mm:ss"
    ///yyyy:MM:dd HH:mm:ss
    case allDateType2 = "yyyy:MM:dd HH:mm:ss"
    ///yyyy年MM月dd日 HH:mm:ss
    case allDateType3 = "yyyy年MM月dd日 HH:mm:ss"
    ///yyyy年MM月dd HH:mm:ss
    case allDateType4 = "yyyy年MM月dd HH:mm:ss"
    ///HH:mm:ss
    case allDateType5 = "HH:mm:ss"
    ///HH:mm
    case allDateType6 = "HH:mm"
    ///HH时mm分 MM月dd日
    case expectHourType1 = "HH:mm MM-dd"
    ///HH:mm
    case allDateType7 = "yyyyMMddHHmmss"
    ///yyyy-MM-dd HH:mm
    case expectSecondType1 = "yyyy-MM-dd HH:mm"
    ///yyyy:MM:dd HH:mm
    case expectSecondType2 = "yyyy:MM:dd HH:mm"
    ///yyyy年MM月dd日 HH:mm
    case expectSecondType3 = "yyyy年MM月dd日 HH:mm"
    ///yyyy年MM月dd HH:mm
    case expectSecondType4 = "yyyy年MM月dd HH:mm"
    ///yyyy-MM HH:mm
    case expectSecondType5 = "yyyy-MM HH:mm"
    ///MM-dd HH:mm
    case expectYearType1 = "MM-dd HH:mm"
    ///MM:dd HH:mm
    case expectYearType2 = "MM:dd HH:mm"
    ///MM月dd日 HH:mm
    case expectYearType3 = "MM月dd日 HH:mm"
    ///MM月dd HH:mm
    case expectYearType4 = "MM月dd HH:mm"
    ///yyyy-MM-dd
    case yyyy_MM_dd = "yyyy-MM-dd"
    ///yyy-MM
    case yyyy_MM = "yyy-MM"
    ///"HH:mm MM/dd"
    case HH_mm_Day = "HH:mm MM/dd"
}


extension JY where Base == Date{
	
	/// 获取当前时间
    public static func currentDateStr(dateFormat: DateFormatType) -> String {
		return Date().jy.toString(dateFormat : dateFormat)
    }
    
	/// Date转字符串
	public func toString(dateFormat: DateFormatType) -> String{
		let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue // 日期格式器
        return formatter.string(from: base)
	}
	
    /// 获取当前时间的时间戳
	public static var currentTimeStamp: String {
        let timeInterval = Date().timeIntervalSince1970
        return "\(timeInterval)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    public func milliStamp() -> String {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval * 1000))
        return "\(millisecond)"
    }
}
