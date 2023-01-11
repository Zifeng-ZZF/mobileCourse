//
//  SourcesViewController.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class SourcesViewController: UIViewController, UIDocumentPickerDelegate {
    // delegate to reload tableView in MainView
    var reloadDelegate: MainViewDelegate?

    // MARK: Lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SourcesView()
        setUpActions()
    }
    
    /// setting up button actions
    private func setUpActions() {
        let srcView = self.view as! SourcesView
        srcView.cancelBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        srcView.fileAndICloudBtn.addTarget(self, action: #selector(startFileAndICloud), for: .touchUpInside)
        srcView.boxBtn.addTarget(self, action: #selector(startBox), for: .touchUpInside)
        srcView.createFolderBtn.addTarget(self, action: #selector(startCreateFolder), for: .touchUpInside)
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    /// Open icloud/files panel for adding file to the app
    @objc func startFileAndICloud() {
        let documentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)
        documentPickerViewController.delegate = self
        present(documentPickerViewController, animated: true) {}
    }
    
    // MARK: DocumentPicker functions
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let fileName = url.deletingPathExtension().lastPathComponent
        let fileExt = url.pathExtension
        let fileCreateDate = url.creation ?? Date()
        let fileType = FileType.parse(s: fileExt)
        let pickedDocument = File(name: fileName, url: url.path, createDate: fileCreateDate, type: fileType, ext: ".\(fileExt)")
        FileService.shared.write(fileInfo: pickedDocument)
        reloadDelegate?.reloadTable()
        self.dismiss(animated: true, completion: nil)
    }

    /// open panal that can chose file from box account
    @objc func startBox() {
        let boxvc = BoxAPIVC()
        boxvc.reloadDelegate = self.reloadDelegate
        present(boxvc, animated: true) {}
    }
    
    /// dismiss view if touch outside of the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let srcView = self.view as! SourcesView
        let touch = touches.first
        if touch?.view != srcView.container {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /// handler for creating folder to start prompt
    @objc func startCreateFolder() {
        alertCreateFold(title: "Create new folder", message: "Enter folder name")
    }
    
    /// Prompt folder creation alert
    /// - Parameters:
    ///     title: title of the alert
    ///     message: message of the alert
    func alertCreateFold(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (txtField) -> Void in txtField.text = "FolderName" })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak alert] (_) in
            if !self.createFolderHandler(alert: alert) {
                // if foldername exist, re-prompt the alert
                self.alertCreateFold(title: "Fold already exist!", message: "Enter another folder name")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Create folder if user confirmed
    /// - Parameters:
    ///     alert: UIAlertController
    /// - Returns:
    ///     true if folder created successfully, false if same name fold exist
    func createFolderHandler(alert: UIAlertController?) -> Bool {
        let textField = alert?.textFields![0]
        let name = textField?.text ?? "FolderName"
        if FileService.shared.checkFolderNameExist(proposed: name) {
            return false
        }
        let newDirectory = Directory(name: name, createDate: Date())
        FileService.shared.write(fileInfo: newDirectory)
        reloadDelegate?.reloadTable()
        self.dismiss(animated: true, completion: nil)
        return true
    }
}

