//
//  InfoType.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation

enum InfoType: String, Codable {
    case FILE = "FILE"
    case DIRECTORY = "DIRECTORY"
    case OTHER = "OTHER"
}
