//
//  UpsideDownScrollView.swift
//  tryout
//
//  Created by Evert van Brussel on 25/07/2020.
//

import SwiftUI

struct LazyUpsideDownVScroll<Data, Content>: View where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
    
    /// The collection of underlying identified data that SwiftUI uses to create
    /// views dynamically.
    var data: Data

    /// A function you can use to create content on demand using the underlying
    /// data.
    var content: (Data.Element) -> Content
    
    /// Creates an instance that uniquely identifies and creates views across
    /// updates based on the identity of the underlying data.
    ///
    /// It's important that the `id` of a data element doesn't change unless you
    /// replace the data element with a new data element that has a new
    /// identity. If the `id` of a data element changes, the content view
    /// generated from that data element loses any current state and animations.
    ///
    /// - Parameters:
    ///   - data: The identified data that the ``ForEach`` instance uses to
    ///     create views dynamically.
    ///   - content: The view builder that creates views dynamically.
    init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(data.reversed()) { element in
                    content(element).flip()
                }
            }
        }.flip()
    }
}
