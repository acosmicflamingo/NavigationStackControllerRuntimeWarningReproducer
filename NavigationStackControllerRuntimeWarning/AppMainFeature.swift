import ComposableArchitecture

@Reducer
struct AppMain {
  @Reducer(state: .equatable)
  enum Path {
    case game(Game)
    case settings(Settings)
  }

  @ObservableState
  struct State: Equatable {
    var root: Root.State
    var path: StackState<Path.State>
  }

  enum Action {
    case root(Root.Action)
    case path(StackActionOf<Path>)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.root, action: \.root) {
      Root()
    }
    Reduce<State, Action> { state, action in
      switch action {
      case .root:
        return .none
        
      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

@Reducer
struct Root {
  @ObservableState
  struct State: Equatable {
    var foo: Bool = false
  }

  enum Action {
    case gameButtonTapped
    case settingsButtonTapped
  }

  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .gameButtonTapped:
        return .none

      case .settingsButtonTapped:
        return .none
      }
    }
  }
}

@Reducer
struct Game {
  @ObservableState
  struct State: Equatable {
    var hasStarted: Bool = false
  }

  enum Action {
    case gameButtonTapped
  }

  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .gameButtonTapped:
        state.hasStarted.toggle()
        return .none
      }
    }
  }
}

@Reducer
struct Settings {
  @ObservableState
  struct State: Equatable {
    var isOn: Bool = false
  }

  enum Action {
    case isOnButtonTapped
  }

  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .isOnButtonTapped:
        state.isOn.toggle()
        return .none
      }
    }
  }
}
