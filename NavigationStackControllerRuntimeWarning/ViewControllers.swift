//
//  ViewController.swift
//  NavigationStackControllerRuntimeWarning
//
//  Created by Andres Guzman-Ballen on 8/20/24.
//

import ComposableArchitecture
import SnapKit
import UIKit

class AppViewController: NavigationStackController {
  private var store: StoreOf<AppMain>!

  convenience init(store: StoreOf<AppMain>) {
    @UIBindable var store = store

    self.init(path: $store.scope(state: \.path, action: \.path)) {
      RootViewController(
        store: store.scope(state: \.root, action: \.root)
      )
    } destination: { store in
      switch store.case {
      case let .game(store):
        GameViewController(store: store)

      case let .settings(store):
        SettingsViewController(store: store)
      }
    }

    self.store = store
  }
}

class RootViewController: UIViewController {
  private let store: StoreOf<Root>

  init(store: StoreOf<Root>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    title = "Root"
    view.backgroundColor = UIColor.white

    let gameButton = UIButton(frame: .zero)
    gameButton.setTitle("Game", for: .normal)
    gameButton.setTitleColor(.black, for: .normal)
    gameButton.addAction(.init { [weak self] _ in
      self?.store.send(.gameButtonTapped)
    }, for: .touchUpInside)
    view.addSubview(gameButton)
    gameButton.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).multipliedBy(0.5)
    }

    let settingsButton = UIButton(frame: .zero)
    settingsButton.setTitle("Settings", for: .normal)
    settingsButton.setTitleColor(.black, for: .normal)
    settingsButton.addAction(.init { [weak self] _ in
      self?.store.send(.settingsButtonTapped)
    }, for: .touchUpInside)
    view.addSubview(settingsButton)
    settingsButton.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).multipliedBy(1.5)
    }
  }
}

class GameViewController: UIViewController {
  private let store: StoreOf<Game>

  init(store: StoreOf<Game>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    title = "Game"
    view.backgroundColor = UIColor.systemOrange

    let button = UIButton(frame: .zero)
    button.setTitle("Game Button", for: .normal)
    button.addAction(.init { [weak self] _ in
      self?.store.send(.gameButtonTapped)
    }, for: .touchUpInside)
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
}

class SettingsViewController: UIViewController {
  private let store: StoreOf<Settings>

  init(store: StoreOf<Settings>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    title = "Settings"
    view.backgroundColor = UIColor.systemBlue

    let button = UIButton(frame: .zero)
    button.setTitle("Is On Button", for: .normal)
    button.addAction(.init { [weak self] _ in
      self?.store.send(.isOnButtonTapped)
    }, for: .touchUpInside)
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
}

