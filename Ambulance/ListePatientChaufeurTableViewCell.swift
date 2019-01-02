//
//  ListePatientChaufeurTableViewCell.swift
//  Ambulance
//
//  Created by Imac on 02/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

protocol MyCellDelegateOne: AnyObject {
    func btnCloseTapped(cell: ListePatientChaufeurTableViewCell)
}

class ListePatientChaufeurTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nom_patient: UILabel!
    @IBOutlet weak var lab_adressD: UILabel!
    @IBOutlet weak var lab_adressA: UILabel!
    @IBOutlet weak var lab_date: UILabel!
    

    weak var delegate: MyCellDelegateOne?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func butt_selectf(_ sender: Any) {
        print("gggg")
        
        delegate?.btnCloseTapped(cell: self)
        
        
        let editProfilePage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "id_chat") as! ChatViewController
        let navigationController1 = UINavigationController(rootViewController: editProfilePage)
        window?.rootViewController = navigationController1
        window?.makeKeyAndVisible()
        
        
        
    }
}
