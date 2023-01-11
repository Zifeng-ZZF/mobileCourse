//
//  MainView.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/19.
//

import UIKit

class FilterView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var imageBtn: UIButton!
    
    @IBOutlet weak var audioBtn: UIButton!
    
    @IBOutlet weak var videoBtn: UIButton!
    
    @IBOutlet weak var pptBtn: UIButton!
    
    @IBOutlet weak var textBtn: UIButton!
    
    @IBOutlet weak var excelBtn: UIButton!
    
    @IBOutlet weak var docBtn: UIButton!
    
    @IBOutlet weak var pdfBtn: UIButton!
    
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
        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(contentView)
//        self.bounds = contentView.frame
        self.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//        setUpContainer()
//        setUpCancelBtn()
//        setUpPdfBtn()
//        setUpAudioBtn()
//        setUpImageBtn()
    }
    
//    func setUpContainer() {
//        container.translatesAutoresizingMaskIntoConstraints = false
//        container.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2 / 3).isActive = true
//        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        container.layer.masksToBounds = false
//        container.layer.cornerRadius = 30
//        container.clipsToBounds = true
//    }
//
//    func setUpCancelBtn() {
//        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
//        cancelBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        cancelBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        cancelBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        cancelBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        cancelBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
//    }
//
//    func setUpPdfBtn() {
//        pdfBtn.translatesAutoresizingMaskIntoConstraints = false
//        pdfBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        pdfBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        pdfBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        pdfBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        pdfBtn.bottomAnchor.constraint(equalTo: cancelBtn.topAnchor, constant: -40).isActive = true
//    }
//
//    func setUpAudioBtn() {
//        audioBtn.translatesAutoresizingMaskIntoConstraints = false
//        audioBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        audioBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        audioBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        audioBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        audioBtn.bottomAnchor.constraint(equalTo: pdfBtn.topAnchor, constant: -10).isActive = true
//    }
//
//    func setUpImageBtn() {
//        imageBtn.translatesAutoresizingMaskIntoConstraints = false
//        imageBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        imageBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
//        imageBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
//        imageBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        imageBtn.bottomAnchor.constraint(equalTo: audioBtn.topAnchor, constant: -10).isActive = true
//    }
}
