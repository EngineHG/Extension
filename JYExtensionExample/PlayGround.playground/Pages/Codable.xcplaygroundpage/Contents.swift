// Codable使用参考
// 特别鸣谢喵神 https://onevcat.com/2020/11/codable-default/

import UIKit
import Extension

struct Video: Decodable {
    
    //类似State这种情况所产生的两种方案（枚举&RawRepresentable）
    enum StateEnum: String, Codable, DefaultValue {
        case streaming
        case archived
        case unknown
        static let defaultValue = Video.StateEnum.unknown
    }
    struct StateStruct: RawRepresentable, Codable, Equatable, DefaultValue  {
        let rawValue: String
        static let streaming = StateStruct(rawValue: "streaming")
        static let archived = StateStruct(rawValue: "archived")
        static let unknown = StateStruct(rawValue: "unknown")
        
        static let defaultValue = unknown
    }
    
    let id: Int
    let title: String
    @Default<Bool.False> var commentEnabled: Bool
    @Default<Bool.True> var publicVideo: Bool
    @Default<StateEnum> var stateEnum: StateEnum
    @Default<StateStruct> var stateStruct: StateStruct
}


let json: String = #"{"id": 12345, "title": "My First Video", "state": "reserved"}"#
let videoModel: Video = json.jy.toModel(Video.self)!

print(videoModel)
print(videoModel.stateEnum)
print(videoModel.stateStruct)
