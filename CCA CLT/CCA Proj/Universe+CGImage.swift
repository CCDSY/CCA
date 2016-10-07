//
//  Universe+CGImage.swift
//  CCA Proj
//
//  Created by CC on 10/7/16.
//  Copyright © 2016 CC. All rights reserved.
//

import Cocoa
import CoreGraphics

fileprivate let colorSpace = CGColorSpaceCreateDeviceRGB()
fileprivate let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)

fileprivate let bitsPerComponent = 8
fileprivate let bitsPerPixel = 24

extension Universe {
    
    func cgImageRepresentation(using colorMapping: [PixelData]) -> CGImage? {
        let width = grid.count
        let height = grid.first?.count ?? 0
        
        var pixelData = [PixelData]()
        for column in grid {
            for cell in column {
                pixelData.append(colorMapping[cell])
            }
        }
        let provider = CGDataProvider(data: pixelData.toData as CFData)!
        
        let bytesPerRow = width * MemoryLayout<PixelData>.size
        
        return CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo, provider: provider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
    }
    
}
