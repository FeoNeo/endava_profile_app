
//
//  ViewController.swift
//  MachineLearningVision
//
//  Created by Kelly Galakatos on 11/30/18.
//  Copyright © 2018 Kelly Galakatos. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textBox: UITextView!
    
    let model = VGG16()
    
    @IBAction func takePicture(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.camera
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
    }
    
    @IBAction func importPicture(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            //After it is complete
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
           
//            if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
//                guard let scene = try? model.prediction(image: pixelBuffer) else {fatalError("Cannot provide classifications")}
//                print(scene.classLabel)
//            }
        classifyImage(image: imageView.image!)
        
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    