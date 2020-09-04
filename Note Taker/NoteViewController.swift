//
//  NoteViewController.swift
//  Note Taker
//
//  Created by Drew Franz on 9/3/20.
//  Copyright © 2020 Drew Franz. All rights reserved.
//

//import Foundation
import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var NoteTitleTextField: UITextField!
    @IBOutlet weak var NoteBodyTextView: UITextView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // Create a new Note objecy using the core data model and context.
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.NoteTitleTextField.text = self.note?.title
        self.NoteBodyTextView.text = self.note?.body
    }

    @IBAction func onNoteSaveAction(_ sender: UIBarButtonItem) {
        if self.note == nil {
            self.note = (NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note)
        }
        
        // If title set, store the value.
        if self.NoteTitleTextField.text != "" {
            self.note?.title = self.NoteTitleTextField.text!
        
        }
        // If the body was set, store the value.
        if self.NoteBodyTextView.text != "" {
            self.note?.body = self.NoteBodyTextView.text!
        }
        
        // Save the note using Core Data.
        do {
            if self.note?.title != "" && self.note?.body != "" {
                self.note?.date = Date()
                try self.context.save()
            }
        }
        catch {
            
        }
        
    }
}
