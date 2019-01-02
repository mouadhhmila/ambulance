//
//  ListChatViewController.swift
//  Ambulance
//
//  Created by Imac on 21/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import Firebase

class ListChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ListeKEY:[String] = []
    var ListeLastMsg:[String] = []

    @IBOutlet weak var txtLAb: UILabel!
    
    //var refArtists: DatabaseReference!
    
    @IBOutlet weak var tbl_licthcat: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_licthcat.dataSource = self
        tbl_licthcat.register(UINib(nibName: "cell_listchat", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier10")
        tbl_licthcat .delegate = self
        
        
        if(Token.isEmpty){
            txtLAb.text = "Liste des chauffeurs"
            Database.database().reference().observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary =  snapshot.value as? [String:Any] else {return}
                print("fffff")
                
                dictionary.forEach({ (key,value) in
                    //guard let uid = Auth.auth().currentUser?.uid else {return}
                    //print("key", key)
                    //print("value", value)
                    let KEY = key
                    let index = KEY.index(KEY.startIndex, offsetBy: 9)
                    
                    let newKEY = String(KEY.suffix(from: index))
                    //print("hello", newKEY)
                    if newKEY == "\(apns)"{
                        print("yess", KEY)
                    }
                    //            if key == uid{
                    //                let ref = Database.database().reference()
                    //                print("hhhh")
                    //               print(ref)
                    //               // ref.updateChildValues(value)
                    //
                    //            }
                })
                
            }
            
            
        }else{
            txtLAb.text = "Liste des clients"
            
            Database.database().reference().observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionary =  snapshot.value as? [String:Any] else {return}
                print("fffff")
                
                dictionary.forEach({ (key,value) in
                    //guard let uid = Auth.auth().currentUser?.uid else {return}
                    //print("key", key)
                    //print("value", value)
                    let KEY = key
                    let index = KEY.index(KEY.startIndex, offsetBy: 8)
                    let newKEY = String(KEY.prefix(upTo: index))
                    //print("hello", newKEY)
                    if newKEY == "client\(ID_chauffeur)"{
                        print("yess", KEY)
                    
                        
                        self.ListeKEY.append(KEY)
                        Database.database().reference().child(KEY).queryLimited(toLast: 1).observeSingleEvent(of: .value) { (snapshot) in
                            guard let dictionary = snapshot.value as? [String:Any] else {return}
                    dictionary.forEach({ (key,value) in
                        let DICT = value as! NSDictionary
                        let TEXT = DICT["text"] as! String
                        print("last_message", TEXT)
                        self.ListeLastMsg.append(TEXT)
                        self.tbl_licthcat.reloadData()
                           })
                        }
                    }
                    
                })
                
            }
        }
        
        
        
    
        
        
       // refArtists = Database.database().reference()
        
       
        
        //observing the data changes
//        refArtists.observe(DataEventType.value, with: { (snapshot) in
//
//            //if the reference have some values
//            if snapshot.childrenCount > 0 {
//
//               print("hhh")
//
//                //iterating through all the values
//                for artists in snapshot.children.allObjects as! [DataSnapshot] {
//                    //getting values
//                    let artistObject = artists.value as? [String: AnyObject]
//                    let artistName  = artistObject?["sender_id"]
//
//                    print("ddd")
//                    let artistNameM = artistName as Any
//                    print(artistNameM)
//                }
//
//
//            }
//        })
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListeLastMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listchat")! as! ListChatTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        cell.txt_msg.text = ListeLastMsg[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        print("select")
        
    }
    
    @IBAction func butt_back(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
