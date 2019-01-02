//
//  ModifierAmbulancierViewController.swift
//  Ambulance
//
//  Created by Imac on 04/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

var idx = Int()


class ModifierAmbulancierViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    var Liste_Region:[String] = []
    var Liste_IdRegion:[Int] = []
    var Liste_Departement:[String] = []
    var Liste_IdDepartement:[Int] = []
    
    var id_reg = Int()
    var id_dep = Int()
    
    @IBOutlet weak var tbl_reg: UITableView!
    
    @IBOutlet weak var tbl_dep: UITableView!
    
    @IBOutlet weak var txt_nomAmbcier: UITextField!
    @IBOutlet weak var txt_departement: UITextField!
    @IBOutlet weak var txt_region: UITextField!
    @IBOutlet weak var txt_numTel: UITextField!
    @IBOutlet weak var txt_type: UITextField!
    @IBOutlet weak var txt_mdp: UITextField!
    @IBOutlet weak var txt_cmdp: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!

    var tap: UITapGestureRecognizer = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
print("espace_modif")
        tbl_reg.isHidden = true
        tbl_dep.isHidden = true
        
        // Do any additional setup after loading the view.
        tap = UITapGestureRecognizer(target: self, action: #selector(ConnectionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        scrollView.isScrollEnabled = false
        
        self.tbl_reg.dataSource = self
        self.tbl_reg.register(UINib(nibName: "cell_listeRegion", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier1")
        self.tbl_reg .delegate = self
        
        
        self.tbl_dep.dataSource = self
        self.tbl_dep.register(UINib(nibName: "cell_rep", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier2")
        self.tbl_dep .delegate = self
        
        DispatchQueue.main.async {
        self.txt_nomAmbcier.text = ListeNomchauffeur[idx]
        self.txt_departement.text = ListeDepchauffeur[idx]
        self.txt_region.text = ListeRegchauffeur[idx]
        self.id_reg = Listeid_reg[idx]
        self.id_dep = Listeid_dep[idx]
        self.txt_numTel.text = "\(ListeNumchauffeur[idx])"
        self.txt_type.text = ListeTypechauffeur[idx]
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberRow = Int()
        if(tbl_dep.isHidden == true){
            numberRow = Liste_IdRegion.count
        }else{
            numberRow = Liste_IdDepartement.count
        }
        return numberRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tbl_dep.isHidden == true){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listeRegion")! as! RegionTableViewCell
            cell.contentView.backgroundColor = UIColor.clear
            
            cell.lab_reg.text = "\(Liste_Region[indexPath.row])"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_rep")! as! DepartementTableViewCell
            cell.contentView.backgroundColor = UIColor.clear
            
            cell.lab_dep.text = "\(Liste_Departement[indexPath.row])"
            return cell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            if(self.tbl_dep.isHidden == true){
                self.txt_region.text = "\(self.Liste_Region[indexPath.row])"
                self.txt_departement.text = ""
                self.id_reg = self.Liste_IdRegion[indexPath.row]
                self.id_dep = Int()
                self.tbl_reg.isHidden = true
                self.view.addGestureRecognizer(self.tap)
                self.txt_nomAmbcier.isUserInteractionEnabled = true
            }else{
                self.txt_departement.text = "\(self.Liste_Departement[indexPath.row])"
                self.id_dep = self.Liste_IdDepartement[indexPath.row]
                self.tbl_dep.isHidden = true
                self.view.addGestureRecognizer(self.tap)
                self.txt_nomAmbcier.isUserInteractionEnabled = true
            }
            
            
        }
        
        print("select")
        
    }

    @IBAction func butt_back(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_esppartner") as! EspaceProPartnerViewController
        self.present(newViewController, animated: false, completion: nil)
    }

    
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        print("dismis key")
        
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
    }
    
    
    @objc func Keyboard(notification: Notification){
        
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let KeyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            
            scrollView.contentInset = UIEdgeInsets.zero
        }else {
            scrollView.isScrollEnabled = true
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: KeyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
    
    
    
    @IBAction func butt_valider(_ sender: Any) {
       
            DispatchQueue.main.async {
                if (self.txt_departement.text?.isEmpty)!{
                    print("select department svp !!!")
                }else{
                    self.modifier_ambulancier()
                }
                
            }
        self.modifier_ambulancier()
        
  
    }
    
    
    func modifier_ambulancier(){
        
        
        
        let nom_responsable : String = txt_nomAmbcier.text!
        let departement : String = "\(id_dep)"
        let region : String = "\(id_reg)"
        let tel : String = txt_numTel.text!
        let type : String = txt_type.text!
        let password : String = txt_mdp.text!
        let password_confirmation : String = txt_cmdp.text!
        
        
        let ID = ListeIDchauffeur[idx]
        let tok = "\(Token)"
        
        
        
        let postString = ["nom_responsable":nom_responsable, "departement":departement, "region":region, "tel":tel, "type":type, "password":password, "password_confirmation":password_confirmation] as [String:Any]
        
        
        
        let url = NSURL(string:"\(web_url)/ambilancier/edit/\(ID)")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                //                DispatchQueue.main.async {
                //                    let status = Reach().connectionStatus()
                //                    switch status {
                //                    case .unknown, .offline:
                //                        print("Not connected")
                //
                //                        DispatchQueue.main.async {
                //                        //    self.stopAnimating()
                //
                //
                //                        }
                //
                //
                //                    case .online(.wwan):
                //                        print("Connected via WWAN")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    case .online(.wiFi):
                //                        print("Connected via WiFi")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    }
                //
                //                }
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    
                    
                    print("é&é&é&é&é \(json) *&é&é&&é&")
                    
                    
                    if let success = json["success"] {
                        let succ = success as! Int
                        if succ == 1{
                            DispatchQueue.main.async {
                                
                                let alert = UIAlertController(title: "Succès", message: "\(self.txt_nomAmbcier.text!) est modifié", preferredStyle: .alert)
                                
                                let butt = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_esppartner") as! EspaceProPartnerViewController
                                    self.present(newViewController, animated: false, completion: nil)
                                }
                                
                                alert.addAction(butt)
                                
                                
                                self.present(alert, animated: true, completion: nil)
                                
                               
                                
                                
                                self.txt_nomAmbcier.text = ""
                                self.txt_departement.text = ""
                                self.txt_region.text = ""
                                self.txt_numTel.text = ""
                                self.txt_type.text = ""
                                self.txt_mdp.text = ""
                                self.txt_cmdp.text = ""
                            }
                        }else{
                            let alert = UIAlertController(title: "Erreur", message: "la modification est echoué", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("default")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                   
                    
                    
                    
                    
                }else {
                    
                    let alert = UIAlertController(title: "Erreur", message: "la modification est echoué", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            catch let error as NSError
            {
                print(error)
                
                
            }
            
            
            
        }
        task.resume()
    }
    @IBAction func butt_down_reg(_ sender: Any) {
        tbl_dep.isHidden = true
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.view.removeGestureRecognizer(self.tap)
            self.tbl_reg.isHidden = false
            //self.view_end_editing.addSubview(self.tbl_reg)
            self.txt_nomAmbcier.isUserInteractionEnabled = false
            
            self.get_liste_reg()
        }
        
    }
    
    @IBAction func butt_down_dep(_ sender: Any) {
        if (txt_region.text?.isEmpty)!{
            print("svlp sélectionner region !!!")
            
        }else{
            print("c bb")
            tbl_reg.isHidden = true
            
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.view.removeGestureRecognizer(self.tap)
                self.tbl_dep.isHidden = false
                //self.view_end_editing.addSubview(self.tbl_dep)
                self.txt_nomAmbcier.isUserInteractionEnabled = false
                
                self.get_liste_dep()
            }
        }
        
        
    }
    @IBAction func butt_choix_type(_ sender: Any) {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            let alert = UIAlertController(title: "choisir le type de véhicule", message: "", preferredStyle: .alert)
            
            let vsl = UIAlertAction(title: "VSL-Taxi", style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("VSL")
                self.txt_type.text = "vsl"
            }
            let ambulance = UIAlertAction(title: "ambulance", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                print("AMBULANCE")
                self.txt_type.text = "ambulance"
            }
            
            // Add the actions
            alert.addAction(vsl)
            alert.addAction(ambulance)
            
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func get_liste_reg(){
        
        
        
        
        let tok = "\(Token)"
        
        
        
        let url = NSURL(string:"\(web_url)/departements")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                //                DispatchQueue.main.async {
                //                    let status = Reach().connectionStatus()
                //                    switch status {
                //                    case .unknown, .offline:
                //                        print("Not connected")
                //
                //                        DispatchQueue.main.async {
                //                        //    self.stopAnimating()
                //
                //
                //                        }
                //
                //
                //                    case .online(.wwan):
                //                        print("Connected via WWAN")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    case .online(.wiFi):
                //                        print("Connected via WiFi")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    }
                //
                //                }
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    
                    print("é&é&é&é&é \(json) *&é&é&&é&")
                    
                    
                    if let data = json["data"] as? [[String: Any]]{
                        DispatchQueue.main.async {
                            self.Liste_Region.removeAll()
                            self.Liste_IdRegion.removeAll()
                            
                            for i in 0 ..< data.count {
                                
                                let nom_region = data[i]["nom"] as! String
                                let id_region = data[i]["id"] as! Int
                                
                                
                                //                                let dict_dep = data[i]["departements"] as! NSDictionary
                                //                                let id_dep = dict_dep["id"] as! Int
                                //                                let nom_dep = dict_dep["nom"] as! String
                                
                                self.Liste_Region.append(nom_region)
                                self.Liste_IdRegion.append(id_region)
                                
                                
                                self.tbl_reg.reloadData()
                                
                                
                            }
                            //
                        }
                        
                    }
                    
                }
            }
            catch let error as NSError
            {
                print(error)
                
                
            }
            
            
            
        }
        task.resume()
    }
    
    func get_liste_dep(){
        
        
        
        
        let tok = "\(Token)"
        
        
        
        let url = NSURL(string:"\(web_url)/departementsParRegion/\(id_reg)")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                //                DispatchQueue.main.async {
                //                    let status = Reach().connectionStatus()
                //                    switch status {
                //                    case .unknown, .offline:
                //                        print("Not connected")
                //
                //                        DispatchQueue.main.async {
                //                        //    self.stopAnimating()
                //
                //
                //                        }
                //
                //
                //                    case .online(.wwan):
                //                        print("Connected via WWAN")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    case .online(.wiFi):
                //                        print("Connected via WiFi")
                //                        DispatchQueue.main.async {
                //
                //                           // self.stopAnimating()
                //                        }
                //
                //
                //                    }
                //
                //                }
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    
                    print("é&é&é&é&é \(json) *&é&é&&é&")
                    
                    
                    if let data = json["data"] as? [[String: Any]]{
                        
                        
                        DispatchQueue.main.async {
                            self.Liste_Departement.removeAll()
                            self.Liste_IdDepartement.removeAll()
                            
                            for i in 0 ..< data.count {
                                
                                let nom_departement = data[i]["nom"] as! String
                                let id_departement = data[i]["id"] as! Int
                                
                                
                                
                                self.Liste_Departement.append(nom_departement)
                                self.Liste_IdDepartement.append(id_departement)
                                
                                
                                self.tbl_dep.reloadData()
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
            }
            catch let error as NSError
            {
                print(error)
                
                
            }
            
            
            
        }
        task.resume()
    }
}
