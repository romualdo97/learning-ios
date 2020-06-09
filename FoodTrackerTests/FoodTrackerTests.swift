//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Wizard on 6/3/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    // MARK: Meal class tests
    
    // confirms that the Meal initializer rturns a Meal object when passed valid parameters
    func testMealInitializationSucceeds() {
        // the system automatically runs this test when the unit tests are run
        
        // zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0);
        XCTAssertNotNil(zeroRatingMeal);
        
        // highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5);
        XCTAssertNotNil(positiveRatingMeal);
    }
    
    // confirms that the Meal initializer returns nil when passed a negative rating or an empty name
    func testMealInitializationFails() {
        // negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1);
        XCTAssertNil(negativeRatingMeal);
        
        // rating exceedds maximum
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6);
        XCTAssertNil(largeRatingMeal);
        
        
        // empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0);
        XCTAssertNil(emptyStringMeal);
    }

}
