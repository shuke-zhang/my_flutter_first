# my_flutter_first

first

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### 查看flutter环境
1. 终端使用命令 - `flutter doctor` 这是项目创建时的配置，如果遇到启动失败时请尽量按照这个来

```cmd
Flutter assets will be downloaded from https://storage.flutter-io.cn. Make sure you
trust this source!
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, 3.29.3, on Microsoft Windows [版本 10.0.26100.4652],
    locale zh-CN)
[√] Windows Version (Windows 11 or higher, 24H2, 2009)
[√] Android toolchain - develop for Android devices (Android SDK version 35.0.1)
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps (Visual Studio Community 2022 17.14.9 (July
    2025))
[√] Android Studio (version 2024.3)
[√] VS Code (version 1.102.0)
[√] Connected device (4 available)
[√] Network resources

• No issues found!
```
2. 查看当前电脑上连接的所有可用于运行 Flutter 项目的设备 `flutter devices`
 - 如果想要真机运行首先打开usb调试然后运行 `flutter run -d 23073RPBFC`
 - Windows 桌面窗口 `flutter run -d windows`
 - 运行到 Chrome 浏览器 `flutter run -d chrome`
 - 运行到 Edge 浏览器   `flutter run -d edge`
 - 如果直接运行 `flutter run` 则会默认启动“已连接设备列表中的第一个设备”
```cmd
Found 4 connected devices:
  23073RPBFC (mobile) • d9964ae6 • android-arm64  • Android 14 (API 34)
  Windows (desktop)   • windows  • windows-x64    • Microsoft Windows [版本
  10.0.26100.4652]
  Chrome (web)        • chrome   • web-javascript • Google Chrome 138.0.7204.101    
  Edge (web)          • edge     • web-javascript • Microsoft Edge 138.0.3351.83    

Run "flutter emulators" to list and start any available device emulators.

If you expected another device to be detected, please run "flutter doctor" to       
diagnose potential issues. You may also try increasing the time to wait for
connected devices with the "--device-timeout" flag. Visit https://flutter.dev/setup/
for troubleshooting tips.
```
