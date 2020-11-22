//
//  JY+Codable.swift
//
//  Created by CodeMan on 2018/7/13.
//  Copyright © 2018年 JY. All rights reserved.
//

import Foundation

extension Encodable{
    /// Encodable 转字符串
    ///
    /// - Returns: json格式字符串
    public func toString() -> String{
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        do{
            let data = try JSONEncoder().encode(self)
            let str = String(data: data, encoding: .utf8)
            return str!
        }catch{
            debugPrint("\(self)转字符串失败,注意\(self)可能是可选类型")
            return ""
        }
    }
}

/**只适用于符合json格式的字符串*/
extension JY where Base == String {
    
    /// String转模型
	/// - Parameter type: 模型的类型，必须遵循Decodable
    public func toModel<T>(_ type: T.Type) -> T? where T : Decodable{
        
		if let data: Data = base.data(using: .utf8) {
			return data.jy.toModel(type)
        }else {
           return decodeFail(type)
        }
    }
    
    /// String转模型
	/// - Parameter type: 模型的类型，必须遵循Decodable
    public func toModelAry<T>(_ type: T.Type) -> [T]? where T : Decodable{
        
		return toModel([T].self)
    }
}


extension JY where Base == Data{
	
	/// jsonData转模型
	/// - Parameter type: 模型的类型，必须遵循Decodable
	public func toModel<T>(_ type: T.Type) -> T? where T : Decodable{
		
		if let model: T = try? JSONDecoder().decode(T.self, from: base){
			
			return model
		}else {
			
            return decodeFail(type)
		}
	}
}

fileprivate extension JY {
	
	///json 解析失败debug提示
	func decodeFail<T>(_ type: T.Type) -> T? where T : Decodable {
		debugPrint("json字符串序列化 \(type) 失败")
        
        var errorStr: String = ""
        if let db = base as? Data{
            errorStr = String(data: db, encoding: .utf8) ?? ""
        }else if let str = base as? String {
            errorStr = str
        }
		debugPrint("""
            原字符串：
            \(errorStr)
            """)
		return nil
	}
}
