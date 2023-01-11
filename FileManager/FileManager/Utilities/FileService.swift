//
//  FileService.swift
//  FileManager
//
//  Responsible for IO service & primary data structure manipulation
//
//  Created by Zifeng Zhang on 2021/10/24.
//

import Foundation

class FileService {
    // only instance of the singleton class
    static let shared = FileService()
    
    // URL to app file spaces
    static let documentsDir: URL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // URL to store file infos
    static let rootURL: URL = documentsDir.appendingPathComponent("root")
    
    // URL to store box files
    static let archiveURL: URL = documentsDir.appendingPathComponent("files")
    
    // reference to the root/first directory
    var rootDirectory: Directory?
    
    // current directory displayed
    var currentDirectory: Directory?
    
    // for navigating directories logically
    var dirStack: [Directory] = []
    
    private init() {
    }
    
    /// Load either initial data from disk or create initial data and write to disk
    public func loadData() {
        if currentDirectory != nil {
            return
        }
        if let existingData = loadInitData() {
            print("Found previous data.. loading")
            rootDirectory = existingData
        } else {
            print("Currently no data.. creating dummy data")
            initData()
            writeToDisk()
        }
        currentDirectory = rootDirectory
        dirStack.append(rootDirectory!)
    }
    
    /// Try to load initial data
    /// - Returns: root directory or nil if there is no data
    func loadInitData() -> Directory? {
        // read data
        let decoder = JSONDecoder()
        let existData: Data
        do {
            try existData = Data(contentsOf: FileService.rootURL)
        } catch let err as NSError {
            print("loadData url:" + err.description)
            return nil
        }
        // decoding
        do {
            let decoded = try decoder.decode(Directory.self, from: existData)
            return decoded
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
            return nil
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            return nil
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    /// write a new fileInfo into current directory
    /// then write the tree into disk
    /// - Parameters:
    ///     fileInfo: to be added into current directory
    func write(fileInfo: FileInfo) {
        currentDirectory?.children.append(fileInfo)
        writeToDisk()
    }
    
    /// Write the whole fileInfo tree into disk
    func writeToDisk() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(rootDirectory) {
            if nil != String(data: encoded, encoding: .utf8) {
                do {
                    try encoded.write(to: FileService.rootURL)
                } catch let err as NSError {
                    print("Writing error: " + err.description)
                }
            } else {
                print("JSon parsed failed on writing to disk")
            }
        } else {
            print("Encode failed")
        }
    }
    
    /// Find a directory with the given name in the current directory
    /// - Parameters:
    ///     name: a string indicate the name of the directory under the current directory
    /// - Returns:
    ///     the direcotry with the specified name, or nil if there is none
    func readDirectory(name: String) -> Directory? {
        if currentDirectory?.name == name {
            return currentDirectory
        }
        let files = currentDirectory!.children
        for fileInfo in files {
            if fileInfo.name == name && fileInfo.infoType == .DIRECTORY {
                currentDirectory = (fileInfo as! Directory)
                print("current is \(currentDirectory!.name)")
                dirStack.append(currentDirectory!)
                return currentDirectory
            }
        }
        return nil
    }
    
    /// check whether a directory with the same name in the directory already exist
    /// - Parameters:
    ///     proposed: a string indicate the name of the file/directory to check
    func checkFolderNameExist(proposed: String) -> Bool {
        let files = currentDirectory!.children
        for fileInfo in files {
            if fileInfo.name == proposed && fileInfo.infoType == .DIRECTORY {
                return true
            }
        }
        return false
    }
    
    /// Logically go back to previous directory
    func goBack() {
        if dirStack.isEmpty || dirStack.last == rootDirectory {
            return
        }
        if let last = dirStack.popLast() {
            currentDirectory = dirStack.last
        }
    }
    
    /// remove a fileInfo from the current directory then write tree to disk
    /// - Parameters:
    ///     fileInfo: to be removed
    func removeFileInfo(fileInfo: FileInfo) {
        var idx = 0
        if let infos = currentDirectory?.children {
            for info in infos {
                if info == fileInfo {
                    currentDirectory?.children.remove(at: idx)
                    writeToDisk()
                    return
                }
                idx += 1
            }
        }
    }
    
    /// If there is no data, write some initial directories
    func initData() {
        let currDate = Date()
        let rootDir = Directory(name: "root", createDate: currDate)
        let myDocDir = Directory(name: "MyDocument", createDate: currDate)
        let myFavDir = Directory(name: "MyFavorite", createDate: currDate)
        let myTxtDir = Directory(name: "TextFiles", createDate: currDate)
        
        let fileName = "Hello"
        let ext = ".txt"
        if let fileURL = createAndWriteFile(fileName: fileName + ext) {
            let myTxtFile = File(name: fileName, url: fileURL.path, createDate: Date(), type: .TEXT, ext: ext)
            rootDir.appendChild(child: myTxtFile)
        }

        myDocDir.appendChild(child: myTxtDir)
        rootDir.appendChild(child: myFavDir)
        rootDir.appendChild(child: myDocDir)
        self.rootDirectory = rootDir
    }
    
    /// Manually creating text file
    /// - Parameters: fileName
    /// - Returns: the url the file written to
    public func createAndWriteFile(fileName: String) -> URL? {
        if !FileManager.default.fileExists(atPath: FileService.archiveURL.absoluteString) {
            try! FileManager.default.createDirectory(at: FileService.archiveURL, withIntermediateDirectories: true, attributes: nil)
        }
        let fileUrl = FileService.archiveURL.appendingPathComponent(fileName)
        let stringData = "Hello World"
        do {
            try stringData.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print (error)
            return nil
        }
        return fileUrl
    }
    
    /// Find all the fileInfo having the same name
    /// - Parameters: name of  the looked up fileInfo
    /// - Returns: a list of fileInfo with the same name
    func getFileInfosWithSameName(name: String) -> [FileInfo] {
        var results: [FileInfo] = []
        var queue: [FileInfo] = []
        queue.append(rootDirectory!)
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            if cur.name.lowercased().contains(name.lowercased()) {
                results.append(cur)
            }
            if cur.infoType == .DIRECTORY {
                let dir = cur as! Directory
                for fileInfo in dir.children {
                    queue.append(fileInfo)
                }
            }
        }
        return results
    }
}
