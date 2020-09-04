//
//  ViewController.swift
//  Note Taker
//
//  Created by Drew Franz on 9/2/20.
//  Copyright © 2020 Drew Franz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var AddButton: UIBarButtonItem!

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notes = [Note]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! NoteViewController
        
        if segue.identifier == "noteViewSegue" {
            viewController.note = notes[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    // MARK: - Table view colleciton delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = self.notes[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create the swipe action.
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
            // Get the note to delete.
            let noteToDelete = self.notes[indexPath.row]
            // Remove the note from Core Data using the context.
            self.context.delete(noteToDelete)
            // Save the data in Core Data.
            do {
                try self.context.save()
            }
            catch {
                
            }
            self.fetchNotes()
        }
        
        // Return the action.
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        for note in self.notes {
//            print(note)
//        }
//        print("fetching")
        self.fetchNotes()
//        for note in self.notes {
//            print(note)
//        }
    }

    func fetchNotes() {
        do {
            // Get all the saved Note objects from Core Data and add to notes array.
            self.notes = try context.fetch(Note.fetchRequest())

            // Reload the tableView with the new data in the Main app thread.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
}

