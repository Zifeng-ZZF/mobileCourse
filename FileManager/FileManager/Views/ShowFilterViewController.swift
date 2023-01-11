//
//  ShowFilterViewController.swift
//  FileManager
//
//  Created by Xushan on 11/11/21.
//

import UIKit
//protocol FilterDelegate {
//    func reloadTable()
//}
class ShowFilterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    private var documentInteractionController: UIDocumentInteractionController?
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterTableview: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
    var fileInfolist = [FileInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        filterTableview.dataSource = self
        filterTableview.delegate = self
        filterTableview.rowHeight = 60
        let fileInfoCellNib = UINib(nibName: "FileInfoCell", bundle: nil)
        filterTableview.register(fileInfoCellNib, forCellReuseIdentifier: "FileInfoCell")
    
        //setUpTableView()
        //FileFilter.reloadDelegate = self
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fileInfolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileInfoCell", for: indexPath) as! FileInfoCell
        let fileList = fileInfolist
        cell.setCellItemData(fileInfo: fileList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tapped = fileInfolist[indexPath.row]
        if tapped.infoType == .FILE {
            let file = tapped as! File
            let fileFullName = file.name + file.ext
            print(fileFullName)
            openInOrShare(url: URL(fileURLWithPath: file.url), nameWithExtension: fileFullName)
        }
        else {
            print("Undefined file info type")
        }
    }
    
    func openInOrShare(url: URL, nameWithExtension: String) {
        let normalizedUrl = URL(fileURLWithPath: url.path.removingPercentEncoding!.removingPercentEncoding!)
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController?.name = nameWithExtension.removingPercentEncoding
        documentInteractionController?.url = normalizedUrl
        documentInteractionController?.uti = normalizedUrl.uti
        documentInteractionController?.presentOptionsMenu(from: view.frame, in: self.view, animated: true)
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func reloadTable() {
//        filterTableview.reloadData()
//
//    }
}
