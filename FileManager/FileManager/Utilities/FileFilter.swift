//
//  FileFilter.swift
//  FileManager
//
//  Created by Xushan on 11/11/21.
//

import Foundation

enum FilterType {
    case TEXT
    case PDF
    case AUDIO
    case VEDIO
    case IMAGE
    case DOC
    case PPT
    case EXCEL
}

class FileFilter {
    //static var reloadDelegate: FilterDelegate?
    
    private init() {
    }

    static func filtering(fileInfos:[FileInfo],predicate: FilterType)-> ([FileInfo]) {
        var files = [File]()
        for fileInfo in fileInfos{
            if fileInfo.infoType == InfoType.FILE{
                let f = fileInfo as! File
                files.append(f)
            }
        }
        switch predicate {
        case .IMAGE:
            return filterByImage(files: files)
        case .AUDIO:
            return filterByAudio(files: files)
        case .VEDIO:
            return filterByvideo(files: files)
        case .DOC:
            return filterBydoc(files: files)
        case .PPT:
            return filterByppt(files: files)
        case .EXCEL:
            return filterByexcel(files: files)
        case .PDF:
            return filterByPdf(files: files)
        case .TEXT:
            return filterBytext(files: files)
        }
    }
    static func filterByImage(files: [File])-> ([FileInfo]){
        var fileInfolist = [FileInfo]()
        for file in files {
            if file.fileType == FileType.IMAGE{
                let info = file as FileInfo
                fileInfolist.append(info)
            }
        }
        return fileInfolist
}
    static func filterByAudio(files: [File])-> ([FileInfo]) {
        var fileInfolist = [FileInfo]()
        for file in files {
            if file.fileType == FileType.IMAGE{
                let info = file as FileInfo
                fileInfolist.append(info)
            }
        
        }
        return fileInfolist
}
    static func filterByPdf(files: [File])-> ([FileInfo]) {
        //print(1)
        var fileInfolist = [FileInfo]()
        for file in files {
            if file.fileType == FileType.PDF{
                let info = file as FileInfo
                fileInfolist.append(info)
            }
        }
        print(fileInfolist)
        return fileInfolist
}
    static func filterByvideo(files: [File])-> ([FileInfo]) {
        var fileInfolist = [FileInfo]()
        for file in files {
            if file.fileType == FileType.VEDIO{
                let info = file as FileInfo
                fileInfolist.append(info)
            }
        }
        print(fileInfolist)
        return fileInfolist
    }
        static func filterBydoc(files: [File])-> ([FileInfo]) {
            var fileInfolist = [FileInfo]()
            for file in files {
                if file.fileType == FileType.DOC{
                    let info = file as FileInfo
                    fileInfolist.append(info)
                }
            }
            print(fileInfolist)
            return fileInfolist
    }
        
        static func filterByppt(files: [File])-> ([FileInfo]) {
            var fileInfolist = [FileInfo]()
            for file in files {
                if file.fileType == FileType.PPT{
                    let info = file as FileInfo
                    fileInfolist.append(info)
                }
            }
            print(fileInfolist)
            return fileInfolist
    }
        
        static func filterByexcel(files: [File])-> ([FileInfo]) {
            var fileInfolist = [FileInfo]()
            for file in files {
                if file.fileType == FileType.EXCEL{
                    let info = file as FileInfo
                    fileInfolist.append(info)
                }
            }
            print(fileInfolist)
            return fileInfolist
    }
        
        static func filterBytext(files: [File])-> ([FileInfo]) {
            var fileInfolist = [FileInfo]()
            for file in files {
                if file.fileType == FileType.TEXT{
                    let info = file as FileInfo
                    fileInfolist.append(info)
                }
            }
            print(fileInfolist)
            return fileInfolist
    }
}

