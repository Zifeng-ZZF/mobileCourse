//
//  FeaturesView.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class FeaturesView: UIView {
    
    @IBOutlet var contentView: UIView!

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var timeBtn: UIButton!
    
    @IBOutlet weak var fileTypesBtn: UIButton!

    @IBOutlet weak var nameBtn: UIButton!
 
    @IBOutlet weak var cancelBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
    }

    func initialization() {
        Bundle.main.loadNibNamed("FeaturesView", owner: self, options: nil)
        addSubview(contentView)
        self.frame = CGRect(x: 0, y: 0, width: 400, height: 350)
        
        setUpContainer()
        setUpCancelBtn()
        setUpTimeBtn()
        setUpFileTypesBtn()
        setUpNameBtn()

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
    
    func setUpNameBtn() {
        nameBtn.translatesAutoresizingMaskIntoConstraints = false
        nameBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        nameBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        nameBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nameBtn.bottomAnchor.constraint(equalTo: cancelBtn.topAnchor, constant: -8).isActive = true
        nameBtn.layer.masksToBounds = false
        nameBtn.layer.cornerRadius = 15
        nameBtn.clipsToBounds = true
    }

    func setUpFileTypesBtn() {
        fileTypesBtn.translatesAutoresizingMaskIntoConstraints = false
        fileTypesBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fileTypesBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        fileTypesBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        fileTypesBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fileTypesBtn.bottomAnchor.constraint(equalTo: nameBtn.topAnchor, constant: -8).isActive = true
        fileTypesBtn.layer.masksToBounds = false
        fileTypesBtn.layer.cornerRadius = 15
        fileTypesBtn.clipsToBounds = true
    }
    
    func setUpTimeBtn() {
        timeBtn.translatesAutoresizingMaskIntoConstraints = false
        timeBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        timeBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        timeBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        timeBtn.bottomAnchor.constraint(equalTo: fileTypesBtn.topAnchor, constant: -8).isActive = true
        timeBtn.layer.masksToBounds = false
        timeBtn.layer.cornerRadius = 15
        timeBtn.clipsToBounds = true
    }
}
