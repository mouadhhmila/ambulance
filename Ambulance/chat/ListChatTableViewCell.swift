//
//  ListChatTableViewCell.swift
//  Ambulance
//
//  Created by Imac on 21/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

class ListChatTableViewCell: UITableViewCell {

    @IBOutlet weak var img_profil: UIImageView!
    @IBOutlet weak var txt_msg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img_profil.layer.borderWidth = 1
        img_profil.layer.masksToBounds = false
        img_profil.layer.borderColor = UIColor.black.cgColor
        img_profil.layer.cornerRadius = img_profil.frame.height/2
        img_profil.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func butt_choisir(_ sender: Any) {
        print("choisir")
    }
    
}
