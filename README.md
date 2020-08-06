## KIRA IDO Explorer

An IDO is a crowdfunding mechanism where investors place their existing tokens or assets at stake using one or many PoS networks to “interchain-mine” a new token instead of liquidating their valuable assets to acquire new, highly speculative tokens.

The IDO Explorer is the interface behind this new crowdfunding mechanism.

**Warning:** This is build using Flutter SDK, which is fairly new and hasn't achieved full web support yet, however we are still adapting it and make it very useful.

### Getting started with this product

Ensure you are running the latest stable flutter sdk, setup the editor and installed packages. References:

- [Online documentation](https://flutter.dev/docs)
- [Installing Flutter](https://flutter.dev/docs)

Upgrade flutter and diagnosis

```
flutter upgrade
flutter doctor
flutter doctor -v -more detailed
```

Enable web support

```
flutter config --enable-web
```

Download dependencies

```
flutter pub get
```

Run debug mode with hot reloading (dynamic mode without needing to consistency run a project after minimal changes) -> switch to debug console. -> (while on a dart file e.g. main.dart)

```
ctrl + f5 -> Dart & Flutter
```

Run application (while on a dart file e.g. main.dart)

```
flutter run -d chrome
```

Build project for web
Once deployed for production, head to build folder -> web. Everything inside web folder is what is pushed to github which renders the web app.

```
flutter build web
```

FYI: For the most part, you will be interacting with the Lib folder, and Pubspec.yaml (for dependecies and assets).
The other folders are compilers to Android, IOS or Web e.g. Assets is for images used (any new images get added here and mentioned on Pubspec.yaml).
Lib folder contains main UI screen, which is composed on [widgets] from the widgets folder, Modals and Services.
