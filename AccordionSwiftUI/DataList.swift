//
//  DataList.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import SwiftUI

struct DataList : View {
    @ObservedObject var dataStore = DataStore.shared()
    var body: some View {        
        NavigationView {
            List(dataStore.dataRows, id: \.id) { data in
                DataRow(myData: data)
                    .onTapGesture {
                        if data.isExpanded{
                            self.dataStore.collapseCellsFromIndexOf(data)
                        }else{
                            self.dataStore.fetchChildrenforParentAndExpand(data)
                        }
                }
                }
                .navigationBarTitle(Text("Items"))
        }
    }
}

#if DEBUG
struct DataList_Previews : PreviewProvider {
    static var previews: some View {
        DataList()
    }
}
#endif
