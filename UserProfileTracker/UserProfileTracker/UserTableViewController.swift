//
//  UserTableViewController.swift
//  UserProfileTracker
//
//  Created by jason harrison on 2019-02-18.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit
import os.log

class UserTableViewController: UITableViewController {

    //MARK: Properties
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved users, otherwise load sample data.
        if let savedUsers = loadUsers() {
            users = savedUsers
            print("got saved users")
        }else {
            // Load the sample data.
            print("loading sample data")
            loadSampleUsers()
        }
        
        
      //  loadSampleUsers()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "UserTableViewCell"

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserTableViewCell.")
        }
        // Configure the cell...
        // Fetches the appropriate meal for the data source layout.
        let user = users[indexPath.row]

        cell.cellLabel.text = user.firstName
        cell.photoImageView.image = user.photo
        cell.ratingControl.rating = user.rating
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            users.remove(at: indexPath.row)
            saveUsers()

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddUser":
            os_log("Adding a new user.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let userDetailViewController = segue.destination as? UserViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? UserTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedUser = users[indexPath.row]
            userDetailViewController.user = selectedUser
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? UserViewController, let user = sourceViewController.user {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing user.
                users[selectedIndexPath.row] = user
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new user.
                let newIndexPath = IndexPath(row: users.count, section: 0)
                
                users.append(user)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the users.
            saveUsers()
        }
    }
    
    
    //MARK: Private Methods
    
    private func loadSampleUsers() {
        let photo1 = UIImage(named: "cassandra")
        let photo2 = UIImage(named: "larry")
        let photo3 = UIImage(named: "johnny")
        let photo4 = UIImage(named: "jason")
        let photo5 = UIImage(named: "sandy")
        let photo6 = UIImage(named: "ts")
        let photo7 = UIImage(named: "jb")
        
    
        guard let user1 = User(firstName: "Cassandra", photo: photo1, rating: 5) else {
            fatalError("Unable to instantiate user1")
        }
        
        guard let user2 = User(firstName: "Lawrence", photo: photo2, rating: 3) else {
            fatalError("Unable to instantiate user2")
        }
        
        guard let user3 = User(firstName: "Johnny", photo: photo3, rating: 4) else {
            fatalError("Unable to instantiate user3")
        }
        guard let user4 = User(firstName: "Jason", photo: photo4, rating: 4) else {
            fatalError("Unable to instantiate user4")
        }
        guard let user5 = User(firstName: "Sandy", photo: photo5, rating: 2) else {
            fatalError("Unable to instantiate user5")
        }
        guard let user6 = User(firstName: "Taylor", photo: photo6, rating: 0) else {
            fatalError("Unable to instantiate user6")
        }
        guard let user7 = User(firstName: "Justin", photo: photo7, rating: 1) else {
            fatalError("Unable to instantiate user7")
        }
        
        users += [user1, user2, user3, user4, user5, user6, user7]

    }
    
    private func saveUsers() {
      //  let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: User.ArchiveURL.path)
        
        
     //   let isSuccessfulSave = NSKeyedArchiver.archivedData(withRootObject: User.ArchiveURL.path, requiringSecureCoding: false)
        
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: users, requiringSecureCoding: false)
            try data.write(to: User.ArchiveURL)
        } catch {
            print("Couldn't write file")
            os_log("Failed to save users...", log: OSLog.default, type: .error)

            fatalError("couldn't write file")
        }
        
        
        
        os_log("Users successfully saved.", log: OSLog.default, type: .debug)
       
    }
    
    
    private func loadUsers() -> [User]? {
        
        
        
        
        if let data = try? Data(contentsOf: User.ArchiveURL) {
            if let archivedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [User] {
                self.users = archivedData ?? [User]()
                return self.users
            }
            print("oops")
        }
        
        os_log("error fetching Users.", log: OSLog.default, type: .debug)
        return nil
    }
}
