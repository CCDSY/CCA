//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let universe = Universe(maxStateValue: 8, threshold: 5, neighborDistance: 2, width: 100, height: 100)

let view = UniverseView<MyDelegate>(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.universe = universe
view.delegate = MyDelegate()

let page = PlaygroundPage.current
page.needsIndefiniteExecution = true
page.liveView = view

view.startUpdate(interval: 0.5)

