//
//  testViewController.swift
//  Ambulance
//
//  Created by Imac on 05/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

        @IBAction func butt_(_ sender: Any) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "id_chat") as! JSQMessagesViewController
            self.present(newViewController, animated: false, completion: nil)
        }

}
