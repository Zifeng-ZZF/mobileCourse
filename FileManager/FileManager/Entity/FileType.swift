//
//  FileType.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation

enum FileType: String, Codable {
    case TEXT
    case PDF
    case AUDIO
    case VEDIO
    case IMAGE
    case DOC
    case PPT
    case EXCEL
    case OTHER
    
    static func parse(s:String) -> FileType {
            switch s {
                case "text" : return .TEXT
                case "pdf" : return .PDF
                case "doc" : return .DOC
                case "docx" : return .DOC
                case "xlsx" :return .EXCEL
                case "pptx" : return .PPT
                case "ppt" : return .PPT
                case "txt" : return .TEXT
                case "png": return .IMAGE
                case "jpeg": return .IMAGE
                case "jpg": return .IMAGE
                case "mp3": return .AUDIO
                case "mp4": return .VEDIO
                case "avi": return .VEDIO
                case "mov": return .VEDIO
                case "flv": return .VEDIO
                default: return .OTHER
            }
        }
}
