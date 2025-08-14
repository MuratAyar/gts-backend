// lib/auth_gateway.dart
import 'package:flutter/material.dart';

class AuthGatewayPage extends StatefulWidget {
  final int initialTab; // 0 = Login, 1 = Sign Up
  const AuthGatewayPage({super.key, this.initialTab = 0});

  @override
  State<AuthGatewayPage> createState() => _AuthGatewayPageState();
}

class _AuthGatewayPageState extends State<AuthGatewayPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // Form controller’ları (demo amaçlı)
  final _loginEmail = TextEditingController();
  final _loginPass = TextEditingController();

  final _signName = TextEditingController();
  final _signEmail = TextEditingController();
  final _signPhone = TextEditingController();
  final _signPass = TextEditingController();
  final _signPass2 = TextEditingController();

  bool _rememberMe = false;
  bool _termsOk = false;
  bool _obscureLogin = true;
  bool _obscureSign = true;
  bool _obscureSign2 = true;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this, initialIndex: widget.initialTab.clamp(0, 1),);
  }

  @override
  void dispose() {
    _tab.dispose();
    _loginEmail.dispose();
    _loginPass.dispose();
    _signName.dispose();
    _signEmail.dispose();
    _signPhone.dispose();
    _signPass.dispose();
    _signPass2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const bg = Color(0xFFF8F9FC); // slate-50
    const chipBg = Color(0xFFE7EDF4); // input bg
    const border = Color(0xFFCEDBE8);
    const dark = Color(0xFF0D141C);
    const hint = Color(0xFF49739C);
    const primary = Color(0xFF143DB8);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Üst bar: Sol geri, ortada başlık
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back),
                    color: dark,
                    tooltip: 'Geri',
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'GTS Cranes',
                      style: TextStyle(
                        color: dark,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // sağ denge
                ],
              ),
            ),

            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Welcome to GTS Cranes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: dark,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Find the perfect crane for your project',
                textAlign: TextAlign.center,
                style: TextStyle(color: dark),
              ),
            ),
            const SizedBox(height: 12),

            // Tab başlıkları (Login / Sign Up)
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: border)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tab,
                labelColor: dark,
                unselectedLabelColor: hint,
                indicatorColor: theme.colorScheme.primary,
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.15,
                ),
                tabs: const [
                  Tab(text: 'Login'),
                  Tab(text: 'Sign Up'),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  // ----- LOGIN -----
                  _CardMax480(
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'Email',
                          child: TextField(
                            controller: _loginEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                        _LabeledField(
                          label: 'Password',
                          child: TextField(
                            controller: _loginPass,
                            obscureText: _obscureLogin,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => _obscureLogin = !_obscureLogin),
                                icon: Icon(_obscureLogin
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              activeColor: primary,
                              onChanged: (v) =>
                                  setState(() => _rememberMe = v ?? false),
                            ),
                            const Text('Remember me'),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // TODO: Forgot password sayfasına gidebilirsin
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: FilledButton(
                            onPressed: () {
                              // TODO: Auth işlemi; başarıda Navigator.pop(context);
                            },
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => _tab.animateTo(1),
                          child: const Text("Don't have an account? Sign up"),
                        ),
                      ],
                    ),
                  ),

                  // ----- SIGN UP -----
                  _CardMax480(
                    child: Column(
                      children: [
                        _LabeledField(
                          label: 'Full Name',
                          child: TextField(
                            controller: _signName,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Enter your name',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                        _LabeledField(
                          label: 'Email',
                          child: TextField(
                            controller: _signEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                        _LabeledField(
                          label: 'Phone',
                          child: TextField(
                            controller: _signPhone,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              hintText: '5xx xxx xx xx',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),
                        _LabeledField(
                          label: 'Password',
                          child: TextField(
                            controller: _signPass,
                            obscureText: _obscureSign,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Create a password',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => _obscureSign = !_obscureSign),
                                icon: Icon(_obscureSign
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                        _LabeledField(
                          label: 'Confirm Password',
                          child: TextField(
                            controller: _signPass2,
                            obscureText: _obscureSign2,
                            decoration: InputDecoration(
                              hintText: 'Retype your password',
                              filled: true,
                              fillColor: chipBg,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => _obscureSign2 = !_obscureSign2),
                                icon: Icon(_obscureSign2
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Checkbox(
                              value: _termsOk,
                              activeColor: primary,
                              onChanged: (v) =>
                                  setState(() => _termsOk = v ?? false),
                            ),
                            const Expanded(
                              child: Text(
                                  'I accept the Terms and Conditions.'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: FilledButton(
                            onPressed: _termsOk
                                ? () {
                                    // TODO: Kayıt işlemi; başarıda Navigator.pop(context);
                                  }
                                : null,
                            child: const Text('Sign Up'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => _tab.animateTo(0),
                          child: const Text('Already have an account? Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ------- yardımcı layout / bileşenler --------

class _CardMax480 extends StatelessWidget {
  final Widget child;
  const _CardMax480({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFCEDBE8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF0D141C);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: dark, fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: child,
          ),
        ],
      ),
    );
  }
}
