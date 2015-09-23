# WebViewPDFViewer
When you tap next button, PDF page go forward.
WebView で PDF を表示。2つのボタン押下でページめくり実装。

**If you have some trouble(Xcode7), please re-input ATS setting. **
もしPDFが表示されない場合は Xcode 7 で再度 ATS の設定をやり直せば動きます。

Xcode 6

```
<key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
     </dict>
```

Xcode 7(Name is different a little.)

```
App Transport Security Settings
Allow Arbitrary Loads: YES

```

Thanks.
