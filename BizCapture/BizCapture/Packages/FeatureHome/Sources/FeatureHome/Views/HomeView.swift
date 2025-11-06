import SwiftUI
import ComposableArchitecture
import Core


let rooms: [RomeCardRoomModel] = [
    .init(kind: .friend, imageName: Image.homeFriend, title: "Friend"),
    .init(kind: .family, imageName: Image.homeFriend, title: "Family"),
    .init(kind: .coach, imageName: Image.homeFriend, title: "Coach"),
    .init(kind: .dating, imageName: Image.homeFriend, title: "Dating"),
]


public struct HomeView: View {
    @Bindable  public var store: StoreOf<HomeStore>
    @State private var showDoor = false
    @State private var pendingOpenAction: (() -> Void)? = nil
    
    private let columns = [
       GridItem(.flexible(), spacing: 16),
       GridItem(.flexible(), spacing: 16)
     ]
    
    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }
    
    public var body: some View {
      ZStack {
        VStack(spacing: 0) {
          Text(store.titele).font(.headline)

          ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
              ForEach(rooms) { item in
                CardRoomView(model: item) {
                  pendingOpenAction = { store.send(.show(item.kind)) }
                  showDoor = true
                }
              }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
          }
        }
        .background(Color.appBackground)
          if showDoor {
            DoorOpenTight(
              duration: 1.0,
              glowColor: .pink,
              world: { p in
                  Image.roomBackground // или любой твой фон/вью
                  .resizable()
                  .scaledToFill()
                  .clipped()
                  
                  LinearGradient(colors: [.white.opacity(0.12 * p), .clear],
                                    startPoint: .leading, endPoint: .trailing)
                       .blur(radius: 24)
              },
              onFinished: {
                showDoor = false
                pendingOpenAction?()
                pendingOpenAction = nil
              }
            )
            .transition(.opacity)
            .zIndex(1)
          }
      }
      .fullScreenCover(item: $store.scope(state: \.dating, action: \.dating)) { store in
        DatingRoomView(store: store)
      }
      .fullScreenCover(item: $store.scope(state: \.family, action: \.family)) { store in
        FamilyRoomView(store: store)
      }
      .fullScreenCover(item: $store.scope(state: \.coach, action: \.coach)) { store in
        CoachRoomView(store: store)
      }
      .fullScreenCover(item: $store.scope(state: \.friend, action: \.friend)) { store in
        FrieendRoomView(store: store)
      }
    }
}


//#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea()
////        CardRoomView(model: /*<#T##RomeCardRoomModel#>*/)
//    }
////}


