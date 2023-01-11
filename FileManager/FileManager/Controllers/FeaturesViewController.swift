//
//  FeaturesViewController.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class FeaturesViewController: UIViewController {
    
    var mainViewDelegate: MainViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FeaturesView()
        setUpActions()
    }
    
    private func setUpActions() {
        let ftrView = self.view as! FeaturesView
        ftrView.cancelBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        ftrView.timeBtn.addTarget(self, action: #selector(sortByCreateTime), for: .touchUpInside)
        ftrView.fileTypesBtn.addTarget(self, action: #selector(sortByFileType), for: .touchUpInside)
        ftrView.nameBtn.addTarget(self, action: #selector(sortByName), for: .touchUpInside)
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByCreateTime() {
        var fileInfos = (FileService.shared.currentDirectory?.children)!
        FileSorter.shared.sort(fileInfos: &fileInfos, predicate: .CREATE_DATE)
        FileService.shared.currentDirectory!.children = fileInfos
        mainViewDelegate?.reloadTable()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByFileType() {
        var fileInfos = (FileService.shared.currentDirectory?.children)!
        FileSorter.shared.sort(fileInfos: &fileInfos, predicate: .FILE_TYPE)
        FileService.shared.currentDirectory!.children = fileInfos
        mainViewDelegate?.reloadTable()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sortByName() {
        var fileInfos = (FileService.shared.currentDirectory?.children)!
        FileSorter.shared.sort(fileInfos: &fileInfos, predicate: .NAME)
        FileService.shared.currentDirectory!.children = fileInfos
        mainViewDelegate?.reloadTable()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ftrView = self.view as! FeaturesView
        let touch = touches.first
        if touch?.view != ftrView.container {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
