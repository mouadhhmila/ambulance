//
//  AcceuilClientViewController.swift
//  Ambulance
//
//  Created by Imac on 09/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

class AcceuilClientViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func butt_commande_de_trs(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_commande") as! CommandeViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func butt_liste_trs(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_espace_client") as! EspaceClientViewController
        self.present(newViewController, animated: false, completion: nil)
        
    }
    
    @IBAction func butt_b(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_acceuil") as! AcceuilViewController
        self.present(newViewController, animated: false, completion: nil)
    }

}
