import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.email});

  final String? email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _visible = false;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        title: 'Новый пароль',
        onBack: () => Navigator.pop(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthIllustration(type: IllustrationType.forgot),
              const Text('Придумай новый пароль', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Пароль должен содержать не менее 8 символов.', style: TextStyle(color: authMuted)),
              const SizedBox(height: 26),
              AuthField(
                label: 'Новый пароль',
                controller: _password,
                obscureText: !_visible,
                suffix: IconButton(
                  icon: Icon(_visible ? Icons.visibility : Icons.visibility_off, color: authMuted),
                  onPressed: () => setState(() => _visible = !_visible),
                ),
                validator: (value) => value != null && value.length >= 8 ? null : 'Минимум 8 символов',
              ),
              AuthField(
                label: 'Повтори пароль',
                controller: _confirm,
                obscureText: !_visible,
                validator: (value) => value == _password.text ? null : 'Пароли не совпадают',
              ),
              AuthButton(
                label: 'Сохранить пароль',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
