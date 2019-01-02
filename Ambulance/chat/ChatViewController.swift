//
//  ChatViewController.swift
//  Ambulance
//
//  Created by Imac on 05/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var window = UIWindow()
    
    var messages = [JSQMessage]()
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("3abbes")
        setupBackButton()
        i = 9
        print("hhhh\(ID_chauffeur)hhhh")
        //        senderId = "1234"
        //        senderDisplayName = "mouadh"
        let defaults = UserDefaults.standard
        
        if  let id = defaults.string(forKey: "jsq_id")//,
            //let name = defaults.string(forKey: "jsq_name")
        {
            senderId = id
            senderDisplayName = "nom_client"//name
        }
        else
        {
            senderId = String(arc4random_uniform(999999))
            senderDisplayName = "nom_client"
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            
            //showDisplayNameDialog()
        }
        
        title = "Chat: \(senderDisplayName!)"
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
//        tapGesture.numberOfTapsRequired = 1
        
//        navigationController?.navigationBar.addGestureRecognizer(tapGesture)
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        let query = Constants.refs.databaseChats.queryLimited(toLast: 20)
        
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func showDisplayNameDialog()
    {
        let defaults = UserDefaults.standard
        
        let alert = UIAlertController(title: "Your Display Name", message: "Before you can chat, please choose a display name. Others will see this name when you send chat messages. You can change your display name again by tapping the navigation bar.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            if let name = defaults.string(forKey: "jsq_name")
            {
                textField.text = name
            }
            else
            {
                let names = ["Ford", "Arthur", "Zaphod", "Trillian", "Slartibartfast", "Humma Kavula", "Deep Thought"]
                textField.text = names[Int(arc4random_uniform(UInt32(names.count)))]
            }
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak alert] _ in
            
            if let textField = alert?.textFields?[0], !textField.text!.isEmpty {
                
                self?.senderDisplayName = textField.text
                
                self?.title = "Chat: \(self!.senderDisplayName!)"
                
                defaults.set(textField.text, forKey: "jsq_name")
                defaults.synchronize()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        
        let ref = Constants.refs.databaseChats.childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }
    override func didPressAccessoryButton(_ sender: UIButton) {
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
    }
    
    
    
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "< retour", style: UIBarButtonItem.Style.done, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func backButtonTapped() {
        DispatchQueue.main.async {
            print("hhh")
            let editProfilePage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "id_espchauff") as! EspaseChauffeurViewController
            
            self.window.rootViewController = editProfilePage
            self.window.makeKeyAndVisible()
      //self.dismiss(animated: false, completion: nil)
        }
    }
    
}


