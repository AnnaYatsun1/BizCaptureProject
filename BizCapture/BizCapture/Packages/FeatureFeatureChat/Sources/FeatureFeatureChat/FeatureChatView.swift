import SwiftUI
import ComposableArchitecture

public struct ChatView: View {
    public  let store: StoreOf<ChatStore>
    
    public init(store: StoreOf<ChatStore>) {
        self.store = store
    }
    
    public var body: some View {
        
        Text(store.titele)
    }
}
