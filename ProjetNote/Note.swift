//
//  Note.swift
//  ProjetNote
//
//  Created by Charles Boutard on 08/03/2021.
//

import Foundation
import MapKit

class Note {
    
    
    var titre:String
    var contenu:String
    var dateCrea:Date
    var localisation:CLLocationCoordinate2D
    
    
    init(titre:String,contenu:String,latitude: Double,longitude:Double ) {
        let now = Date()
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.titre=titre
        self.contenu=contenu
        self.localisation=coord
        self.dateCrea=now
        
    }
}
