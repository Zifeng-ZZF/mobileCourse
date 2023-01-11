//
//  FileInfo.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation
import UIKit

class FileInfo: NSObject, Codable {
    var name : String = ""
    var url : String = ""
    var createDate : String = ""
    var iconImage: String = ""
    var infoType: InfoType = .OTHER
    var boxId: String = ""

    override init() {
        super.init()
    }
    
    init(name: String, createDate: Date, type: InfoType) {
        self.name = name
        self.createDate = Date.customToString(date: createDate)
        self.infoType = type
    }
    
    init(name: String, url: String?, createDate: Date, type: InfoType) {
        self.name = name
        self.url = url ?? ""
        self.createDate = Date.customToString(date: createDate)
        self.infoType = type
    }
    
    override var description: String {
        var desc: String = ""
        desc.append("name: \(name)\n")
        desc.append("url: \(url)\n")
        desc.append("createDate: \(createDate.description)\n")
        let index = iconImage.index(iconImage.startIndex, offsetBy: 20)
        desc.append("iconImage: \(iconImage[..<index] )\n")
        desc.append("infoType: \(infoType.rawValue)\n")
        desc.append("boxId: \(boxId)\n")
        return desc
    }
}
