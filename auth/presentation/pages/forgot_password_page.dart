import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        title: 'Забыли пароль?',
        onBack: () => Navigator.pop(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthIllustration(type: IllustrationType.forgot),
              const Text('Восстановление пароля', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Введи почту, и мы отправим код для восстановления доступа.', style: TextStyle(color: authMuted, height: 1.45)),
              const SizedBox(height: 27),
              AuthField(
                label: 'Электронная почта',
                hint: 'name@example.com',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value != null && value.contains('@') ? null : 'Введите корректную почту',
              ),
              AuthButton(
                label: 'Отправить код',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordPage(email: _email.text)));
                  }
                },
              ),
            ],
          ),
        ),
      );
}
