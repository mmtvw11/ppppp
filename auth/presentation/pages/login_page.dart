import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        title: 'Войти',
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthIllustration(type: IllustrationType.login),
              const Text('С возвращением!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(height: 7),
              const Text('Войди, чтобы продолжить', style: TextStyle(color: authMuted, fontSize: 14)),
              const SizedBox(height: 25),
              AuthField(
                label: 'Электронная почта',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.contains('@') ? null : 'Введите корректную почту',
              ),
              AuthField(
                label: 'Пароль',
                controller: _password,
                obscureText: !_showPassword,
                suffix: IconButton(
                  icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: authMuted),
                  onPressed: () => setState(() => _showPassword = !_showPassword),
                ),
                validator: requiredField,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AuthLink(
                  text: 'Забыли пароль?',
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())),
                ),
              ),
              const SizedBox(height: 7),
              AuthButton(
                label: 'Войти',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Подключите существующий login use case без изменения backend.
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Нет аккаунта?', style: TextStyle(color: authMuted)),
                  AuthLink(
                    text: 'Зарегистрироваться',
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
