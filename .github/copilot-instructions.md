# TCATutorial - Copilot Instructions

## プロジェクト概要

このプロジェクトは **The Composable Architecture (TCA)** を使用した SwiftUI iOS アプリケーションのチュートリアルです。カウンター機能を持つタブベースのアプリを実装しています。

## 技術スタック

- **言語**: Swift
- **UI フレームワーク**: SwiftUI
- **アーキテクチャ**: The Composable Architecture (TCA) by Point-Free
- **テストフレームワーク**: XCTest, Swift Testing
- **最小iOS バージョン**: iOS 17+（@Observable マクロ使用のため）

## 依存関係

- [swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture) - TCA フレームワーク
- [swift-testing](https://github.com/apple/swift-testing) - Swift Testing フレームワーク

## アーキテクチャパターン

### TCA の基本構造

各機能（Feature）は以下の構成要素を持ちます：

1. **Reducer** (`@Reducer` マクロ付き struct)
2. **State** (`@ObservableState` マクロ付き、`Equatable` 準拠)
3. **Action** (enum)
4. **body** (`Reduce` クロージャ内でロジックを記述)

### ファイル命名規則

- **Feature ファイル**: `<機能名>Feature.swift` (例: `CounterFeature.swift`, `AppFeature.swift`)
- **View ファイル**: `<機能名>View.swift` (例: `CounterView.swift`, `AppView.swift`)

### コード例

```swift
@Reducer
struct ExampleFeature {
    @ObservableState
    struct State: Equatable {
        var value = 0
    }
    
    enum Action {
        case buttonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                state.value += 1
                return .none
            }
        }
    }
}
```

## ディレクトリ構造

```
TCATutorial/
├── TCATutorial/
│   ├── TCATutorialApp.swift    # アプリエントリーポイント
│   ├── AppFeature.swift        # ルート Reducer（タブ管理）
│   ├── AppView.swift           # ルート View（TabView）
│   ├── CounterFeature.swift    # カウンター機能の Reducer
│   ├── CounterView.swift       # カウンター機能の View
│   └── Assets.xcassets/
├── TCATutorialTests/
│   ├── TCATutorialTests.swift
│   └── TCATutorialCounterTests.swift
└── TCATutorialUITests/
```

## コーディング規約

### State

- `@ObservableState` マクロを使用
- `Equatable` に準拠
- プロパティはデフォルト値を持たせる

### Action

- ボタンタップは `<動作>ButtonTapped` 命名（例: `incrementButtonTapped`）
- レスポンス処理は `<処理名>Response` 命名（例: `factResponse`）

### Side Effects

- 非同期処理は `.run` エフェクトを使用
- キャンセル可能なエフェクトには `CancelID` enum を定義
- State への直接変更は `.run` 内では不可（`send` 経由でアクションを発行）

### View

- `StoreOf<Feature>` 型の `store` プロパティを持つ
- `store.send(.action)` でアクションを発行
- `store.scope` を使用して子 Feature に Store を渡す

## テスト

### TCA テスト

- `TestStore` を使用
- `@MainActor` 属性を付与
- `await store.send(.action) { $0.property = expectedValue }` パターン

```swift
@MainActor
struct FeatureTests {
    @Test
    func example() async {
        let store = TestStore(initialState: Feature.State()) {
            Feature()
        }
        await store.send(.action) {
            $0.value = expectedValue
        }
    }
}
```

## 注意事項

- `_printChanges()` は開発時のデバッグ用（本番ではコメントアウト）
- 外部 API 呼び出し（numbersapi.com）は HTTP を使用するため、Info.plist での ATS 設定が必要
