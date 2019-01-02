//
//  InscriptionViewController.swift
//  Ambulance
//
//  Created by Imac on 30/11/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import CountryPicker
import NVActivityIndicatorView

class InscriptionViewController: UIViewController, UITextFieldDelegate, CountryPickerDelegate, NVActivityIndicatorViewable {
    
    var xview = CGFloat()
    var yview = CGFloat()

    @IBOutlet weak var picker: CountryPicker!
    
    
    //@IBOutlet weak var buttignore: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var txt_nomSte: UITextField!
    @IBOutlet weak var siret_societ: UITextField!
    @IBOutlet weak var txt_nomResp: UITextField!
    @IBOutlet weak var txt_adresse: UITextField!
    @IBOutlet weak var txt_ville: UITextField!
    @IBOutlet weak var txt_codeP: UITextField!
    @IBOutlet weak var txt_pays: UITextField!
    @IBOutlet weak var txt_numT: UITextField!
    @IBOutlet weak var txt_mail: UITextField!
    @IBOutlet weak var txt_mdp: UITextField!
    @IBOutlet weak var txt_cmdp: UITextField!
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        //pick up anythink
        txt_pays.text = name
        //picker.isHidden = true
        view.endEditing(true)
        print("mouadh")
    }
    
//    @IBAction func butt_ignorerPicker(_ sender: Any) {
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            DispatchQueue.main.async {
//                self.view.endEditing(true)
//        self.picker.isHidden = true
//        self.buttignore.isHidden = true
//        //self.txt_pays.isUserInteractionEnabled = true
//            }}
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        xview = view.center.x
        yview = view.center.y
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConnectionViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        scrollView.isScrollEnabled = false
        
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
        //init Picker
        picker.exeptCountriesWithCodes = ["fr-FR"] //exept country
        let theme = CountryViewTheme(countryCodeTextColor: .white, countryNameTextColor: .white, rowBackgroundColor: .black, showFlagsBorder: false)        //optional for UIPickerView theme changes
        picker.theme = theme //optional for UIPickerView theme changes
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        picker.setCountry(code!)
        picker.isHidden = true
        
        txt_pays.addTarget(self, action:#selector(textDidBeginEditing), for: UIControl.Event.editingDidBegin)
        
        
        //buttignore.isHidden = true

             
    }
    
    @objc func textDidBeginEditing(sender:UITextField) -> Void
    {
        //picker.isHidden = false
        
        
       // buttignore.isHidden = false
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
          self.view.endEditing(true)
        }
        //txt_pays.isUserInteractionEnabled = false
    }
    
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
        print("dismis key")
        
        
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
//        self.picker.didMoveToSuperview()
//
//        self.txt_pays.isUserInteractionEnabled = true
        
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
            
            //picker.isHidden = true
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
   
    
   
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func butt_back(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func butt_allezconnecter(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func butt_inscription(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
//        self.present(newViewController, animated: false, completion: nil)
        let activityInd = NVActivityIndicatorView(frame: CGRect(x: xview - 25, y: yview - 25, width: 50, height: 50), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), padding: 2)
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        view.addSubview(activityInd)
        
        if txt_nomSte.text != "" && siret_societ.text != "" && txt_nomResp.text != "" && txt_adresse.text != "" && txt_ville.text != "" && txt_codeP.text != "" && validateNum(enteredNumTel: txt_numT.text!) && validateEmail(enteredEmail: txt_mail.text!) && validationMotdePasse(entredPassword: txt_mdp.text!) && txt_mdp.text == txt_cmdp.text{
            
            DispatchQueue.main.async {
                self.startAnimating(message: "Chargement...", type: NVActivityIndicatorType.circleStrokeSpin)
                self.send()
            }
        }else{
             DispatchQueue.main.async {
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
    
    
    
//    "access_token" = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjJkNmEzZDRhYWMyMDQxMmYwMTliMjQyZjgyOGJjNzdhZDEyMjAwZGZhNTU4YzFjOTAyNmVkMGU2OWNmZWMzMDIzZjYzNDMwMjk0ZTFlZmJjIn0.eyJhdWQiOiIxIiwianRpIjoiMmQ2YTNkNGFhYzIwNDEyZjAxOWIyNDJmODI4YmM3N2FkMTIyMDBkZmE1NThjMWM5MDI2ZWQwZTY5Y2ZlYzMwMjNmNjM0MzAyOTRlMWVmYmMiLCJpYXQiOjE1NDM4NTQ3MTEsIm5iZiI6MTU0Mzg1NDcxMSwiZXhwIjoxNTQ1MTUwNzExLCJzdWIiOiI4Iiwic2NvcGVzIjpbIkFETUlOIl19.WxneSjCK0OIs3gS2ykZ0f33x9Dh5Rgazd759JqyqocI2XhmdmKQ7jkiksiB74bdIkOxkp5EpsaXJYXheOeAZS3-h4EcN_p7fbcYW_70lZe24Iz25wgivQyf45P6mm583II-fSBTW1PjB2Hy5XwzkLyjLen3xuq0aSIjoow8CoHfQJkNGh1-2_kBdqGNUP_SZewIwmsAdZof5uNhjxLjL1U66YqebtXBWMHddYrYlTgPOktdaBAKtKhR2yNVJWl4P_H02CNOYbJH_I5Yyb0Q-eOFO8LbUhVJ52P7GPGN76IUifBtSMLVTICY-bav8iX9Uf37dABnEmgq8MVo7IQ46i1bVWS0Z3lMBK8OFzohyDLrOIUcM9w6ptuu8TF-gZUjFRNDJmROpL6eIn5vIDxVFKM-zWwf75MrWDETSJFghwSGccrz4TlDVir1f6G9EulrSaNZQF_iWyo6jdTYF1MPZnH-7ETLzDC3UK31vpMrRyGFoWGpZsKUaEVJ1YZECOLgQ1RnscRCVQNhqa4wvBuwdA_EAkpz8hjJYi_1oh0XpqgioX5D4LbybI65GmSk863C49CLb9CuF81z-8o5gyDmZ_ud8HABIy_hyAziKDO7GSYlN-9O70b_sg5ZwK2q_ZAXDpT1moajRCs2HfHNgBNKxPS-RgBHDGH39dBPX9X2BYYA";
//    "expires_in" = 1296000;
//    "refresh_token" = def502002f7a638fe0c05568ea47de2857617bb86f50c9b5f64b1e3866fa3835413c8f18305e46b421be206bb3a6ec9c771fe17e37bae59f3e52a378cfe9114fc82243eb60b92452dc6291f789564bb17ecb59ccbe41af38ddc8ddce6e73860a97327bb084affec0c823eaec5d8986004a0e0d4a05915aa9ff9aa6ffcef9af90dc32b16ec4c247e0d146812caa4989a4519b7bf7b8df9fa03cc8ff068b8a5054decd5b6bd2e86667302b2c9ad6631dfafc58fa6ba83884972b02b329511b102278a9a1f4d5f3a4037f71974a98ddb2d0870bed80b6711801a3a7308c19bc4efda187b6dac9c6c5e60b7ac9932aa84a57d4a3d9a05973e2d440bbe724474c06f5f1af341c3bd4dbd2937f836033231363f946623c26f59057eaf76b6de2a1db8e8307d0849c287d2d069f058ff87548d68e10a94bb96a3fefe3ec566c3160278973535778f0728cc82d0f1ed3a52e18fe52817ce6c87379e79be40afd6c644e85c1463ff610cefab0;
//    "token_type" = Bearer;
//
    
    func send(){
        
        
        let email : String = txt_mail.text!
        let password : String = txt_mdp.text!
        let password_confirmation : String = txt_cmdp.text!
        let tel : String = txt_numT.text!
        let Siret_ste : String = siret_societ.text!
        let ville : String = txt_ville.text!
        let code_postal : String = txt_codeP.text!
        let pays : String = txt_pays.text!
        let nom_ste : String = txt_nomSte.text!
        let adresse : String = txt_adresse.text!
        let nom_responsable : String = txt_nomResp.text!

        

        
        
        
        let postString = ["email":email, "password":password, "password_confirmation":password_confirmation, "tel":tel, "siret_ste":Siret_ste, "ville":ville, "code_postal":code_postal, "pays":pays, "nom_ste":nom_ste, "adresse":adresse, "nom_responsable":nom_responsable] as [String:Any]
        
        
//        let postString = ["email":"mouadhhmila@gmail.com", "password":"azerty123", "password_confirmation":"azerty123", "tel":"54614228", "siret_ste":"4343434", "ville":"tunis", "code_postal":"1000", "pays":"tunisie", "nom_ste":"dewinter", "adresse":"lafayette", "nom_responsable":"mouadh"] as [String:Any]
        
        let url = NSURL(string:"\(web_url)/register")
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
            }
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
                    
                    print("é&é&é&é&é \(json) *&é&é&&é&")
                    
                    if let access_token = json["access_token"] {
                        
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        let alert = UIAlertController(title: "Succès", message: "votre inscription est bien terminé", preferredStyle: .alert)
                        
                        let butt = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_connection") as! ConnectionViewController
                            self.present(newViewController, animated: false, completion: nil)
                        }
                      
                        alert.addAction(butt)
                        
                        
                        self.present(alert, animated: true, completion: nil)
                        
                       
                        
                     
                        
                        self.txt_nomSte.text = ""
                        self.txt_nomResp.text = ""
                        self.txt_adresse.text = ""
                        self.txt_ville.text = ""
                        self.txt_codeP.text = ""
                        self.txt_pays.text = ""
                        self.txt_numT.text = ""
                        self.txt_mail.text = ""
                        self.txt_mdp.text = ""
                        self.txt_cmdp.text = ""
                        self.siret_societ.text = ""
                        
                    }
                        }else{
                        DispatchQueue.main.async {
                            
                            self.stopAnimating()
                        }
                        
                            let alert = UIAlertController(title: "Erreur", message: "merci de réinscrire", preferredStyle: .alert)
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
                    
                    
                    
                }else {
                    DispatchQueue.main.async {
                        
                        self.stopAnimating()
                    }
                   
                    let alert = UIAlertController(title: "Erreur", message: "merci de réinscrire", preferredStyle: .alert)
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
    
    
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    
}
