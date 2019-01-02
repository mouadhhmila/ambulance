//
//  ListeChauffeurPatTableViewCell.swift
//  Ambulance
//
//  Created by Imac on 11/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
protocol MyCellDelegateCC: AnyObject {
    func btnCloseTapped(cell: ListeChauffeurPatTableViewCell)
}
class ListeChauffeurPatTableViewCell: UITableViewCell {
    weak var delegate: MyCellDelegateCC?
    
    
    @IBOutlet weak var txt_nom: UILabel!
    
    @IBOutlet weak var txt_type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

    @IBAction func butt_choisir(_ sender: Any) {
        delegate?.btnCloseTapped(cell: self)
        print("to chat")
    }
}
