//
//  DataStore.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class DataStore: ObservableObject {
    @Published var dataRows = [AMPGenericObject]()

    // var didChange = PassthroughSubject<Void, Never>()
    private init() {
        createTestData()
    }

    private static let _shared = DataStore()
    class func shared() -> DataStore {
        return _shared
    }

    private func createTestData() {
        for i in 0..<15 {
            let object = AMPGenericObject()
            object.id = "Category \(i)"
            object.name = "Category \(i)"
            object.parentName = ""
            object.isExpanded = false
            object.level = 0
            object.type = 0
            // Randomly assign canBeExpanded status
            let rem = i % 2
            if rem == 0 {
                object.canBeExpanded = true
            }
            else {
                object.canBeExpanded = false
            }
            dataRows.append(object)
        }
    }

    func collapseCellsFromIndexOf(_ object: AMPGenericObject) {
        // Find the number of childrens opened under the parent recursively as there can be expanded children also
        let index = dataRows.firstIndex { $0 === object }
        let collapseCol = numberOfCellsToBeCollapsed(object)
        // Find the end index by adding the count to start index+1
        let end = index! + 1 + collapseCol
        // Find the range from the parent index and the length to be removed.
        let collapseRange = ((index! + 1)..<end)
        // Remove all the objects in that range from the main array so that number of rows are maintained properly
        dataRows.removeSubrange(collapseRange)
        object.isExpanded = false
    }

    func numberOfCellsToBeCollapsed(_ object: AMPGenericObject) -> Int {
        var total = 0
        
        if object.isExpanded {
            // Set the expanded status to no
            object.isExpanded = false
            let child = object.children
            total = child.count
            
            // traverse through all the children of the parent and get the count.
            for prodData in child {
                total += numberOfCellsToBeCollapsed(prodData)
            }
        }
        return total
    }

    func fetchChildrenforParentAndExpand(_ parentObject: AMPGenericObject) {
        var index = dataRows.firstIndex { $0 === parentObject }
        // If canBeExpanded then only we need to create child
        if parentObject.canBeExpanded {
            parentObject.isExpanded = true
            // If Children are already added then no need to add again
            if parentObject.children.count > 0 {
                for prodData in parentObject.children {
                    dataRows.insert(prodData, at: index! + 1)
                    index! += 1
                }
                return
            }
            // The children property of the parent will be filled with this objects
            // If the parent is of type Category, then fetch the Product.
            if parentObject.type == 0 {
                for i in 0..<10 {
                    let object = AMPGenericObject()
                    object.id = parentObject.id + "Product \(i)"
                    object.name = "Product \(i)"
                    object.level = parentObject.level! + 1
                    object.parentName = "Child \(i) of Level \(object.level!)"
                    // This is used for setting the indentation level so that it look like an accordion view
                    object.type = 1 // OBJECT_TYPE_Product;
                    object.isExpanded = false
                    
                    if i % 2 == 0 {
                        object.canBeExpanded = true
                    }
                    else {
                        object.canBeExpanded = false
                    }
                    parentObject.children.append(object)
                    dataRows.insert(object, at: index! + 1)
                    index! += 1
                }
            }
            // If tapping on Product, fetch the SubProducts
            else {
                for i in 0..<10 {
                    let object = AMPGenericObject()
                    object.id = parentObject.id + "SubProduct \(i)"
                    object.name = "SubProduct \(i)"
                    object.level = parentObject.level! + 1
                    object.parentName = "Child \(i) of Level \(object.level!)"
                    // This is used for setting the indentation level so that it look like an accordion view
                    object.type = 1 // OBJECT_TYPE_Product;
                    object.isExpanded = false
                    // SubProducts need not expand
                    object.canBeExpanded = false
                    parentObject.children.append(object)
                    dataRows.insert(object, at: index! + 1)
                    index! += 1
                }
            }
        }
    }
}
