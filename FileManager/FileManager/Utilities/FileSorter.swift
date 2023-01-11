//
//  FileSorter.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/11/5.
//

import Foundation

// type of predicate to sort the files
enum SortingType {
    case CREATE_DATE
    case NAME
    case FILE_TYPE
}

class FileSorter {
    // singleton setup
    static let shared = FileSorter()
    
    private init() {
    }
    
    /// sort the given list of fileInfo based on given predicate
    /// sorting is done in ascending order
    /// - Parameters:
    ///     fileInfos: is reference of the given fileInfos
    ///     predicate: specify sorting type
    func sort(fileInfos: inout [FileInfo], predicate: SortingType) {
        switch predicate {
        case .FILE_TYPE:
            sortByFileType(fileInfos: &fileInfos)
        case .NAME:
            fileInfos.sort { (a, b) -> Bool in
                return a.name.lowercased() < b.name.lowercased()
            }
        case .CREATE_DATE:
            fileInfos.sort { (a, b) -> Bool in
                return Date.customToDate(str: a.createDate) < Date.customToDate(str: b.createDate)
            }
        }
    }
    
    /// sort the given list of fileInfo based file types
    /// - Parameters:
    ///     fileInfos: is reference of the given fileInfos
    func sortByFileType(fileInfos: inout [FileInfo]) {
        var directoryInfos: [Directory] = []
        var files: [File] = []
        var sortedList: [FileInfo] = []
        // partitioning different types
        for info in fileInfos {
            if info.infoType == .DIRECTORY {
                directoryInfos.append(info as! Directory)
            }
            else {
                files.append(info as! File)
            }
        }
        directoryInfos.sort { (a,b) -> Bool in
            return a.name < b.name
        }
        files.sort { (a, b) -> Bool in
            return a.fileType.rawValue < b.fileType.rawValue
        }
        // merging into a list
        for dir in directoryInfos {
            sortedList.append(dir)
        }
        for file in files {
            sortedList.append(file)
        }
        fileInfos = sortedList
    }
}
