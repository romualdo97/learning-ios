//
//  Meal.swift
//  FoodTracker
//
//  Created by Wizard on 6/9/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import UIKit

class Meal {
    // MARK: Properties
    var name: String;
    var photo: UIImage?;
    var rating: Int;
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        // Validate data, initialization should fall if there is no name or if the rating is negative
        //if name.isEmpty || rating < 0 || rating > 5 {
            //return nil; // only failable initializer can return 'nil', adding a question mark to the init to make this constructor failable
        //}
        
        // the name must not be empty
        guard !name.isEmpty else {
            return nil;
        }
        
        // the rating must be between 0 and 5 inclusively
        guard rating >= 0 && rating <= 5 else {
            return nil;
        }
        
        // Initialize stored properties
        self.name = name;
        self.photo = photo;
        self.rating = rating;
    }

}

