//
//  BoxAPIVC.swift
//  FileManager
//
//  Created by 郑黄迅 on 11/2/21.
//

import UIKit
import BoxSDK
import SwiftUI
import AuthenticationServices


// reload delegate reload table
protocol BoxAPIDelegate {
    func reloadTable()
}

class BoxAPIVC: UIViewController,UITableViewDelegate, UITableViewDataSource, BoxAPIDelegate, ASWebAuthenticationPresentationContextProviding {
    
    private var sdk: BoxSDK!
    private var client: BoxClient!
    private var folderItems: [FolderItem] = []
    private var curdownloadfileinfo: FileInfo!
    var temp_root = Directory(name: "temp/0", createDate: Date())
    var reloadDelegate: MainViewDelegate?

    @IBOutlet weak var LOGINBT: UIButton!
    
    @IBAction func LOGINPress(_ sender: Any) {
        loginPressed()
    }

    private lazy var errorView: BasicErrorView = {
        let errorView = BasicErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    // here call the login process with getOAuthClient function
    @objc func loginPressed() {
        removeErrorView()
        getOAuthClient()
    }
    // error alert, download error
   func ErrorAlertMessage(message:String, viewController: UIViewController) {
        
                let ErrorDownload = UIAlertController(title: "Error! ", message: "No permission from Box to download this file.", preferredStyle: .alert)
                ErrorDownload.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
                    self.boxapibtn.isEnabled = true
                }))
            viewController.present(ErrorDownload, animated: true, completion: nil)
     
    }
// download success alert
    
    func SuccessAlertMessage(message:String, viewController: UIViewController) {
         
                 let SuccessDownload = UIAlertController(title: "Success!", message: "You have successfully downloaded the file", preferredStyle: .alert)
                SuccessDownload.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
                    self.boxapibtn.isEnabled = true
                }))
             viewController.present(SuccessDownload, animated: true, completion: nil)
        
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cnt = temp_root.children.count
        return cnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileInfoCell", for: indexPath) as! FileInfoCell
        let fileList = temp_root.children
        cell.setCellItemData(fileInfo: fileList[indexPath.row])
        cell.dateLabel.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tapped = temp_root.children[indexPath.row]
        if tapped.infoType == .DIRECTORY {
            // here to clear selected table.
            for cell in tableView.visibleCells {
                cell.setSelected(false, animated: true)
            }
            tableView.reloadData()
            // directory cell clicked, push a new BOXAPIVC and set the value
            let newboxvc = BoxAPIVC()
            newboxvc.client = client
            newboxvc.reloadDelegate = self.reloadDelegate
            newboxvc.BoxgetfolderList(id: tapped.boxId)
            present(newboxvc, animated: true) {}
         
        }
        else if tapped.infoType == .FILE {
            // file cell clicked, poll a file download request
            let file = tapped as! File
            let downloadfile = UIAlertController(title: "Download this file? ", message: "click no to get back.", preferredStyle: .alert)
            downloadfile.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                let url = FileService.archiveURL.appendingPathComponent(String(file.name+file.ext))
                tapped.url = url.path
                self.curdownloadfileinfo = tapped
                self.downloadfiletask(id: tapped.boxId,destURL: url)
                    DispatchQueue.main.async {
                        self.reloadDelegate?.reloadTable()
                    }
            }))
            downloadfile.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                self.reloadDelegate?.reloadTable()
            }))
            
            
            self.present(downloadfile, animated: true, completion: tableView.reloadData)
        }
        else {
            print("Undefined file info type")
        }
    }
    

    @IBOutlet weak var BOXlabel: UILabel!
    @IBOutlet weak var BoxTableView: UITableView!
    @IBOutlet weak var boxapibtn: UIButton!
    
   
// initial setting
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        sdk = BoxSDK(clientId: Constants.clientId, clientSecret: Constants.clientSecret)
        BoxTableView.dataSource = self
        BoxTableView.delegate = self
        BoxTableView.rowHeight = 60
        let fileInfoCellNib = UINib(nibName: "FileInfoCell", bundle: nil)
        BoxTableView.register(fileInfoCellNib, forCellReuseIdentifier: "FileInfoCell")
        if client != nil {
            LOGINBT.isHidden = true
        }
    }


    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // here is return button:
    
    @IBAction func Boxapiclk(_ sender: Any) {
        self.dismiss(animated: true, completion: {
                        //completion block.
                    })
    }
    
    // download API to request a download file
    func downloadfiletask(id:String, destURL:URL) {
        
        boxapibtn.isEnabled = false
        let _: BoxDownloadTask = client.files.download(fileId: id, destinationURL: destURL) { (result: Result<Void, BoxSDKError>) in
            guard case .success = result else {
                print("Error downloading file")
                DispatchQueue.main.async {
                    self.ErrorAlertMessage(message: "Any Message", viewController: self)
                }
                return
            }
            DispatchQueue.main.async {
                self.curdownloadfileinfo.createDate = Date.customToString(date: Date())
                FileService.shared.write(fileInfo: self.curdownloadfileinfo)
                self.SuccessAlertMessage(message: "Any Message", viewController: self)
                self.reloadDelegate?.reloadTable()
            }
        }

    }

    func splitNametoType(name:String) ->String{
        var strs = name.components(separatedBy: ".")
        return strs.popLast()!
        
    }
    // get folder info API from BOX, folder ID request to call the API, initial folader id is 0.
    func BoxgetfolderList(id:String) -> Void{
        client.folders.get(
            folderId: id,
            fields: ["name", "created_at"]
        ) { (result: Result<Folder, BoxSDKError>) in
            guard case let .success(folder) = result else {
                print("Error getting folder information")
                return
            }
//            print("Folder \(String(describing: folder.name)) was created at \(String(describing: folder.createdAt))")
        }

        
        let iterator = client.folders.listItems(folderId: id, sort: .name, direction: .ascending)
        iterator.next { results in
            switch results {
            case let .success(page):
                for item in page.entries {
                    switch item {
                    case let .file(file):
                        let fileTP = self.splitNametoType(name: file.name!)
                        let newtryname = file.name?.replacingOccurrences(of: ".\(fileTP)", with: "")
                        let target = File(name: newtryname!, url: FileService.archiveURL.appendingPathComponent(String(file.name!)).absoluteString, createDate: Date(), type:FileType.parse(s: fileTP), ext: ".\(fileTP.lowercased())")
                        target.boxId = file.id
                        self.temp_root.appendChild(child: target)
//                        print("File \(String(describing: file.name)) (ID: \(file.id)) is in the folder")
                    case let .folder(folder):
                        let target = Directory(name: folder.name!, createDate: Date())
                        target.boxId = folder.id
                        self.temp_root.appendChild(child: target)
//                        print("Subfolder \(String(describing: folder.name)) (ID: \(folder.id)) is in the folder")
                    case let .webLink(webLink):
                        print("Web link \(String(describing: webLink.name)) (ID: \(webLink.id)) is in the folder")
                    }
                }
                DispatchQueue.main.async {
                    self.reloadTable()
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func reloadTable() {
        BoxTableView.reloadData()
        
    }
}


// OAuth 2.0 process API
extension BoxAPIVC {
    func getOAuthClient() {
        if #available(iOS 13, *) {
            print("come to getoauthclient function")
            sdk.getOAuth2Client(tokenStore: KeychainTokenStore(), context:self) { [weak self] result in
                switch result {
                case let .success(client):
                    self?.client = client
                    self?.BoxgetfolderList(id: "0")
                    self?.LOGINBT.isHidden = true
                    print("did success and create a client")
                case let .failure(error):
                    print("error in getOAuth2Client: \(error)")
                    self?.addErrorView(with: error)
                    }
            }
        }
        else {
            sdk.getOAuth2Client(tokenStore: KeychainTokenStore()) { [weak self] result in
                switch result {
                case let .success(client):
                    self?.client = client
                case let .failure(error):
                    print("error in getOAuth2Client: \(error)")
                    self?.addErrorView(with: error)
                }
            }
        }
    }
    
}

 


private extension BoxAPIVC {
// error view setting
    func addErrorView(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.addSubview(self.errorView)
            let safeAreaLayoutGuide = self.view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                self.errorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                self.errorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                self.errorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                self.errorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                ])
            self.errorView.displayError(error)
        }
    }

    func removeErrorView() {
        if !view.subviews.contains(errorView) {
            return
        }
        DispatchQueue.main.async {
            self.errorView.removeFromSuperview()
        }
    }
}
//ASWebAuthenticationSession delegate
extension BoxAPIVC {
    @available(iOS 13.0, *)
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        print("did come to asweb")
        return self.view.window ?? ASPresentationAnchor()
    }
}

