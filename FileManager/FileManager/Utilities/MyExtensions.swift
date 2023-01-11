//
//  MyExtensions.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/11/2.
//

import Foundation
import UIKit

extension URL {
    var uti: String {
        return (try? self.resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier ?? "public.data"
    }
}

extension UIImage {
    func getBase64EncodingStringPNG() -> String {
        let data = self.pngData()!
        return data.base64EncodedString()
    }
    
    func getBase64EncodingStringJPEG() -> String {
        let data = self.jpegData(compressionQuality: 1)!
        return data.base64EncodedString()
    }
    
    static func getDecodedBase64(base64: String) -> UIImage? {
        if let decoded = Data(base64Encoded: base64) {
            return UIImage(data: decoded)
        } else {
            return nil
        }
    }
}


extension Date {
    static func customToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: date)
    }
    
    static func customToDate(str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: str)!
    }
    
    static func customToPrintString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "HH:mm:ss MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}
extension URL {
    /// The time at which the resource was created.
    /// This key corresponds to an Date value, or nil if the volume doesn't support creation dates.
    /// A resource’s creationDateKey value should be less than or equal to the resource’s contentModificationDateKey and contentAccessDateKey values. Otherwise, the file system may change the creationDateKey to the lesser of those values.
    public var creation: Date? {
        get {
            return (try? resourceValues(forKeys: [.creationDateKey]))?.creationDate
        }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.creationDate = newValue
            try? setResourceValues(resourceValues)
        }
    }
    /// The time at which the resource was most recently modified.
    /// This key corresponds to an Date value, or nil if the volume doesn't support modification dates.
    var contentModification: Date? {
        get {
            return (try? resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
        }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.contentModificationDate = newValue
            try? setResourceValues(resourceValues)
        }
    }
    /// The time at which the resource was most recently accessed.
    /// This key corresponds to an Date value, or nil if the volume doesn't support access dates.
    ///  When you set the contentAccessDateKey for a resource, also set contentModificationDateKey in the same call to the setResourceValues(_:) method. Otherwise, the file system may set the contentAccessDateKey value to the current contentModificationDateKey value.
    var contentAccess: Date? {
        get {
            return (try? resourceValues(forKeys: [.contentAccessDateKey]))?.contentAccessDate
        }
        // Beginning in macOS 10.13, iOS 11, watchOS 4, tvOS 11, and later, contentAccessDateKey is read-write. Attempts to set a value for this file resource property on earlier systems are ignored.
        set {
            var resourceValues = URLResourceValues()
            resourceValues.contentAccessDate = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
