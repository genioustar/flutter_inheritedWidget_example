import 'package:flutter/material.dart';

class UserSettings {
  bool isDarkMode;
  UserSettings({this.isDarkMode = false});
}

class DarkmodeInheritedWidgetExample extends StatefulWidget {
  const DarkmodeInheritedWidgetExample({super.key});

  @override
  State<DarkmodeInheritedWidgetExample> createState() =>
      _DarkmodeInheritedWidgetExampleState();
}

class _DarkmodeInheritedWidgetExampleState
    extends State<DarkmodeInheritedWidgetExample> {
  UserSettings _userSettings = UserSettings();

  void _toggleDarkMode(bool isDarkMode) {
    print('Dark mode: $isDarkMode');
    setState(() {
      _userSettings = UserSettings(isDarkMode: isDarkMode);
      // 아래처럼 하면 안되는 이유는 updateShouldNotify는 기본적으로 새로 전달된 데이터와 이전 데이터를 비교하여 상태 변경을 감지함
      // 그러나 InheritedWidget 내부의 데이터가 변경되더라도 InheritedWidget 자체가 변경되지 않으면 업데이트를 감지하지 못할
      // 즉, 아래코드는 기존 InheritedWidget의 값을 변경하기 때문에 oldWidget의 값만 계속 변경하고 있는것임!
      // _userSettings.isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: _userSettings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('User Setting InheritedWidget Example'),
          ),
          body: UserSettingsInheritedWidget(
            userSettings: _userSettings,
            toggleDarkMode: _toggleDarkMode,
            child: const Center(
              child: SettingsWidget(),
            ),
          ),
        ),
      );
}

class UserSettingsInheritedWidget extends InheritedWidget {
  final UserSettings userSettings;
  final void Function(bool) toggleDarkMode;

  const UserSettingsInheritedWidget({
    super.key,
    required this.userSettings,
    required this.toggleDarkMode,
    required super.child,
  });

  static UserSettingsInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UserSettingsInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(covariant UserSettingsInheritedWidget oldWidget) {
    return oldWidget.userSettings.isDarkMode != userSettings.isDarkMode;
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = UserSettingsInheritedWidget.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'Dark Mode: ${inheritedWidget.userSettings.isDarkMode ? 'On' : 'Off'}'),
        // 이 Switch문을 통할때 InheritedWidget이 새로운 인스턴스로 생성됨.
        Switch(
          value: inheritedWidget.userSettings.isDarkMode,
          onChanged: inheritedWidget.toggleDarkMode,
        ),
      ],
    );
  }
}
