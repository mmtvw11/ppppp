import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _showPassword = false;
  bool _showConfirm = false;
  String _country = 'Россия';

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Регистрация',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthIllustration(),
            const Text('Создай аккаунт', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
            const SizedBox(height: 7),
            const Text('Это займёт всего пару минут', style: TextStyle(color: authMuted, fontSize: 14)),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _country,
              decoration: const InputDecoration(
                labelText: 'Откуда ты?',
                prefixIcon: Icon(Icons.public),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Россия', child: Text('Россия')),
                DropdownMenuItem(value: 'Казахстан', child: Text('Казахстан')),
                DropdownMenuItem(value: 'Беларусь', child: Text('Беларусь')),
              ],
              onChanged: (value) => setState(() => _country = value ?? _country),
            ),
            const SizedBox(height: 15),
            AuthField(
              label: 'Электронная почта',
              hint: 'name@example.com',
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value != null && value.contains('@') ? null : 'Введите корректную почту',
            ),
            AuthField(
              label: 'Пароль',
              hint: 'Минимум 8 символов',
              controller: _password,
              obscureText: !_showPassword,
              suffix: IconButton(
                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: authMuted),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
              validator: (value) => value != null && value.length >= 8 ? null : 'Минимум 8 символов',
            ),
            AuthField(
              label: 'Повтори пароль',
              controller: _confirm,
              obscureText: !_showConfirm,
              suffix: IconButton(
                icon: Icon(_showConfirm ? Icons.visibility : Icons.visibility_off, color: authMuted),
                onPressed: () => setState(() => _showConfirm = !_showConfirm),
              ),
              validator: (value) => value == _password.text ? null : 'Пароли не совпадают',
            ),
            const SizedBox(height: 6),
            AuthButton(
              label: 'Продолжить',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Подключите существующий register use case без изменения backend.
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Уже есть аккаунт?', style: TextStyle(color: authMuted)),
                AuthLink(
                  text: 'Войти',
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
