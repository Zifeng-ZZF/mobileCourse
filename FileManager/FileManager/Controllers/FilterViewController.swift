//
//  MainViewController.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class FilterViewController: UIViewController {
    
    //var mainViewDelegate: MainViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FilterView()
        setUpActions()
    }
//    @IBOutlet weak var imageBtn: UIButton!
//
//    @IBOutlet weak var audioBtn: UIButton!
//
//    @IBOutlet weak var pdfBtn: UIButton!
    private func setUpActions() {
        let filterView = self.view as! FilterView
        filterView.cancelBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        filterView.imageBtn.addTarget(self, action: #selector(filterImage), for: .touchUpInside)
        filterView.audioBtn.addTarget(self, action: #selector(filterAudio), for: .touchUpInside)
        filterView.videoBtn.addTarget(self, action: #selector(filtervideo), for: .touchUpInside)
        filterView.pptBtn.addTarget(self, action: #selector(filterppt), for: .touchUpInside)
        filterView.textBtn.addTarget(self, action: #selector(filtertext), for: .touchUpInside)
        filterView.excelBtn.addTarget(self, action: #selector(filterexcel), for: .touchUpInside)
        filterView.docBtn.addTarget(self, action: #selector(filterdoc), for: .touchUpInside)
        filterView.pdfBtn.addTarget(self, action: #selector(filterPdf), for: .touchUpInside)
    }
    
    @objc func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func filterImage() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .IMAGE)
        self.present(fvc, animated: true, completion: nil)
    }
    
    @objc func filterAudio() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .AUDIO)
        
        self.present(fvc, animated: true, completion: nil)
    }
    
    @objc func filtervideo() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .VEDIO)
        
        self.present(fvc, animated: true, completion: nil)
    }
    
    @objc func filterppt() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .PPT)
        
        self.present(fvc, animated: true, completion: nil)
    }
    @objc func filtertext() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .TEXT)
        
        self.present(fvc, animated: true, completion: nil)
    }
    @objc func filterexcel() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .EXCEL)
        
        self.present(fvc, animated: true, completion: nil)
    }
    @objc func filterdoc() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .DOC)
        
        self.present(fvc, animated: true, completion: nil)
    }
    @objc func filterPdf() {
        let fileInfolist = (FileService.shared.currentDirectory?.children)!
        let fvc = ShowFilterViewController() //change this to your class name
        fvc.fileInfolist = FileFilter.filtering(fileInfos: fileInfolist, predicate: .PDF)
        print("fileInfo")
        self.present(fvc, animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let filterView = self.view as! FilterView
        let touch = touches.first
        if touch?.view != filterView.container {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
