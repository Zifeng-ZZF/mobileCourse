//
//  File.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation
import UIKit

class File : FileInfo {
    var fileType: FileType = .OTHER
    var ext: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case fileType
        case ext
    }
    
    override init() {
        super.init()
    }
    
    init(name: String, url: String?, createDate: Date, ext: String) {
        super.init(name: name, url: url, createDate: createDate, type: .FILE)
        self.ext = ext
        self.iconImage = (UIImage(named: "OTHER")?.getBase64EncodingStringPNG())!
    }
    
    convenience init(name: String, url: String?, createDate: Date, type: FileType, ext: String) {
        self.init(name: name, url: url, createDate: createDate, ext: ext)
        self.fileType = type
        switch type {
        case .IMAGE:
            self.iconImage = (UIImage(named: "IMAGE")?.getBase64EncodingStringPNG())!
        case .TEXT:
            self.iconImage = (UIImage(named: "TXT")?.getBase64EncodingStringPNG())!
        case .PDF:
            self.iconImage = (UIImage(named: "PDF")?.getBase64EncodingStringPNG())!
        case .AUDIO:
            self.iconImage = (UIImage(named: "MP3")?.getBase64EncodingStringPNG())!
        case .VEDIO:
            self.iconImage = (UIImage(named: "MP4")?.getBase64EncodingStringPNG())!
        case .PPT:
            self.iconImage = (UIImage(named: "PPT")?.getBase64EncodingStringPNG())!
        case .DOC:
            self.iconImage = (UIImage(named: "DOC")?.getBase64EncodingStringPNG())!
        case .EXCEL:
            self.iconImage = (UIImage(named: "EXCEL")?.getBase64EncodingStringPNG())!
        default:
            self.iconImage = (UIImage(named: "OTHER")?.getBase64EncodingStringPNG())!
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let superdecoder = try container.superDecoder()
        fileType = try container.decode(FileType.self, forKey: .fileType)
        ext = try container.decode(String.self, forKey: .ext)
        try super.init(from: decoder) // encode super class
    }
    
    override func encode(to encoder: Encoder) throws {
        // has to pass current encode into super
        // otherwise, super will be encoded into its own container
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileType, forKey: .fileType)
        try container.encode(ext, forKey: .ext)    
    }
}
