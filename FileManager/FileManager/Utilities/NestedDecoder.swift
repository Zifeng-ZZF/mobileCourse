//
//  NestedDecoder.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/11/9.
//

import Foundation

//enum ObjectType: String, Codable {
//    case file
//    case directory
//}

struct NestedDecoder: Codable {
    let elements: [FileInfo]

    enum CodingKeys: CodingKey {
        case elements
    }

    enum ObjectTypeKey: CodingKey {
        case infoType
    }

    init(with objects: [FileInfo]) {
        self.elements = objects
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var nestUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: CodingKeys.elements)
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
        self.elements = items
    }
}
