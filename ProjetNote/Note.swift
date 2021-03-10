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
    var dateCrea:String
    var localisation:String
    init(titre:String,contenu:String,dateCrea:String,localisation:String) {
        self.titre=titre
        self.contenu=contenu
        self.dateCrea=dateCrea
        self.localisation=localisation
    }
}
