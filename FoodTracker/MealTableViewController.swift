//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Wizard on 6/11/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem;

        // load the sample data
        loadSampleMeals();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell";
        
        // Because you created a custom cell class that you want to use, "downcast" the type of the cell to your custom cell subclass, MealTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("THe dequeued cell is not an instance of MealTableViewCell");
        }

        // Configure the cell...
        
        // Fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row];
        
        cell.nameLabel.text = meal.name;
        cell.photoImageView.image = meal.photo;
        cell.ratingConntrol.rating = meal.rating;

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true;
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    
    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);

        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal", log: OSLog.default, type: .debug);
        case "ShowDetail":
            guard let mealDeatilViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)");
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))");
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table");
            }
            
            let selectedMeal = meals[indexPath.row];
            mealDeatilViewController.meal = selectedMeal;
            
        default:
            fatalError("This view controller doesn't know how to prepare for this segue identified as \(String(describing: segue.identifier))");
        }
    }
    
    // MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal
                meals[selectedIndexPath.row] = meal;
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic);
            } else {
                // add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0);
                meals.append(meal);
                tableView.insertRows(at: [newIndexPath], with: .automatic);
            }
            
            // unwind segues provide a simple method for passing information back to an earlier view controller.
            // sometime, however, you need more complex communication between your view controllers.
            // in those cases consider using the "delegate" pattern
        }
    }
    
    // MARK: Private methods
    
    /// Load sample data for being used in the table view scene
    private func loadSampleMeals() {
        // helper method to load sample data into the app
        let photo1 = UIImage(named: "meal1");
        let photo2 = UIImage(named: "meal2");
        let photo3 = UIImage(named: "meal3");
        
        // After loading images create three new meal objects
        guard let meal1 = Meal(name: "Caprese salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1");
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2");
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3");
        }
        
        // push meals to array
        meals += [meal1, meal2, meal3];

    }

}
