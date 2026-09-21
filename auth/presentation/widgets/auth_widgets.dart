import 'package:flutter/material.dart';

const authGreen = Color(0xFF8BC63F);
const authText = Color(0xFF242424);
const authMuted = Color(0xFF8D939A);

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, required this.child, this.onBack});

  final String title;
  final Widget child;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: authText,
        leading: onBack == null
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: onBack,
              ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

enum IllustrationType { welcome, login, forgot }

class AuthIllustration extends StatelessWidget {
  const AuthIllustration({super.key, this.type = IllustrationType.welcome});

  final IllustrationType type;

  @override
  Widget build(BuildContext context) {
    final icon = switch (type) {
      IllustrationType.welcome => Icons.eco_outlined,
      IllustrationType.login => Icons.lock_open_outlined,
      IllustrationType.forgot => Icons.lock_reset_outlined,
    };

    return Container(
      height: 148,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 17),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(left: 35, top: 22, child: _Dot(size: 12)),
          const Positioned(right: 42, bottom: 28, child: _Dot(size: 8)),
          Icon(icon, color: authGreen, size: 82),
          Positioned(
            bottom: 17,
            child: Text(
              type == IllustrationType.welcome
                  ? 'Начни с заботы о себе'
                  : 'Ты уже почти внутри',
              style: const TextStyle(
                color: authGreen,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Icon(
        Icons.circle,
        color: const Color(0xFFC5E59B),
        size: size,
      );
}

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    this.validator,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(fontSize: 15, color: authText),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: suffix,
          labelStyle: const TextStyle(color: authMuted, fontSize: 14),
          hintStyle: const TextStyle(color: authMuted, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFFAFBFC),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFE4E8EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFE4E8EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: authGreen, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.label, required this.onPressed, this.enabled = true});

  final String label;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 51,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: authGreen,
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xFFE5E8EA),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          ),
          child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
      );
}

class AuthLink extends StatelessWidget {
  const AuthLink({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: authGreen, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      );
}

String? requiredField(String? value) => value == null || value.trim().isEmpty ? 'Заполните поле' : null;
