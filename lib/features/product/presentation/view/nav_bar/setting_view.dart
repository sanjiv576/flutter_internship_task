import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/provider/is_dark_theme.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  @override
  Widget build(BuildContext context) {
    final enableDarkTheme = ref.watch(isDarkThemeProvider);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Card(
          elevation: 4,
          child: ListTile(
            title: const Text('Dark Theme'),
            trailing: Switch(
                value: enableDarkTheme,
                onChanged: (value) {
                  ref.watch(isDarkThemeProvider.notifier).updateTheme(value);
                }),
          ),
        ),
      )),
    );
  }
}
