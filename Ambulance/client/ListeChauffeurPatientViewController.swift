//
//  ListeChauffeurPatientViewController.swift
//  Ambulance
//
//  Created by Imac on 11/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

class ListeChauffeurPatientViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, MyCellDelegateCC {
    
    
    @IBOutlet weak var tbllistechauffeurC: UITableView!

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vvvv")
        
        
        tbllistechauffeurC.dataSource = self
        tbllistechauffeurC.register(UINib(nibName: "id_lstcc", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier4")
        tbllistechauffeurC .delegate = self
    }
    

    @IBAction func butt_listchat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_listechat") as! ListChatViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListeNomchauffeur.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_lstcc")! as! ListeChauffeurPatTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        cell.txt_nom.text = "\(ListeNomchauffeur[indexPath.row])"
        cell.txt_type.text = "\(ListeTypechauffeur[indexPath.row])"

        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        print("select")
        
    }
    func btnCloseTapped(cell: ListeChauffeurPatTableViewCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.tbllistechauffeurC.indexPath(for: cell)
        print(indexPath!.row)
        idx = indexPath!.row
    }
    
    
    
    @IBAction func butt_b(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_espace_client") as! EspaceClientViewController
        
        
        
        self.present(newViewController, animated: false, completion: nil)
    }
}
