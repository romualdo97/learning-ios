//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Wizard on 6/4/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    // MARK: Properties
    private var ratingButtons = [UIButton]();
    var rating = 0 {
        didSet {
            updateButtonSelectionStates();
        }
    };
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        // property observer is called every time the value of a property is set
        // willSet // is called just before the value is stored
        didSet { // is called immediately after the new value is stored
            setupButtons();
        }
    };
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons();
        }
    };
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame); // Initializes and returns a newly allocated view object with the specified frame rectangle.
        setupButtons();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        setupButtons();
    }
    
    // AMRK: Private methods
    private func setupButtons() {
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button);
            button.removeFromSuperview();
        }
        ratingButtons.removeAll();
        
        // Load button images
        let bundle = Bundle(for: type(of: self));
        print(bundle);
        
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection);
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection);
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection);
        
        for index in 0..<starCount {
            let button = setupButton(index, filledStar, emptyStar, highlightedStar);
            
            // add the new button to the rating button array
            ratingButtons.append(button);
        }
        
        updateButtonSelectionStates();
    }
    
    private func setupButton (_ index:Int, _ filledStar:UIImage?, _ emptyStar:UIImage?, _ highlightedStar:UIImage?) -> UIButton {
        // Create the button
        let button = UIButton();
        // button.backgroundColor = UIColor.red;
        
        // Set the accessibility label
        button.accessibilityLabel = "Set \(index + 1) star rating";
        
        
        // Set the buttons images
        button.setImage(emptyStar, for: .normal);
        button.setImage(filledStar, for: .selected);
        button.setImage(highlightedStar, for: .highlighted);
        button.setImage(highlightedStar, for: [.highlighted, .selected]);
        
        // Add constraings
        
        // A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
        button.translatesAutoresizingMaskIntoConstraints = false; // disables the button's automatically generated constraints.
        
        // A layout anchor representing the width of the view’s frame.
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true;
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true;
        
        // Setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: UIControl.Event.touchUpInside);
        
        // Add the button to the stack
        addArrangedSubview(button);
        
        return button;
    }
    
    // MARK: Button action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)");
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1;
        if selectedRating == rating {
            // If the selected star represents the current rating, reset the rating to 0
            rating = 0;
        } else {
            // Otherwise set the rating to the selected star
            rating = selectedRating;
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // Set the hint string for the currently selected star
            let hintString: String?;
            if rating == index + 1 {
                hintString  = "Tap to reset the rating to zero.";
            } else {
                hintString = nil;
            }
            
            // Calculate the value string
            let valueString: String;
            switch rating {
            case 0:
                valueString = "No rating set.";
            case 1:
                valueString = "1 star set.";
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and the value string
            button.accessibilityLabel = hintString;
            button.accessibilityValue = valueString;
            
            
            // If the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating;
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
