//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Wizard on 6/3/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    // @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    /// This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)'
    /// or constructed as part of adding a new Meal
    var meal: Meal?;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self;
        
        // Enable the save button only if the text field has a valid meal name
        updateSaveButtonState();
    }
    
    // MARK: UITextFieldDelegate
    // Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        nameTextField.resignFirstResponder();
        return true;
    }
    
    // tells the delegate that editing began in the specified text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false;
    }
    
    // Tells the delegate that editing stopped for the specified text field.
    func textFieldDidEndEditing(_ textField: UITextField) {
        // mealNameLabel.text = textField.text;
        updateSaveButtonState();
        navigationItem.title = textField.text;
    }
    
    // MARK: UIImagePickerControllerDelegate
    // Tells the delegate that the user cancelled the pick operation.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil); // this dismiss all modal views triggered by this view controller
    }
    
    // Tells the delegate that the user picked a still image or movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image.
        // You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containg an image, but was provided the following: \(info)");
        }
        
        // set photoImageView to display the selected image.
        photoImageView.image = selectedImage;
        
        // Dismiss the image picker
        dismiss(animated: true, completion: nil);
    }
    
    // MARK: Navigation
    /// this method lets you configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        // the UIViewController class's implementation doesn't do anything, but it's a good
        // habit to always call super.prepare(for:sender:) whenever you override it.
        // that way you won't forget it when you subclass a different class
        
        // configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return;
        }
        
        let name = nameTextField.text ?? "";
        let photo = photoImageView.image;
        let rating = ratingControl.rating;
        
        // set the meal to be passed to MealTableViewController after the unwind segue.
        meal = Meal(name: name, photo: photo, rating: rating);
        
        // this code configure the meal property with the appropriate values before segue executes
        
    }
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // hide the keyboard
        nameTextField.resignFirstResponder();
        
        // UIImagePickerController is a view controller that lets a user pick a media from their photo library
        let imagePickerController = UIImagePickerController();
        
        // only allow photos to be picked, not tacken
        imagePickerController.sourceType = .photoLibrary;
        
        // make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self;
        present(imagePickerController, animated: true, completion: nil);
    }
    
    // MARK: Private methods
    private func updateSaveButtonState() {
        // disable the save button if the text field is empty
        let text = nameTextField.text ?? "";
        saveButton.isEnabled = !text.isEmpty;
    }

}

