//
//  ViewController.swift
//  Ambulance
//
//  Created by Imac on 29/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

var ID_chauffeur = String()

class AcceuilViewController: UIViewController {

    
    override func viewDidAppear(_ animated: Bool) {
        
        let TOKEN = keychain.get("MyTokenDriver")
        //print("hello",TOKEN)
        
        if (TOKEN?.isEmpty == false){
            Token = TOKEN!
            self.get()
            print("déja conecter")
        }else{
            print("na pas token")
        }
        
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    
    
    @IBAction func butt_espace_pro(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func butt_reserv_ambc(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_acceil_client") as! AcceuilClientViewController
        self.present(newViewController, animated: false, completion: nil)
        
    }
    
    
    func get(){
        let role = keychain.get("role")
        //print("hello",role)
        
        let nom_resp = keychain.get("nom_resp")
         if (nom_resp?.isEmpty == false){
            nom_responsable = nom_resp!

        }
        if (role?.isEmpty == false){
            if(role == "ADMIN"){
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_esppartner") as! EspaceProPartnerViewController
                self.present(newViewController, animated: false, completion: nil)
            }else{
                let Id_chauffeur = keychain.get("Id_chauffeur")
                ID_chauffeur = Id_chauffeur!
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_espchauff") as! EspaseChauffeurViewController
                self.present(newViewController, animated: false, completion: nil)
            }
        
        }
    }
    
    

}

