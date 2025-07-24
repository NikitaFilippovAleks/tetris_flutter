import 'package:flutter/material.dart';
import 'package:tetris_flutter/app/context_ext.dart';

/// Поле для ввода имени пользователя
/// с кнопкой, запускающей процесс его создания
class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  /// Контроллер текстового поля
  /// Используется для получения текста из текстового поля
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Введите ваш никнейм:'),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Никнейм',
          ),
          controller: _controller,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Введите ваш никнейм'),
                ),
              );
              return;
            }

            /// Вызываем метод создания пользователя из кубита и
            /// передаем никнейм из текстового поля
            /// (используя контроллер)
            context.di.userCubit.createUser(_controller.text);
          },
          child: const Text('Создать пользователя'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
