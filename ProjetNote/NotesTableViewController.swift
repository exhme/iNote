//
//  NotesTableViewController.swift
//  ProjetNote
//
//  Created by Charles Boutard on 08/03/2021.
//

import UIKit

class NotesTableViewController: UITableViewController {
    var notes:[Note]=[
        Note(titre: "Titre1", contenu: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", localisation: "Domblans"),Note(titre: "Titre2", contenu: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", localisation: "Domblans")
    ];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath)

       //  Configure the cell...
        let note = notes[indexPath.row]
        let french = DateFormatter()
        french.dateStyle = .medium
        french.timeStyle = .medium
        french.locale = Locale(identifier: "FR-fr")
        cell.textLabel?.text = note.titre
        cell.detailTextLabel?.text=french.string(from: notes[indexPath.row].dateCrea)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedNote=notes.remove(at: fromIndexPath.row)
        notes.insert(movedNote,at: to.row)
        tableView.reloadData()

    }
    
    @IBAction func unwindToNoteView(segue:UIStoryboardSegue){
        print("unwind")
        if segue.identifier == "saveUnwind"{
            print("saveUnwind")
            let sourceVC = segue.source as! AddEditTableViewController
            if let note = sourceVC.note{
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    // edit ici
                    note.dateCrea=Date()
                    self.notes[selectedIndexPath.row]=note
                    tableView.reloadData()
                }
                else{
                    // insert
                    let newIndexPath = IndexPath(row: self.notes.count, section: 0)
                    self.notes.append(note)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }
    

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
        
        if segue.identifier == "EditNote"{
            print("bonjourEdit")
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navigationController = segue.destination as! UINavigationController
            let addEditController = navigationController.topViewController as! AddEditTableViewController
            addEditController.note=note

            
        }
        if segue.identifier == "AddNote" {
            print("bonjourAdd")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
