import SwiftUI

// view stuff wird nur gebaut wenn wir auf eine cryptowährung klicken

struct LazyNavigationView<Content: View> : View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

