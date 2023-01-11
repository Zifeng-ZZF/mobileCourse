//
//  SourcesView.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class SourcesView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var fileAndICloudBtn: UIButton!
    
    @IBOutlet weak var createFolderBtn: UIButton!
    
    @IBOutlet weak var boxBtn: UIButton!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }

    func initialization() {
        Bundle.main.loadNibNamed("SourcesView", owner: self, options: nil)
        addSubview(contentView)
        
        setUpContainer()
        setUpCancelBtn()
        setUpBoxBtn()
        setUpFileAndICloudBtn()
        setUpCreateFolderBtn()
    }
    
    func setUpContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.layer.masksToBounds = false
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
    }
    
    func setUpCancelBtn() {
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cancelBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        cancelBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        cancelBtn.layer.masksToBounds = false
        cancelBtn.layer.cornerRadius = 15
        cancelBtn.clipsToBounds = true
    }
    
    func setUpBoxBtn() {
        boxBtn.translatesAutoresizingMaskIntoConstraints = false
        boxBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        boxBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        boxBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        boxBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        boxBtn.bottomAnchor.constraint(equalTo: cancelBtn.topAnchor, constant: -8).isActive = true
        boxBtn.layer.masksToBounds = false
        boxBtn.layer.cornerRadius = 15
        boxBtn.clipsToBounds = true
    }
    
    func setUpFileAndICloudBtn() {
        fileAndICloudBtn.translatesAutoresizingMaskIntoConstraints = false
        fileAndICloudBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fileAndICloudBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        fileAndICloudBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        fileAndICloudBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fileAndICloudBtn.bottomAnchor.constraint(equalTo: boxBtn.topAnchor, constant: -8).isActive = true
        fileAndICloudBtn.layer.masksToBounds = false
        fileAndICloudBtn.layer.cornerRadius = 15
        fileAndICloudBtn.clipsToBounds = true
    }
    
    func setUpCreateFolderBtn() {
        createFolderBtn.translatesAutoresizingMaskIntoConstraints = false
        createFolderBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createFolderBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        createFolderBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        createFolderBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        createFolderBtn.topAnchor.constraint(equalTo: container.topAnchor, constant: 20).isActive = true
        createFolderBtn.layer.masksToBounds = false
        createFolderBtn.layer.cornerRadius = 15
        createFolderBtn.clipsToBounds = true
    }
}
