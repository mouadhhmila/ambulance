//
//  ListeChauffeurPTableViewCell.swift
//  Ambulance
//
//  Created by Imac on 30/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

protocol MyCellDelegate: AnyObject {
    func btnCloseTapped(cell: ListeChauffeurPTableViewCell)
    func set_alert()
}

class ListeChauffeurPTableViewCell: UITableViewCell {

    @IBOutlet weak var nom_chauffeur: UILabel!
    @IBOutlet weak var buttmodif: UIButton!
    
    weak var delegate: MyCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func butt_modif(_ sender: Any) {
       print("gggg")
        
        delegate?.btnCloseTapped(cell: self)

        
        let editProfilePage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "id_modifambulancier") as! ModifierAmbulancierViewController

        window?.rootViewController = editProfilePage
        window?.makeKeyAndVisible()
        
        

    }
    @IBAction func butt_supp(_ sender: Any) {
        delegate?.btnCloseTapped(cell: self)
        print("supprim")
          delegate?.set_alert()
    }
    
    
    
    @IBAction func butt_localise(_ sender: Any) {
        
        delegate?.btnCloseTapped(cell: self)

        if(ListeLongchauffeur[idx] == 0.0) && (ListeLatchauffeur[idx] == 0.0){
            print("no coordination")
        }else{
        let editProfilePage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "id_map") as! MapsViewController
        
        window?.rootViewController = editProfilePage
        window?.makeKeyAndVisible()
        
        }
        
    }
    
    
    
}

