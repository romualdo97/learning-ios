//
//  ViewController.swift
//  FoodTracker
//
//  Created by Wizard on 6/3/20.
//  Copyright © 2020 Wizard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Handle the text field's user input through delegate callbacks
        nameTextField.delegate = self;
    }
    
    // MARK: UITextFieldDelegate
    // Asks the delegate if the text field should process the pressing of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide the keyboard
        nameTextField.resignFirstResponder();
        return true;
    }
      
    // Tells the delegate that editing stopped for the specified text field.
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text;
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
    
    // MARK: Actions
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

}

