//
//  AddEditTableViewController.swift
//  ProjetNote
//
//  Created by Charles Boutard on 08/03/2021.
//

import UIKit
import CoreLocation
import MapKit


class AddEditTableViewController: UITableViewController,CLLocationManagerDelegate,UITextViewDelegate , UITextFieldDelegate{
    @IBOutlet weak var titreTF: UITextField!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var contentTF: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonChange: UIButton!
    @IBOutlet weak var buttonImage1: UIButton!
    let managerLoc = CLLocationManager()
    @IBOutlet weak var buttonImage2: UIButton!
    @IBOutlet weak var buttonImage3: UIButton!
    var editContentTF:Bool = false
    var editTitleTF:Bool = false
    var editLocForVisibility:Bool = false
    var note:Note?
    var titredebase : String = ""
    var contentDebase : String = ""
    var saveLoc:Bool = false
    var selectedImage = -1
    

    func checkPourEnableButton(){
        if note != nil{
            if (editContentTF || editTitleTF) || (editLocForVisibility) || (selectedImage != -1){
                SaveButton.isEnabled=true
            }
            else {
                SaveButton.isEnabled=false
            }
        }
        else if (editContentTF && editTitleTF && (selectedImage != -1)) || (editLocForVisibility) {
            SaveButton.isEnabled=true
        }
        else {
            SaveButton.isEnabled=false
        }
    }
    
    
    @IBAction func EditLoc(_ sender: UIButton) {
        editLocForVisibility = true
        checkPourEnableButton()
        selectedImage = note!.image
        
        print("clique sur le button modfier")
        self.saveLoc = true
        print(self.saveLoc)
        viewDidAppear(true)
    }
    
    var coordForAdd : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    @IBAction func mapTapped(_ sender: UITapGestureRecognizer) {
        titreTF.resignFirstResponder()
        contentTF.resignFirstResponder()
    }
    
    
    
    
    override func viewDidLoad() {
        SaveButton.isEnabled = false
        titreTF.delegate=self
        contentTF.delegate=self
        super.viewDidLoad()
        contentTF.layer.borderWidth = 1
        contentTF.layer.borderColor = UIColor.black.cgColor
        contentTF.text = "Entrez votre note ici"
        
        
        contentTF.textColor = UIColor.lightGray
        
        buttonChange.isHidden=true
        
        if let note = note{
            titredebase = note.titre
            contentDebase = note.contenu
            print(titredebase)
            buttonChange.isHidden=false
            contentTF.textColor = UIColor.black
            
            print("creation de la note dans partie edit ")
            
            titreTF.text=note.titre
            contentTF.text=note.contenu
            let coordEdit = CLLocationCoordinate2D(latitude: note.localisation.latitude, longitude: note.localisation.longitude)
            let spanEdit = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let pin = MKPointAnnotation()
            let region = MKCoordinateRegion(center:coordEdit,span: spanEdit)
            pin.coordinate = coordEdit
            mapView.setRegion(region, animated: true)
            mapView.addAnnotation(pin)
            
            
        }
        // MARK: - view did appear
        
        print("view did load fini")
    }
    override func viewDidAppear(_ animated: Bool){
        if note == nil  {
            print("dans view did appear note nil")
            super.viewDidAppear(animated)
            managerLoc.desiredAccuracy = kCLLocationAccuracyBest
            managerLoc.delegate = self
            managerLoc.requestWhenInUseAuthorization()
            managerLoc.startUpdatingLocation()
            return
            
            
            
            // MARK: - loc
        
        }
        if self.saveLoc == true {
            
            super.viewDidAppear(animated)
            print("dans view did appear save loc ok")
            managerLoc.desiredAccuracy = kCLLocationAccuracyBest
            managerLoc.delegate = self
            managerLoc.requestWhenInUseAuthorization()
            managerLoc.startUpdatingLocation()
            return
        }
        else{
            return
        }
    }
    
    
        func locationManager(_ manager : CLLocationManager, didUpdateLocations locations: [CLLocation]){
            if let location = locations.first {
                print("dans loc manager")
                managerLoc.stopUpdatingLocation()
                render(location)
            }
        }
    func render(_ location :CLLocation){
        print("dans render")
        let coordonee = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center : coordonee,span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordonee
        mapView.addAnnotation(pin)
        coordForAdd = coordonee
        print("on passe dans prepare")
        print(coordForAdd.latitude)
        print(coordForAdd.longitude)
        
    }
    
    // MARK: - selection photo
    
    
    @IBAction func SelectedImage1(_ sender: UIButton) {
        selectedImage = 0
        sender.layer.borderWidth=1
        sender.layer.borderColor = UIColor.blue.cgColor
        checkPourEnableButton()
        
    }
    
    @IBAction func SelectedImage2(_ sender: UIButton) {
        selectedImage = 1
        
            sender.layer.borderWidth=1
            sender.layer.borderColor = UIColor.blue.cgColor
        checkPourEnableButton()
    }
    
    @IBAction func SelectedImage3(_ sender: UIButton) {
        selectedImage = 2
        
            sender.layer.borderWidth=1
            sender.layer.borderColor = UIColor.blue.cgColor
        checkPourEnableButton()
    }
    
    
    
    // MARK: - detection edition
    
    
    
    func textViewDidChange(_ textView: UITextView){
        if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        if contentTF.text != contentDebase {
            editContentTF = true
            print("le content tf a ete Edit")
            
        }
        else{
            print("passe dans le content else")
            editContentTF = false
            
        }
        checkPourEnableButton()
        
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titreTF.text != titredebase {
            editTitleTF = true
            print("le titre tf a ete Edit")
            
        }
        else{
            print("passe dans le else")
            editTitleTF = false
            
        }
        checkPourEnableButton()
        
        
        
        
        
    }
    
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveUnwind"{
            print("saving")
            
            
            viewDidAppear(true)
            
            
            let titre = titreTF.text ?? ""
            let contenu = contentTF.text ?? ""
            
            var longitudeAdd : Double
            var latitudeAdd: Double
            
            
            
            longitudeAdd = coordForAdd.longitude
            latitudeAdd = coordForAdd.latitude
            if note != nil && saveLoc == false{
                print("dans le if saveLoc prepare")
                longitudeAdd = (note?.localisation.longitude)!
                latitudeAdd = (note?.localisation.latitude)!
                
                
            }
            self.note = Note(titre: titre, contenu: contenu ,latitude: latitudeAdd,longitude: longitudeAdd, image: selectedImage)
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
