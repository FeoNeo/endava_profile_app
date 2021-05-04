
//
//  ImageProcessor.swift
//  MachineLearningVision
//
//  Created by Kelly Galakatos on 12/4/18.
//  Copyright © 2018 Kelly Galakatos. All rights reserved.
//

import Foundation
import CoreVideo

struct ImageProcessor {
    static func pixelBuffer (forImage image:CGImage) -> CVPixelBuffer? {
        
        