//
//  EspaceProPartnerViewController.swift
//  Ambulance
//
//  Created by Imac on 30/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


var ListeIDchauffeur:[Int] = []

var ListeNomchauffeur:[String] = []
var ListeDepchauffeur:[String] = []
var ListeRegchauffeur:[String] = []
var Listeid_reg:[Int] = []
var Listeid_dep:[Int] = []
var ListeNumchauffeur:[Int] = []
var ListeTypechauffeur:[String] = []
var ListeMdpchauffeur:[String] = []
var ListeCMpdchauffeur:[String] = []
var ListeLongchauffeur:[Double] = []
var ListeLatchauffeur:[Double] = []


class EspaceProPartnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate, NVActivityIndicatorViewable {

    @IBOutlet weak var tbllistechauffeurp: UITableView!
    @IBOutlet weak var lab_nom: UILabel!
    
    var xview = CGFloat()
    var yview = CGFloat()
    
var Listechauffeur:[String] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("espacepartner")
       
        tbllistechauffeurp.dataSource = self
        tbllistechauffeurp.register(UINib(nibName: "cell_listechauffeurP", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier")
        tbllistechauffeurp .delegate = self
        
        lab_nom.text = "Bonjour \(nom_responsable)"
                self.loadListechauffeur()
        
       
    }
    
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Listechauffeur.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listechauffeurP")! as! ListeChauffeurPTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
       cell.nom_chauffeur.text = "\(Listechauffeur[indexPath.row])"

       cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       
        print("select")
        
    }
    func btnCloseTapped(cell: ListeChauffeurPTableViewCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.tbllistechauffeurp.indexPath(for: cell)
        print(indexPath!.row)
        idx = indexPath!.row
    }

    @IBAction func butt_back(_ sender: Any) {
        
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
self.startAnimating(message: "Chargement...", type: NVActivityIndicatorType.circleStrokeSpin)
        
        self.logout()
    }
    
    @IBAction func butt_ajouterambulancier(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_ajoutambulancier") as! AjoutAmbulancierViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func loadListechauffeur(){
        
        
        let tok = "\(Token)"
        let url = NSURL(string:"\(web_url)/ambilanciers")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
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
                        
                       // ListeIdCamion.removeAll()
                        
                        
                        DispatchQueue.main.async{
                            ListeIDchauffeur.removeAll()
                            
                            ListeNomchauffeur.removeAll()
                            ListeDepchauffeur.removeAll()
                            ListeRegchauffeur.removeAll()
                            Listeid_dep.removeAll()
                            Listeid_reg.removeAll()
                            ListeNumchauffeur.removeAll()
                            ListeTypechauffeur.removeAll()
                            ListeLongchauffeur.removeAll()
                            ListeLatchauffeur.removeAll()
//                            ListeMdpchauffeur.removeAll()
//                            ListeCMpdchauffeur.removeAll()
                            
                            for i in 0 ..< data.count {
                                
                                let nom_ch = data[i]["nom_responsable"]
                                
                                let id_ch = data[i]["id"]
                                
                                let nomm_ch = data[i]["nom_responsable"]
                                let tel_ch = data[i]["tel"]
                                
                                
                                let vehicule = data[i]["vehicule"] as! NSDictionary
                                let data_reg = vehicule["region"] as! NSDictionary
                                let data_dep = vehicule["departement"] as! NSDictionary
                                let reg_ch = data_reg["nom"]
                                let id_reg_ch = data_reg["id"]
                                let dep_ch = data_dep["nom"]
                                let id_dep_ch = data_dep["id"]
                                
                                let type_ch = vehicule["type"]
                                let longitude = vehicule["long"]
                                let lattitude = vehicule["lat"]
//                                let id_ch = data[i]["id"]
//                                let id_ch = data[i]["id"]
                                
                                
                                ListeIDchauffeur.append(id_ch as! Int)
                                
                                ListeNomchauffeur.append(nomm_ch as! String)
                                ListeNumchauffeur.append(tel_ch as! Int)
                                ListeDepchauffeur.append(dep_ch as! String)
                                ListeRegchauffeur.append(reg_ch as! String)
                                Listeid_dep.append(id_dep_ch as! Int)
                                Listeid_reg.append(id_reg_ch as! Int)
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
                                
                                

                                

                                self.Listechauffeur.append(nom_ch as! String)
                                self.tbllistechauffeurp.reloadData()
                            }
                            
                        }
                        
                        
                    }
                    
                    
                }else {
                    
                    let alert = UIAlertController(title: "Erreur", message: "", preferredStyle: .alert)
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
    
    
    func logout(){
        
        let tok = "\(Token)"
        let url = NSURL(string:"\(web_url)/logout")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                DispatchQueue.main.async {
                    
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
                    
                    print("dodo")
                    
                    if let data = json["success"], data as! Int == 1{
                       
                        keychain.delete("MyTokenDriver")
                        keychain.delete("role")
                        keychain.delete("nom_resp")

                        DispatchQueue.main.async {
                            self.stopAnimating()
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
                            self.present(newViewController, animated: false, completion: nil)
                        }
                    }else{
                        print("no data")
                        DispatchQueue.main.async {
                            
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
                    
                  
                    
                }else {
                    
                    DispatchQueue.main.async {
                        
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
            }
            catch let error as NSError
            {
                print(error)
                
                
            }
            
            
            
        }
        task.resume()
        
    }
    
    func set_alert(){
        
            let alert = UIAlertController(title: "Voulez-vous supprimer \(ListeNomchauffeur[idx])", message: "", preferredStyle: .alert)
            
            let OUI = UIAlertAction(title: "OUI", style: UIAlertAction.Style.default) {
                UIAlertAction in
                print("OUI")
                DispatchQueue.main.async {
                self.supp_chauf()
                }
                
            }
            let NON = UIAlertAction(title: "NON", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                print("NON")
                //alert.dismiss(animated: false, completion: nil)
            }
            
            // Add the actions
            alert.addAction(OUI)
            alert.addAction(NON)
            
            
            self.present(alert, animated: true, completion: nil)
        
    }
    
    func supp_chauf(){
        
        let tok = "\(Token)"
        let nommm = ListeNomchauffeur[idx]
        
        let url = NSURL(string:"\(web_url)/ambilancier/delete/\(ListeIDchauffeur[idx])")
        
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
                    
                    
                    
                    
                    if let data = json["data"] as? [[String: Any]], data.count == 0{
                        DispatchQueue.main.async {
                            
                            ListeNomchauffeur.remove(at: idx)
                            ListeDepchauffeur.remove(at: idx)
                            ListeRegchauffeur.remove(at: idx)
                            Listeid_reg.remove(at: idx)
                            Listeid_dep.remove(at: idx)
                            ListeNumchauffeur.remove(at: idx)
                            ListeTypechauffeur.remove(at: idx)
                            
                            ListeLongchauffeur.remove(at: idx)
                            ListeLatchauffeur.remove(at: idx)
                            self.Listechauffeur.remove(at: idx)
                            
                            self.stopAnimating()
                            
                            self.tbllistechauffeurp.reloadData()
                            let alert = UIAlertController(title: "Succés", message: "\(nommm) est supprimé", preferredStyle: .alert)
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
}





