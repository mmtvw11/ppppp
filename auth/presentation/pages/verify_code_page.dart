import 'package:flutter/material.dart';
import '../widgets/auth_widgets.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key, this.email});

  final String? email;

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AuthScaffold(
        title: 'Введите код',
        onBack: () => Navigator.pop(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthIllustration(type: IllustrationType.login),
            const Text('Проверь почту', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Мы отправили код на ${widget.email ?? 'твою почту'}', style: const TextStyle(color: authMuted)),
            const SizedBox(height: 28),
            TextField(
              controller: _code,
              maxLength: 6,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, letterSpacing: 14, fontWeight: FontWeight.w700),
              decoration: const InputDecoration(counterText: '', hintText: '••••••', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            AuthButton(label: 'Подтвердить', onPressed: () {}),
            const SizedBox(height: 10),
            Center(child: AuthLink(text: 'Отправить код ещё раз', onPressed: () {})),
          ],
        ),
      );
}
