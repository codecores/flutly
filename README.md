# Flutly

Flutly is a modern and customizable library providing widgets and tools for Flutter applications. It offers flexible and user-friendly components that streamline the UI development process.

## Features

- **FlutlyApp**: Core configuration and theme settings used throughout the application.
- **FlutlyAppBar**: Animated and customizable `AppBar`.
- **FlutlyBottomBar**: Customizable and animated bottom bar.
- **FlutlyText**: Dynamic and rich text formatting options.
- **FlutlyTextfield**: Customizable text field component.
- **FlutlyButton**: Flexible and customizable buttons.
- **FlutlyDialog**: Customizable dialog windows.
- **FlutlyToast**: Customizable toast notifications for user messages.
- **FlutlyTheme**: Theme and style management for the application.

## Getting Started

### Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  flutly: ^1.0.0
```

Then, run `flutter pub get` in your terminal to add the library to your project.

### Usage

#### FlutlyApp

```dart
import 'package:flutly/flutly.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flutly.setup(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutlyApp(
      title: 'Flutter Demo',
      appBar: FlutlyAppBar(
        animated: true,
        color: Colors.blue,
      ),
      bottomBar: FlutlyBottomBar(
        height: 60,
        items: [
          FlutlyBottomBarItem(
            page: FlutlyPage(
              name: "Home",
              page: const HomePage(),
            ),
            activePath: SvgPicture.asset("assets/home_active.svg"),
          ),
          // Other tabs...
        ],
      ),
      pages: [
        FlutlyPage(name: "Home", page: const HomePage()),
        // Other pages...
      ],
    );
  }
}
```

#### FlutlyText

```dart
import 'package:flutly/widgets/flutly_text.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutlyText(
          "Hello World",
          font: "headline1",
        ),
      ),
    );
  }
}
```

#### FlutlyButton

```dart
import 'package:flutly/widgets/flutly_button.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutlyButton(
          onTap: () {
            // Button tap action
          },
          text: "Click Me",
        ),
      ),
    );
  }
}
```

## Documentation

For more information and detailed documentation, please visit the [Flutly Documentation](https://github.com/username/flutly) page.

## Contributing

We welcome contributions! Please read the [Contributing Guide](CONTRIBUTING.md) and reach out before submitting a pull request.

## License

This project is licensed under the MIT License. For more information, please see the [License File](LICENSE).

---

This file provides essential information and examples for your library, making it accessible and understandable for users and developers. Feel free to customize it according to your project needs.