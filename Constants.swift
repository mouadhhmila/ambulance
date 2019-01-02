//
//  Constants.swift
//  Ambulance
//
//  Created by Imac on 05/12/2018.
//  Copyright © 2018 Imac. All rights reserved.
//




import Firebase
var i = Int()

var apns = String()
struct Constants
{
    
    
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("client_\(ID_chauffeur)_\(apns)")
        
    }
    
    
    
}
