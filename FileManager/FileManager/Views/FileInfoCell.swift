//
//  FileInfoCell.swift
//  FileManager
//
//  Created by Zifeng Zhang on 2021/10/30.
//

import UIKit

class FileInfoCell: UITableViewCell {
    
    var fileInfo: FileInfo?

    @IBOutlet weak var nameLb: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    func setCellItemData(fileInfo: FileInfo) {
        self.fileInfo = fileInfo
        nameLb.text = fileInfo.name
        
        let date = Date.customToDate(str: fileInfo.createDate)
        dateLabel.text = Date.customToPrintString(date: date)
        
        if fileInfo.infoType == .FILE {
            let file  = fileInfo as! File
            nameLb.text = file.name + file.ext
        }
        icon.contentMode = .scaleAspectFill
        icon.backgroundColor = .clear
        icon.image = UIImage.getDecodedBase64(base64: fileInfo.iconImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLb.translatesAutoresizingMaskIntoConstraints = false
        nameLb.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3).isActive = true
        nameLb.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        nameLb.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 9).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
