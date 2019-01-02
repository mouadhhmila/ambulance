//
//  EspaseChauffeurViewController.swift
//  Ambulance
//
//  Created by Imac on 01/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import GoogleMaps
import NVActivityIndicatorView
import Firebase



var ListeIDCommande:[Int] = []
var ListeNomClient:[String] = []
var ListePrenomClient:[String] = []
var ListeTelClient:[String] = []
var ListeAPNSClient:[String] = []
var ListeDateCommande:[String] = []
var ListeNdepart:[String] = []
var ListeRdepart:[String] = []
var ListeVdepart:[String] = []
var ListeCPdepart:[String] = []
var ListeNarrive:[String] = []
var ListeRarrive:[String] = []
var ListeVarrive:[String] = []
var ListeCParrive:[String] = []

var timerTestAPP = Timer()

class EspaseChauffeurViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegateOne, GMSMapViewDelegate, NVActivityIndicatorViewable, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var x = CLLocation()
    var xview = CGFloat()
    var yview = CGFloat()
    
    @IBOutlet weak var tbllistepatientc: UITableView!
    @IBOutlet weak var lab_nom: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if timerTestAPP.isValid{
            timerTestAPP.invalidate()
        print("invalite timer")
        }

        // Do any additional setup after loading the view.
        tbllistepatientc.dataSource = self
        tbllistepatientc.register(UINib(nibName: "cell_listechauffeurP", bundle: nil), forCellReuseIdentifier: "cellReuseIdentifier")
        tbllistepatientc .delegate = self
        
        lab_nom.text = "Bonjour \(nom_responsable)"
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        refreshLocationAPP()
        get_reservation()
        
       

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        
        x = locations.last!
         print("---------- update \(x) location in maps -----------")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListeIDCommande.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listepatientc")! as! ListePatientChaufeurTableViewCell
        cell.contentView.backgroundColor = UIColor.clear
        cell.nom_patient.text = "\(ListeNomClient[indexPath.row]) \(ListePrenomClient[indexPath.row])"
        cell.lab_adressD.text = "\(ListeNdepart[indexPath.row]) \(ListeRdepart[indexPath.row]) \(ListeVdepart[indexPath.row]) \(ListeCPdepart[indexPath.row])"
        cell.lab_adressA.text = "\(ListeNarrive[indexPath.row]) \(ListeRarrive[indexPath.row]) \(ListeVarrive[indexPath.row]) \(ListeCParrive[indexPath.row])"
        cell.lab_date.text = "\(ListeDateCommande[indexPath.row])"
        
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        print("select")
      
    }
    
    func btnCloseTapped(cell: ListePatientChaufeurTableViewCell) {
        //Get the indexpath of cell where button was tapped
        let indexPath = self.tbllistepatientc.indexPath(for: cell)
        print(indexPath!.row)
        //idx = indexPath!.row
    }
    
    @IBAction func butt_logoutt(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        self.startAnimating(message: "Déconnexion...", type: NVActivityIndicatorType.circleStrokeSpin)
        self.logout()
    }
    
    
    @IBAction func butt_listchat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_listechat") as! ListChatViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func butt_reload(_ sender: Any) {
        self.get_reservation()
        
    }
    
    
    
    func get_reservation(){
        
        
        let tok = "\(Token)"
     
        
        let url = NSURL(string:"\(web_url)/commandes")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            
            
            
            if error != nil
            {
                print("problème seveur")
                
                
                
                return
            }
            
            do
            {
                if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    
                    print("json_reservationIIIIIII \(json) IIIIII")
                    
                    
                    if let data = json["data"] as? [[String: Any]]{
                        
                        // ListeIdCamion.removeAll()
                        let valuedata = data.count
                        if valuedata != 0{
                            DispatchQueue.main.async{
                                ListeIDCommande.removeAll()
                                ListeNomClient.removeAll()
                                ListePrenomClient.removeAll()
                                ListeTelClient.removeAll()
                                ListeAPNSClient.removeAll()
                                ListeDateCommande.removeAll()
                                ListeNdepart.removeAll()
                                ListeRdepart.removeAll()
                                ListeVdepart.removeAll()
                                ListeCPdepart.removeAll()
                                ListeNarrive.removeAll()
                                ListeRarrive.removeAll()
                                ListeVarrive.removeAll()
                                ListeCParrive.removeAll()
                                
                                
                                
                                for i in 0 ..< data.count {
                                    
                                    
                                    
                                    
                                    

                                    let id = data[i]["id"]
                                    let nom = data[i]["nom"]
                                    let prenom = data[i]["prenom"]
                                    let tel = data[i]["tel"]
                                    let apns_client = data[i]["apns_client"]
                                    let date = data[i]["date"]
                                    let num_rue_d = data[i]["num_rue_d"]
                                    let rue_d = data[i]["rue_d"]
                                    let ville_d = data[i]["ville_d"]
                                    let codepostal_d = data[i]["codepostal_d"]
                                    let num_rue_a = data[i]["num_rue_a"]
                                    let rue_a = data[i]["rue_a"]
                                    let ville_a = data[i]["ville_a"]
                                    let codepostal_a = data[i]["codepostal_a"]


                                    ListeIDCommande.append(id as! Int)
                                    ListeNomClient.append(nom as! String)
                                    ListePrenomClient.append(prenom as! String)
                                    ListeTelClient.append(tel as! String)
                                   // ListeAPNSClient.append(apns_client as! String)
                                    ListeDateCommande.append(date as! String)
                                    //let numrd = Int(num_rue_d as! any)
                                    ListeNdepart.append(num_rue_d as! String)
                                    ListeRdepart.append(rue_d as! String)
                                    ListeVdepart.append(ville_d as! String)
                                    ListeCPdepart.append(codepostal_d as! String)
                                    ListeNarrive.append(num_rue_a as! String)
                                    ListeRarrive.append(rue_a as! String)
                                    ListeVarrive.append(ville_a as! String)
                                    ListeCParrive.append(codepostal_a as! String)

                                    let resultapns = self.checkNull(obj: apns_client as AnyObject)
                                    if(resultapns == true){
                                        print("resultapns is nil")
                                        
                                        let spacevide = ""
                                        ListeAPNSClient.append(spacevide)
                                    }
                                    else{
                                        
                                        ListeAPNSClient.append(apns_client as! String)
                                    }
                                   self.tbllistepatientc.reloadData()
                                    
                                }
                                
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                               
                                
                                let alert = UIAlertController(title: "Opps", message: "Aucun commande pour le moment", preferredStyle: .alert)
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
                    
                    if let data = json["success"], data as! Int == 1 {
                        keychain.delete("MyTokenDriver")
                        keychain.delete("role")
                        keychain.delete("nom_resp")
                         keychain.delete("Id_chauffeur")
                        ID_chauffeur = String()
                        DispatchQueue.main.async {
                            self.locationManager.stopUpdatingLocation()
                            self.stopAnimating()
                            timerTestAPP.invalidate()
                            
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
    
    
    
    
    func refreshLocationAPP(){
       
        
                timerTestAPP.invalidate()
                timerTestAPP = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(send_coordinate), userInfo: nil, repeats: true)

        
        
        
     
    }
    @objc func send_coordinate()
    {
        
        
        
        
        //notif = notif - 1
        let longitude = "\(x.coordinate.longitude)"
        //let longitude = "11.110046"
        let lattitude = "\(x.coordinate.latitude)"
        //let lattitude = "33.521198"
        let tok = "\(Token)"
        
        
        
        let postString = ["long":longitude, "lat":lattitude]
        
        let url = NSURL(string: "\(web_url)/editCoordonee")
        let request = NSMutableURLRequest(url: url! as URL)
        
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {(data,response,error) -> Void in
            
            print("**********************///// SEND ////*************************")
            print("++++++++ lattitude: \(lattitude) + longitude: \(longitude) +++++++++")
           
                print("------------------     Chaque 4 seconde   -------------------")
                print("**************************(  From APP active  enligne)**********************")
           
            
            //  print ("lllaaaattttINAPP:", lattitude)
            // print ("llonnnggggINAPP:", longitude)
            // print ("refuser:", refuser)
            
            if error != nil
            {
                print("problème seveur")
           
                
                return
            }
            
            do
            {
                
                if   let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    
                    print("************* \(json) ********************************************************")
                    
              
                    
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

