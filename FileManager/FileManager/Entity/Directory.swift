//
//  Directory.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation
import UIKit

class Directory : FileInfo {
    var children: [FileInfo] = []
    
    private enum CodingKeys: String, CodingKey {
        case children
    }
    
    enum ObjectTypeKey: CodingKey {
        case infoType
    }
    
    override init() {
        super.init()
    }
    
    init(name: String, createDate: Date) {
        super.init(name: name, createDate: createDate, type: .DIRECTORY)
        self.iconImage = (UIImage(named: "FOLDER")?.getBase64EncodingStringPNG())!
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try super.init(from: decoder)
        // decoding children based on their types
        var nestUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.children)
        var items = [FileInfo]()
        var fileArray = nestUnkeyedContainer
        while !nestUnkeyedContainer.isAtEnd {
            let nestContainer = try nestUnkeyedContainer.nestedContainer(keyedBy: ObjectTypeKey.self)
            let type = try nestContainer.decode(InfoType.self, forKey: ObjectTypeKey.infoType)
            switch type {
            case .FILE:
                items.append(try fileArray.decode(File.self))
            case .DIRECTORY:
                items.append(try fileArray.decode(Directory.self))
            case .OTHER:
                items.append(try fileArray.decode(FileInfo.self))
            }
        }
        self.children = items
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(children, forKey: .children)
        // has to pass current encode into super
        // otherwise, super will be encoded into its own container
        try super.encode(to: encoder)
    }
    
    func appendChild(child: FileInfo) {
        children.append(child)
    }
}
