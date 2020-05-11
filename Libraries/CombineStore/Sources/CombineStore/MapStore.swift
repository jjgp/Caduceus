import SwiftUI

public struct MapStore<T, S, A, Content>: View where Content: View {
    private let content: (T) -> Content
    @Environment(\.store) private var environmentStore
    private let store: Store<S, A>?
    private let transform: (Store<S, A>) -> T

    public init(_ transform: @escaping (Store<S, A>) -> T, @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.store = nil
        self.transform = transform
    }

    public init(
        _ store: Store<S, A>,
        transform: @escaping (Store<S, A>) -> T,
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.content = content
        self.store = store
        self.transform = transform
    }

    @ViewBuilder
    public var body: some View {
        if store != nil {
            content(transform(store!)).provide(store: store!)
        } else {
            content(transform(environmentStore as! Store<S, A>))
        }
    }

    typealias TrueContent = ModifiedContent<Content, _EnvironmentKeyWritingModifier<Any>>
}
