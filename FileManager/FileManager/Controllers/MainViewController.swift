//
//  DummyButtonsViewController.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

// delegate to reload the tableview in MainView
protocol MainViewDelegate {
    func reloadTable()
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MainViewDelegate {
    // To open different files by their URLs
    private var documentInteractionController: UIDocumentInteractionController?
    
    // data source for the tableView
    private var dataSrc: [FileInfo]? = FileService.shared.currentDirectory?.children
    
    // search bar outlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    // current tableView
    @IBOutlet weak var fileTableView: UITableView!
    
    // Button to open pannel for importing files
    @IBOutlet weak var importFileBtn: UIButton!
    
    // Button action to open pannel for importing files from different sources
    @IBAction func importbtclick(_ sender: Any) {
        let sourcesViewController = (self.storyboard?.instantiateViewController(withIdentifier: "sourcesViewController"))! as! SourcesViewController
        sourcesViewController.modalPresentationStyle = .popover
        sourcesViewController.reloadDelegate = self
        self.present(sourcesViewController, animated: true, completion: nil)
    }
    
    // Button to open pannel for sorting files
    @IBOutlet weak var sortingBtn: UIButton!
    
    // Button to open pannel for sorting files by different properties
    @IBAction func sortingBtnClick(_ sender: Any) {
        let featuresViewController = (self.storyboard?.instantiateViewController(withIdentifier: "featuresViewController"))! as! FeaturesViewController
        featuresViewController.modalPresentationStyle = .popover
        featuresViewController.mainViewDelegate = self
        self.present(featuresViewController, animated: true, completion: nil)
    }
    
    // Button to open pannel for filtering files
    @IBOutlet weak var filterBtn: UIButton!
    
    // Button to open pannel for filtering files by different file types
    @IBAction func filterBtnClick(_ sender: Any) {
        let filterViewController = (self.storyboard?.instantiateViewController(withIdentifier: "filterViewController"))!
        filterViewController.modalPresentationStyle = .popover
        self.present(filterViewController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: tableView methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cnt = dataSrc?.count ?? 0
        return cnt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileInfoCell", for: indexPath) as! FileInfoCell
        let fileList = dataSrc == nil ? FileService.shared.currentDirectory?.children : dataSrc!
        cell.setCellItemData(fileInfo: fileList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tapped = dataSrc![indexPath.row]
        // if directory, push another tabelViewController
        if tapped.infoType == .DIRECTORY {
            if FileService.shared.readDirectory(name: tapped.name) != nil {
                let nextDir = (self.storyboard?.instantiateViewController(withIdentifier: "MainViewController"))! as! MainViewController
                self.navigationController?.pushViewController(nextDir, animated: true)
            }
        }
        // if file, prompt ways of openning/sending/sharing the files
        else if tapped.infoType == .FILE {
            let file = tapped as! File
            let fileFullName = file.name + file.ext
            print(fileFullName)
            openInOrShare(url: URL(fileURLWithPath: file.url), nameWithExtension: fileFullName)
        }
        else {
            print("Undefined file info type")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipedFileInfo = dataSrc![indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self]
            (action, view, completionHandler) in
            self?.handleSwipeDelete(fileInfo: swipedFileInfo)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    /// Open file via documentInteractionController when cell clicked
    /// - Parameters:
    ///     - url: the url of the file.
    ///     - nameWithExtension: fill name of the file.
    func openInOrShare(url: URL, nameWithExtension: String) {
        let normalizedUrl = URL(fileURLWithPath: url.path.removingPercentEncoding!.removingPercentEncoding!)
        documentInteractionController = UIDocumentInteractionController()
        documentInteractionController?.name = nameWithExtension.removingPercentEncoding
        documentInteractionController?.url = normalizedUrl
        documentInteractionController?.uti = normalizedUrl.uti
        documentInteractionController?.presentOptionsMenu(from: view.frame, in: self.view, animated: true)
    }
    
    /// Swipe left to show delete button
    func handleSwipeDelete(fileInfo: FileInfo) {
        FileService.shared.removeFileInfo(fileInfo: fileInfo)
        if ((searchBar.text?.isEmpty) != nil) {
            reloadTable()
        }
        else {
            reloadForSearch(name: searchBar.text!)
        }
    }
    
    // MARK: search bar method
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let normalized = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            reloadForSearch(name: normalized)
        }
        else {
            reloadTable()
        }
    }
    
    // MARK: reloading methods
    
    func reloadTable() {
        dataSrc = FileService.shared.currentDirectory?.children
        fileTableView.reloadData()
    }
    
    func reloadForSearch(name: String) {
        dataSrc = FileService.shared.getFileInfosWithSameName(name: name)
        fileTableView.reloadData()
    }
    
    // MARK: Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        FileService.shared.loadData()
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        fileTableView.dataSource = self
        fileTableView.delegate = self
        fileTableView.rowHeight = 60
        let fileInfoCellNib = UINib(nibName: "FileInfoCell", bundle: nil)
        fileTableView.register(fileInfoCellNib, forCellReuseIdentifier: "FileInfoCell")
        setUpTableView()
        setUpSearchBar()
        setUpButtonsMenu()
        dataSrc = FileService.shared.currentDirectory?.children
    }
    
    /// logicalling going back
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
            FileService.shared.goBack()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = false;
    }
}
