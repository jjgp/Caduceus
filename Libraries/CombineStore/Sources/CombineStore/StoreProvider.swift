import SwiftUI

public struct StoreProvider<S, A, Content>: View where Content: View {
    private let content: (Store<S, A>) -> Content
    @Environment(\.store) private var environmentStore
    private let store: Store<S, A>?

    public init(@ViewBuilder content: @escaping (Store<S, A>) -> Content) {
        self.content = content
        store = nil
    }

    public init(_ store: Store<S, A>, @ViewBuilder content: @escaping (Store<S, A>) -> Content) {
        self.content = content
        self.store = store
    }

    @ViewBuilder
    public var body: some View {
        if store != nil {
            content(store!).provide(store: store!)
        } else {
            content(environmentStore as! Store<S, A>)
        }
    }
}
