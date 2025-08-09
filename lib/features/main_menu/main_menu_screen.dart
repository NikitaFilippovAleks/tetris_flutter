import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/game_router.dart';
import 'package:tetris_flutter/features/user/presentation/user_screen.dart';
import 'package:tetris_flutter/l10n/gen/app_localizations.dart';
import 'package:tetris_flutter/main.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const UserScreen(),
                    transitionDuration: const Duration(milliseconds: 1000),
                    transitionsBuilder: (_, animation, __, child) {
                      // Пример сдвига снизу вверх
                      final offsetAnimation = Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.bounceInOut,
                      ));

                      return ScaleTransition(
                        scale: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Text(l10n.startGame),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, GameRouter.settingsRoute);
              },
              child: Text(l10n.settings),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pushNamed(context, GameRouter.leaderboardRoute);
              },
              child: Text(l10n.bestResults),
            ),
            _buildLanguageSwitcher(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSwitcher(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Column(
      children: [
        Text(
          l10n.language,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Английский язык
            _buildLanguageOption(
              context: context,
              languageCode: 'en',
              languageName: l10n.english,
              isSelected: currentLocale == 'en',
            ),
            const SizedBox(width: 16),
            // Русский язык
            _buildLanguageOption(
              context: context,
              languageCode: 'ru',
              languageName: l10n.russian,
              isSelected: currentLocale == 'ru',
            ),
          ],
        ),
      ],
    );
  }

  /// Метод принимает на вход строковый код языка,
  /// его имя и признак того,является ли язык выбранным.
  /// Если язык выбран, то он будет отображаться жирным шрифтом,
  /// а если нет - обычным
  ///
  /// При нажатии на кнопку с языком будет вызван метод
  /// [MyAppState.setLocale] для изменения языка
  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageCode,
    required String languageName,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        // Ищем ближайший к текущему контексту экземпляр класса
        // [MyAppState] и вызываем у него метод [setLocale],
        // чтобы изменить язык.
        final state = context.findAncestorStateOfType<MyAppState>();
        if (state != null) {
          state.setLocale(Locale(languageCode));
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Если язык выбран, то фон будет основным цветом,
          // если нет, то серым.
          color: isSelected
              ? Theme.of(
                  context,
                ).primaryColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          languageName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
