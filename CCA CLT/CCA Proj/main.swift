//
//  main.swift
//  CCA Proj
//
//  Created by CC on 10/7/16.
//  Copyright © 2016 CC. All rights reserved.
//

import Cocoa

let colorMapping = [PixelData(red: 249, green: 67, blue: 145), PixelData(red: 0, green: 243, blue: 162), PixelData(red: 244, green: 169, blue: 0), PixelData(red: 156, green: 168, blue: 68), PixelData(red: 142, green: 143, blue: 144), PixelData(red: 64, green: 143, blue: 249), PixelData(red: 220, green: 242, blue: 0), PixelData(red: 112, green: 23, blue: 247)]

func main() {
    guard CommandLine.arguments.count >= 5 else {
        print("Missing \(5 - CommandLine.arguments.count) argument(s).")
        return
    }
    
    let baseUrl = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let fileName = CommandLine.arguments.count >= 6 ? CommandLine.arguments[5] : "Output.png"
    let outputUrl = URL(fileURLWithPath: fileName, relativeTo: baseUrl)
    
    print("Starting universe...")
    
    guard let threshold = Int(CommandLine.arguments[1]) else {
        print("Argument not a number")
        return
    }
    guard let neighborDistance = Int(CommandLine.arguments[2]) else {
        print("Argument not a number")
        return
    }
    guard let dimension = Int(CommandLine.arguments[3]) else {
        print("Argument not a number")
        return
    }
    guard let iterationCount = Int(CommandLine.arguments[4]) else {
        print("Argument not a number")
        return
    }
    
    var universe = Universe(maxStateValue: 8, threshold: threshold, neighborDistance: neighborDistance, width: dimension, height: dimension)
    
    for i in 0 ..< iterationCount {
        print("Iteration: \(i)")
        universe.iterate()
    }
    
    print("Generating image...")
    
    let image = universe.cgImageRepresentation(using: colorMapping)!
    
    print("Saving image file...")
    
    let destination = CGImageDestinationCreateWithURL(outputUrl as CFURL, kUTTypePNG, 1, nil)!
    CGImageDestinationAddImage(destination, image, nil)
    CGImageDestinationFinalize(destination)
}

main()
