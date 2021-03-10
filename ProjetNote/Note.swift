//
//  Note.swift
//  ProjetNote
//
//  Created by Charles Boutard on 08/03/2021.
//

import Foundation

class Note {
    var titre:String
    var contenu:String
    var dateCrea:Date
    var localisation:String
    init(titre:String,contenu:String,localisation:String) {
        let now = Date()
        self.titre=titre
        self.contenu=contenu
        self.localisation=localisation
        self.dateCrea=now
        
    }
}
