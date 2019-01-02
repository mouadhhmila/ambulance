//
//  ConnectionViewController.swift
//  Ambulance
//
//  Created by Imac on 29/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



var nom_responsable = String()
class ConnectionViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {

    var xview = CGFloat()
    var yview = CGFloat()

    @IBOutlet weak var scrollView: UIScrollView!

    
    var keyboardToolbar = UIToolbar()

    
    
    @IBOutlet weak var txt_numtel: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // UIApplication.shared.statusBarStyle = .lightContent

       
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnectionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        scrollView.isScrollEnabled = false
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
    
    
    


    @IBAction func butt_b(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_acceuil") as! AcceuilViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    @IBAction func butt_connexion(_ sender: Any) {
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        

        if validateNum(enteredNumTel: txt_numtel.text!) && validationMotdePasse(entredPassword: txt_password.text!) {
        DispatchQueue.main.async {
//            NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = UIFont(name: "Roboto", size: 18)!
            self.startAnimating(message: "Chargement...", type: NVActivityIndicatorType.circleStrokeSpin)
        self.send()
        }
        }
        
        if !validateNum(enteredNumTel: txt_numtel.text!) && validationMotdePasse(entredPassword: txt_password.text!) {
            
            if txt_numtel.text == "" {
                let alert = UIAlertController(title: "Erreur", message: "Entrez le numéro de téléphone.", preferredStyle: .alert)
                
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
               //"Entrez une adresse e-mail."
            }else{
                print("rrrr")
                let alert = UIAlertController(title: "Erreur", message: "Entrez un numéro de téléphone valide.", preferredStyle: .alert)
                
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
               //"Entrez une adresse e-mail valide."
            }
        }
        
        if validateNum(enteredNumTel: txt_numtel.text!) && !validationMotdePasse(entredPassword: txt_password.text!){
            if txt_password.text == ""{
               //"Entrer le mot de passe."
                let alert = UIAlertController(title: "Erreur", message: "Entrer le mot de passe.", preferredStyle: .alert)
                
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
            }else{
                let alert = UIAlertController(title: "Erreur", message: "Mot de passe incorrect, essayez à nouveau.", preferredStyle: .alert)
                
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
               // "Mot de passe incorrect, essayez à nouveau."
            }
        }
        
        if !validationMotdePasse(entredPassword: txt_numtel.text!) && !validateNum(enteredNumTel: txt_password.text!) {
            if txt_numtel.text == "" && txt_password.text == ""{
                //"Entrez l'adresse e-mail et le mot de passe du votre compte."
                let alert = UIAlertController(title: "Erreur", message: "Entrez le numéro du téléphone et le mot de passe du votre compte.", preferredStyle: .alert)
                
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
            }else{
                //"Entrez une adresse e-mail valide."
                let alert = UIAlertController(title: "Erreur", message: "Entrez un numéro de téléphone valide.", preferredStyle: .alert)
                
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
    
    @IBAction func butt_inscription(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_inscription") as! InscriptionViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    
    
    
    
    func validationMotdePasse(entredPassword:String) -> Bool{
        let passwordFormat = "[A-Z0-9a-z._%+-@]{6,25}"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: entredPassword)
        
        
    }
    
    
    
    func validateNum(enteredNumTel:String) -> Bool {
        
        let numTelFormat = "[0-9]{8,10}"
        let numTelPredicate = NSPredicate(format:"SELF MATCHES %@", numTelFormat)
        return numTelPredicate.evaluate(with: enteredNumTel)
        
    }
    
    
    
    func send(){
        
        
        let tel : String = txt_numtel.text!
        let password : String = txt_password.text!
       
        
        
        let apns : String = "ooioioioioiooioiiooi"
        
        
        
        let postString = ["tel":tel, "password":password, "apns":apns] as [String:Any]
        
        
        //        let postString = ["email":"mouadhhmila@gmail.com", "password":"azerty123", "password_confirmation":"azerty123", "tel":"54614228", "siret_ste":"4343434", "ville":"tunis", "code_postal":"1000", "pays":"tunisie", "nom_ste":"dewinter", "adresse":"lafayette", "nom_responsable":"mouadh"] as [String:Any]
        
        let url = NSURL(string:"\(web_url)/login")
        let request = NSMutableURLRequest(url: url! as URL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        
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
                    
                    
                    if let accessToken = json["access_token"] {
                        Token = accessToken as! String
                        
                        keychain.set(Token, forKey: "MyTokenDriver")
                        print("keychen cbon")
                        
                        DispatchQueue.main.async {
                            self.getDetail()
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            if let message = json["message"]{
                                
                                let msg = message as! String
                                
                                
                                DispatchQueue.main.async {
                                    
                                    self.stopAnimating()
                                }
                            
                            let alert = UIAlertController(title: "Erreur", message: "\(msg)", preferredStyle: .alert)
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
                            }else{
                                DispatchQueue.main.async {
                                    
                                    self.stopAnimating()
                                }
                                let alert = UIAlertController(title: "Erreur", message: "Vérifier votre formulaire", preferredStyle: .alert)
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
                    
                    
                    
                    
                    
                    
                    
                    
                }else {
                    DispatchQueue.main.async {
                        
                        self.stopAnimating()
                    }
                    
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
    
    func getDetail(){
        
        
        let tok = "\(Token)"
        let url = NSURL(string:"\(web_url)/detail")
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
                    
                    DispatchQueue.main.async {
                        
                        self.stopAnimating()
                    }
                    
                    print("détails\(json) ")
                    
                    let data = json["data"] as? NSDictionary
                    let nom_resp = data?["nom_responsable"] as! String
                    nom_responsable = nom_resp
                    let role = data?["role"] as! String
                    
                    DispatchQueue.main.async {
                    if role == "ADMIN"{
                        
                        keychain.set(role, forKey: "role")
                        print("role cbon")
                        keychain.set(nom_resp, forKey: "nom_resp")
                        print("nom_resp cbon")
                        self.getpartner()
                    }else{
                        let Id_chauffeur = data?["id"] as! Int
                        
                        keychain.set(role, forKey: "role")
                        print("role cbon")
                        keychain.set(nom_resp, forKey: "nom_resp")
                        print("nom_resp cbon")
                        keychain.set("\(Id_chauffeur)", forKey: "Id_chauffeur")
                        ID_chauffeur = "\(Id_chauffeur)"
                        print("Id_chauffeur cbon")
                        self.getchauffeur()
                    }
                    }
                    
                    
                }else {
                    DispatchQueue.main.async {
                        
                        self.stopAnimating()
                    
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
            }
            catch let error as NSError
            {
                print(error)
                
                
            }
            
            
            
        }
        task.resume()
        
        
    }
    
    func getpartner(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_esppartner") as! EspaceProPartnerViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    func getchauffeur(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_espchauff") as! EspaseChauffeurViewController
        self.present(newViewController, animated: false, completion: nil)
    }
}
