//
//  DataList.swift
//  AccordionSwiftUI
//
//  Created by Anoop M on 2019-06-16.
//  Copyright © 2019 Anoop M. All rights reserved.
//

import SwiftUI

struct DataList: View {
    @ObservedObject var dataStore = DataStore.shared()
    @State private var selectedItemId: String? = nil
    var body: some View {
        NavigationView {
            List(dataStore.dataRows, id: \.id) { data in
                DataRow(myData: data)
                    .onTapGesture {
                        if !data.canBeExpanded {
                            selectedItemId = data.id
                        }
                        if data.isExpanded {
                            self.dataStore.collapseCellsFromIndexOf(data)
                        } else {
                            self.dataStore.fetchChildrenforParentAndExpand(data)
                        }
                    }
                    .background(NavigationLink(destination: Text(data.name ?? "Anonymous"), tag: data.id, selection: $selectedItemId, label: {
                        EmptyView()
                    })
                    )
            }
            .navigationBarTitle(Text("Items"))
        }
    }
}

#if DEBUG
struct DataList_Previews: PreviewProvider {
    static var previews: some View {
        DataList()
    }
}
#endif
