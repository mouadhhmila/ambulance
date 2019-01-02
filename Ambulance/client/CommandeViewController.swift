//
//  CommandeViewController.swift
//  Ambulance
//
//  Created by Imac on 09/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import GoogleMaps

class CommandeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var x = CLLocation()

    
    @IBOutlet weak var txt_nom: UITextField!
    @IBOutlet weak var txt_prenom: UITextField!
    @IBOutlet weak var txt_NumTel: UITextField!
    @IBOutlet weak var txt_reg: UITextField!
    @IBOutlet weak var txt_dep: UITextField!
    @IBOutlet weak var txt_Numdepart: UITextField!
    @IBOutlet weak var txt_Ruedepart: UITextField!
    @IBOutlet weak var txt_Villedepart: UITextField!
    @IBOutlet weak var txt_cpostaldepart: UITextField!
    @IBOutlet weak var txt_Numarr: UITextField!
    @IBOutlet weak var txt_Ruearr: UITextField!
    @IBOutlet weak var txt_Villearr: UITextField!
    @IBOutlet weak var txt_cpostalarr: UITextField!
    @IBOutlet weak var txt_date: UITextField!
    @IBOutlet weak var txt_heure: UITextField!
    @IBOutlet weak var txt_type: UITextField!
    
    @IBOutlet weak var tbl_reg: UITableView!
    
    @IBOutlet weak var tbl_dep: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
   // @IBOutlet weak var date_picker: UIDatePicker!
    

    
    var tap: UITapGestureRecognizer = UITapGestureRecognizer()
    
    @IBOutlet weak var btnCheckBox:UIButton!
    
    @IBOutlet weak var butt_rdvv: UIButton!
    
    var type = String()
    let datePicker = UIDatePicker()

    
    var Liste_Region:[String] = []
    var Liste_IdRegion:[Int] = []
    
    var Liste_Departement:[String] = []
    var Liste_IdDepartement:[Int] = []
    
    var id_reg = Int()
    var id_dep = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_reg.isHidden = true
        tbl_dep.isHidden = true
        
        self.txt_date.isHidden = true
        self.txt_heure.isHidden = true
       // self.date_picker.isHidden = true
        self.showDatePicker()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(CommandeViewController.dismissKeyboard))
        self.view.addGestureRecognizer(self.tap)
       
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
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        x = locations.last!
        print("---------- update \(x) location in maps -----------")
        let lat = x.coordinate.latitude
        
            let long = x.coordinate.longitude
        DispatchQueue.main.async {
        self.latLong(lat: lat, long: long)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func latLong(lat: Double,long: Double)  {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat , longitude: long)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            print("Response GeoLocation : \(placemarks)")
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? String {
                print("Country :- \(country)")
                // City
                if let city = placeMark.addressDictionary!["City"] as? String {
                    print("City :- \(city)")
                    self.txt_Villedepart.text = city
                    // State
                    if let state = placeMark.addressDictionary!["State"] as? String{
                        print("State :- \(state)")
                        // Street
                        if let street = placeMark.addressDictionary!["Street"] as? String{
                            print("Street :- \(street)")
                            let str = street
                            let streetNumber = str.components(
                                separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                            print("streetNumber :- \(streetNumber)" as Any)
                            self.txt_Numdepart.text = "\(streetNumber)"
                            
                            // ZIP
                            if let zip = placeMark.addressDictionary!["ZIP"] as? String{
                                print("ZIP :- \(zip)")
                                self.txt_cpostaldepart.text = "\(zip)"
                                // Location name
                                if let locationName = placeMark?.addressDictionary?["Name"] as? String {
                                    print("Location Name :- \(locationName)")
                                    // Street address
                                    if let thoroughfare = placeMark?.addressDictionary!["Thoroughfare"] as? NSString {
                                        print("Thoroughfare :- \(thoroughfare)")
                                        self.txt_Ruedepart.text = "\(thoroughfare)"
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
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
                self.txt_reg.text = "\(self.Liste_Region[indexPath.row])"
                self.txt_dep.text = ""
                self.id_reg = self.Liste_IdRegion[indexPath.row]
                self.id_dep = Int()
                self.tbl_reg.isHidden = true
                self.view.addGestureRecognizer(self.tap)
                self.txt_nom.isUserInteractionEnabled = true
                self.txt_prenom.isUserInteractionEnabled = true
                self.txt_NumTel.isUserInteractionEnabled = true
                self.txt_date.isUserInteractionEnabled = true
                self.txt_heure.isUserInteractionEnabled = true
            }else{
                self.txt_dep.text = "\(self.Liste_Departement[indexPath.row])"
                self.id_dep = self.Liste_IdDepartement[indexPath.row]
                self.tbl_dep.isHidden = true
                self.view.addGestureRecognizer(self.tap)
                self.txt_nom.isUserInteractionEnabled = true
                self.txt_prenom.isUserInteractionEnabled = true
                self.txt_NumTel.isUserInteractionEnabled = true
                self.txt_date.isUserInteractionEnabled = true
                self.txt_heure.isUserInteractionEnabled = true

            }
            
            
        }
        
        print("select")
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
//        let loc = Locale.init(identifier: "FR")
//        var calendar = Calendar.current
//        calendar.locale = loc
//        datePicker.calendar = calendar
        
        let loc = Locale(identifier: "fr")
        self.datePicker.locale = loc
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txt_date.inputAccessoryView = toolbar
        txt_date.inputView = datePicker
        txt_heure.inputAccessoryView = toolbar
        txt_heure.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "HH:mm"
        
        //dateFormat = "dd/MM/yyyy"
        txt_date.text = formatter.string(from: datePicker.date)
        txt_heure.text = formatter2.string(from: datePicker.date)
        self.view.endEditing(true)
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
        let bbb = formatter2.string(from: datePicker.date)
        print(bbb)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
        
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
    }
    
//    @IBAction func butt_date(_ sender: Any) {
//       //  self.date_picker.isHidden = false
//        print("khalil")
//        DispatchQueue.main.async {
//
//            self.showDatePicker()
//        }
//    }
//
//    @IBAction func butt_heure(_ sender: Any) {
//        // self.date_picker.isHidden = false
//    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        print("dismis key")
        
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
        
        //tbl_dep.isHidden = true
        //tbl_reg.isHidden = true
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
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func butt_rdv(_ sender: Any) {
        DispatchQueue.main.async {
        
        self.butt_rdvv.setImage(UIImage(named:"success"), for: .normal)
        self.btnCheckBox.setImage(UIImage(named:"circle"), for: .normal)
        self.btnCheckBox.isUserInteractionEnabled = true
        self.butt_rdvv.isUserInteractionEnabled = false
        self.type = "rendez-vous"
            self.txt_date.isHidden = false
            self.txt_heure.isHidden = false
        print(self.type)
        }
    }
    
    @IBAction func butt_immdiat(_ sender: Any) {
        DispatchQueue.main.async {
       
        self.btnCheckBox.setImage(UIImage(named:"success"), for: .normal)
        self.butt_rdvv.setImage(UIImage(named:"circle"), for: .normal)
        self.btnCheckBox.isUserInteractionEnabled = false
        self.butt_rdvv.isUserInteractionEnabled = true
        self.type = "immediat"
            self.txt_date.isHidden = true
            self.txt_heure.isHidden = true
            self.txt_date.text = ""
            self.txt_heure.text = ""
        print(self.type)
        }
    }

    @IBAction func butt_b(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_acceil_client") as! AcceuilClientViewController
        self.present(newViewController, animated: false, completion: nil)
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
        
        
    @IBAction func butt_down_reg(_ sender: Any) {
        tbl_dep.isHidden = true
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.view.removeGestureRecognizer(self.tap)
            self.tbl_reg.isHidden = false
            //self.view_end_editing.addSubview(self.tbl_reg)
            self.txt_nom.isUserInteractionEnabled = false
            self.txt_prenom.isUserInteractionEnabled = false
            self.txt_NumTel.isUserInteractionEnabled = false
            self.txt_date.isUserInteractionEnabled = false
            self.txt_heure.isUserInteractionEnabled = false

            self.get_liste_reg()
        }
        
    }
    @IBAction func butt_down_dep(_ sender: Any) {
        if (txt_reg.text?.isEmpty)!{
            print("svlp sélectionner region !!!")
            
        }else{
            print("c bb")
            tbl_reg.isHidden = true
            
            DispatchQueue.main.async {
                self.view.endEditing(true)
                self.view.removeGestureRecognizer(self.tap)
                self.tbl_dep.isHidden = false
                //self.view_end_editing.addSubview(self.tbl_dep)
                self.txt_nom.isUserInteractionEnabled = false
                self.txt_prenom.isUserInteractionEnabled = false
                self.txt_NumTel.isUserInteractionEnabled = false
                self.txt_date.isUserInteractionEnabled = false
                self.txt_heure.isUserInteractionEnabled = false


                
                self.get_liste_dep()
            }
        }
    }
    @IBAction func butt_metrouver(_ sender: Any) {
        DispatchQueue.main.async {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
            print("ggg")
        }
    }
    @IBAction func butt_valider(_ sender: Any) {
        DispatchQueue.main.async {
            if (self.txt_dep.text?.isEmpty)!{
                print("select department svp !!!")
            }else{
                //self.ajouter_ambulancier()
                self.send_reservation()
            }
            
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
    
    func send_reservation(){
        
        
        
        //date=08-03-2018%2012%3A12%3A12
        
        
        
        
        let nom : String = txt_nom.text!
        let prenom : String = txt_prenom.text!
        let tel : String = txt_NumTel.text!
        let departement_id : String = "\(id_dep)"
        let type : String = self.type
        let type_v : String = txt_type.text!
        let long_d : String = ""
        let lat_d : String = ""
        let num_rue_d : String = txt_Numdepart.text!
        let rue_d : String = txt_Ruedepart.text!
        let ville_d : String = txt_Villedepart.text!
        let codepostal_d : String = txt_cpostaldepart.text!
        let long_a : String = ""
        let lat_a : String = ""
        let num_rue_a : String = txt_Numarr.text!
        let rue_a : String = txt_Ruearr.text!
        let ville_a : String = txt_Villearr.text!
        let codepostal_a : String = txt_cpostalarr.text!
        let date : String = "\(txt_date.text!) \(txt_heure.text!)"
        let apns_client : String = "86767676767666767767777"
        
        
        
        
        let postString = ["nom":nom, "prenom":prenom, "tel":tel, "departement_id":departement_id, "type":type, "type_v":type_v, "long_d":long_d, "lat_d":lat_d, "num_rue_d":num_rue_d, "rue_d":rue_d, "ville_d":ville_d, "codepostal_d":codepostal_d, "long_a":long_a, "lat_a":lat_a, "num_rue_a":num_rue_a, "rue_a":rue_a, "ville_a":ville_a, "codepostal_a":codepostal_a, "date":date, "apns_client":apns_client] as [String:Any]
        
        
        
        let url = NSURL(string:"\(web_url)/commande/ajout")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
//        request.addValue("Bearer " + tok, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
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
                    
                    
                    let alert = UIAlertController(title: "Succés", message: "La réservation est ajoutée", preferredStyle: .alert)
                    
                    let vsl = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.txt_nom.text = ""
                        self.txt_prenom.text = ""
                        self.txt_NumTel.text = ""
                        self.txt_reg.text = ""
                        self.txt_dep.text = ""
                        self.txt_Numdepart.text = ""
                        self.txt_Ruedepart.text = ""
                        self.txt_Villedepart.text = ""
                        self.txt_cpostaldepart.text = ""
                        self.txt_Numarr.text = ""
                        self.txt_Ruearr.text = ""
                        self.txt_Villearr.text = ""
                        self.txt_cpostalarr.text = ""
                        self.txt_date.text = ""
                        self.txt_heure.text = ""
                        self.txt_type.text = ""
                    }
                   
                    
                    // Add the actions
                    alert.addAction(vsl)
                   
                    
                    
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
