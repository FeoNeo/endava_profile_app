
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
    
    
    func classifyImage(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("could not continue - no CiImage constructed")
            return
        }
        textBox.text = "classifying..."
        guard let trainedModel = try? VNCoreMLModel(for: VGG16().model) else {
            print("can't load ML model")
            return
        }
        let classificationRequest = VNCoreMLRequest(model: trainedModel) { [weak self] classificationRequest, error in
            guard let results = classificationRequest.results as? [VNClassificationObservation]
                else {
                    print("unexpected result type from VNCoreMLRequest")
                    return
            }
         
            
            let classifications = results.filter({ $0.confidence > 0.01 })
                .map({ "\($0.identifier)  -  \(String(format:"%.4f%%", Float($0.confidence)*100))" })
            
    
            DispatchQueue.main.async { [weak self] in
                self?.textBox.text = "\(classifications.joined(separator: "\n"))"
            }
        }
       
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try imageRequestHandler.perform([classificationRequest])
            } catch {
                print(error)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}