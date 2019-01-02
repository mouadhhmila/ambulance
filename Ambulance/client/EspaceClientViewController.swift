//
//  EspaceClientViewController.swift
//  Ambulance
//
//  Created by Imac on 09/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EspaceClientViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
    
    var Liste_Region:[String] = []
    var Liste_IdRegion:[Int] = []
    
    var Liste_Departement:[String] = []
    var Liste_IdDepartement:[Int] = []
    
    var id_reg = Int()
    var id_dep = Int()
    
    var xview = CGFloat()
    var yview = CGFloat()
    
    
    @IBOutlet weak var txt_reg: UILabel!
    
    @IBOutlet weak var txt_dep: UILabel!
    
    @IBOutlet weak var tbl_reg: UITableView!
    
    @IBOutlet weak var tbl_dep: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_reg.isHidden = true
        tbl_dep.isHidden = true
        // Do any additional setup after loading the view.
        self.tbl_reg.dataSource = self
        self.tbl_reg.register(UINib(nibName: "cell_listeRegion", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier5")
        self.tbl_reg .delegate = self
        
        
        self.tbl_dep.dataSource = self
        self.tbl_dep.register(UINib(nibName: "cell_rep", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier5")
        self.tbl_dep .delegate = self
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
            
            cell.lab_reg.text = "  \(Liste_Region[indexPath.row])"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_rep")! as! DepartementTableViewCell
            cell.contentView.backgroundColor = UIColor.clear
            
            cell.lab_dep.text = "  \(Liste_Departement[indexPath.row])"
            return cell
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
            if(self.tbl_dep.isHidden == true){
                self.txt_reg.text = "  \(self.Liste_Region[indexPath.row])"
                self.txt_reg.textColor = UIColor.black
                self.txt_dep.text = "  Département"
                self.txt_dep.textColor = UIColor.init(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)
                self.id_reg = self.Liste_IdRegion[indexPath.row]
                self.id_dep = Int()
                self.tbl_reg.isHidden = true
            }else{
                self.txt_dep.text = "  \(self.Liste_Departement[indexPath.row])"
                self.txt_dep.textColor = UIColor.black
                self.id_dep = self.Liste_IdDepartement[indexPath.row]
                self.tbl_dep.isHidden = true
            }
            
            
        }
        
        print("select")
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
 
    
    @IBAction func butt_valider(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        DispatchQueue.main.async {
            if self.txt_dep.text == "  Département"{
                print("select department svp !!!")
            }else{
                print("place function move")
                self.startAnimating(message: "", type: NVActivityIndicatorType.circleStrokeSpin)
                self.get_listechauffeur()
            }
            
        }
    }
    
    @IBAction func butt_b(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_acceil_client") as! AcceuilClientViewController
        
        
        
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func butt_down_reg(_ sender: Any) {
        tbl_dep.isHidden = true
        DispatchQueue.main.async {
            self.tbl_reg.isHidden = false
            //self.view_end_editing.addSubview(self.tbl_reg)
            
            self.get_liste_reg()
        }
    }
    
    @IBAction func butt_down_dep(_ sender: Any) {
        if self.txt_reg.text == "  Région"{
            print("svlp sélectionner region !!!")
            
        }else{
            print("c bb")
            tbl_reg.isHidden = true
            
            DispatchQueue.main.async {
                self.tbl_dep.isHidden = false
                //self.view_end_editing.addSubview(self.tbl_dep)
                
                self.get_liste_dep()
            }
        }
    }
    
    
    func get_liste_reg(){
        
        
        
        
        //let tok = "\(Token)"
        
        
        
        let url = NSURL(string:"\(web_url)/departements")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        //request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                DispatchQueue.main.async {
                    
                    self.txt_reg.text = "  Région"
                     self.tbl_reg.isHidden = true
                        
                        
                    let alert = UIAlertController(title: "Erreur", message: "Vérifier votre connexion", preferredStyle: .alert)
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
        
        
        
        
        //let tok = "\(Token)"
        
        
        
        let url = NSURL(string:"\(web_url)/departementsParRegion/\(id_reg)")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        //request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                DispatchQueue.main.async {
                    self.txt_dep.text = "  Département"
                    self.tbl_dep.isHidden = true
                    
                    let alert = UIAlertController(title: "Erreur", message: "Vérifier votre connexion", preferredStyle: .alert)
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
    
    
    func get_listechauffeur(){
        //let tok = "\(Token)"
        
      //  http://ambulance.test-dewinter.com/api/vehiculeParDepartement/15
        
        let url = NSURL(string:"\(web_url)/vehiculeParDepartement/\(id_dep)")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        //request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                DispatchQueue.main.async {
                    self .stopAnimating()
                    
                let alert = UIAlertController(title: "Erreur", message: "Vérifier votre connexion", preferredStyle: .alert)
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
                    
                    
                  
                    
//                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_listechauffC") as! ListeChauffeurPatientViewController
                    if let data = json["data"] as? [[String: Any]]{
                        
                        // ListeIdCamion.removeAll()
                        let valuedata = data.count
                        if valuedata != 0{
                        DispatchQueue.main.async{
                            ListeIDchauffeur.removeAll()
                            ListeNomchauffeur.removeAll()
                            ListeNumchauffeur.removeAll()
                            ListeTypechauffeur.removeAll()
                            ListeLongchauffeur.removeAll()
                            ListeLatchauffeur.removeAll()
                           
                            
                            for i in 0 ..< data.count {
                                
                                
                                
                                
                                
                                
                                let type_ch = data[i]["type"]
                                let longitude = data[i]["long"]
                                let lattitude = data[i]["lat"]
                                
                            let USER = data[i]["user"] as! NSDictionary
                                let nomm_ch = USER["nom_responsable"]
                                let tel_ch = USER["tel"]
                                let id_ch = USER["id"]
                                
                                
                                
                                ListeIDchauffeur.append(id_ch as! Int)
                                ListeNomchauffeur.append(nomm_ch as! String)
                                ListeNumchauffeur.append(tel_ch as! Int)
                                ListeTypechauffeur.append(type_ch as! String)
                                
                                
                                let resultlatt = self.checkNull(obj: longitude as AnyObject)
                                let resultlatt2 = self.checkNull(obj: longitude as AnyObject)
                                if(resultlatt == true) && (resultlatt2 == true){
                                    print("resultlatt et resultlatt2 is nil")
                                    let longg =  0.0
                                    let lattt = 0.0
                                    ListeLongchauffeur.append(longg)
                                    ListeLatchauffeur.append(lattt)
                                }
                                else{
                                    
                                    let xx = Double(longitude as! String)
                                    let yy = Double(lattitude as! String)
                                    ListeLongchauffeur.append(xx!)
                                    ListeLatchauffeur.append(yy!)
                                }
                                self.stopAnimating()
                              
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_listechauffC") as! ListeChauffeurPatientViewController
                        self.present(newViewController, animated: false, completion: nil)
                                
                            }
                            
                        }
                        
                    }else{
                        DispatchQueue.main.async{
                            self.stopAnimating()
                            
                            let alert = UIAlertController(title: "Opps", message: "Aucun chaufeur dans cette département", preferredStyle: .alert)
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
                    }
                    
                }else{
                    self.stopAnimating()
                    let alert = UIAlertController(title: "Erreur", message: "Vérifier votre connexion", preferredStyle: .alert)
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
    func checkNull(obj : AnyObject?) -> Bool {
        if obj is NSNull {
            return true
        } else {
            return false
        }
    }
}
