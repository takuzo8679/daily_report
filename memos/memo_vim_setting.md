# vimtutorが終わった人向けの推奨設定

## はじめに




## コマンド

### InsertMode中にctrl + hjklで移動

1. ⌘+K,⌘+Sでキーボードショートカットを開き、左上の上のファイルアイコンから`keybindings.json`を開く
1. 下記のコマンドを追加する

```
    { "key": "ctrl+l","command": "cursorRight","when":"textInputFocus" },
    { "key": "ctrl+h","command": "cursorLeft","when": "textInputFocus" },
    { "key": "ctrl+k","command": "cursorUp","when": "textInputFocus" },
    { "key": "ctrl+j","command": "cursorDown","when": "textInputFocus" }
```

参考：[VSCodeでVim風のカーソル移動](https://qiita.com/kotap15/items/4bee8cc0bca6a9487e4e)

## 終わりに



