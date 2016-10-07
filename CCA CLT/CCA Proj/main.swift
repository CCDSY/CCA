//
//  main.swift
//  CCA Proj
//
//  Created by CC on 10/7/16.
//  Copyright © 2016 CC. All rights reserved.
//

import Cocoa

print("Starting universe...")

var universe = Universe(maxStateValue: 8, threshold: 5, neighborDistance: 2, width: 1000, height: 1000)

for i in 0 ..< 1000 {
    print("Iteration: \(i)")
    universe.iterate()
}

print("Instantiating view...")

let view = UniverseView<MyDelegate>(frame: CGRect(x: 0, y: 0, width: 4000, height: 4000))
view.universe = universe
view.delegate = MyDelegate()

do {
    print("Generating output file...")
    try view.dataWithPDF(inside: view.bounds).write(to: URL(fileURLWithPath: "/Users/CC/Desktop/CCA Outputs/Output.pdf"))
} catch {
    print(error)
}
