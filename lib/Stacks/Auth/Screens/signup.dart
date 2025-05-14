import 'package:golden_house/Helpers/res/user_data.dart';
import 'package:golden_house/Stacks/Auth/Controllers/auth_controller.dart';
import 'package:golden_house/Stacks/Auth/Screens/signin.dart';
import 'package:golden_house/Helpers/Widgets/e1_button.dart';
import 'package:golden_house/Helpers/Widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> goodToGo = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  
  AuthService authService = AuthService();

  Future<void> register() async {
    final email = userEmail.text;
    final password = userPassword.text;
    try {
      await authService.register(email, password);
      user_uid = await authService.getCurrentUserUid();
      await authService.saveUserData(userEmail.text, username.text, userPassword.text, user_uid);
      Get.to(SignIn());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  bool _hidePassword = true;

  Widget get _passwordIcon => GestureDetector(
        onTap: () => setState(() => _hidePassword = !_hidePassword),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/icons/Ellipse 66.png", scale: .8),
              if (!_hidePassword) Image.asset("assets/icons/Ellipse 65.png"),
            ],
          ),
        ),
      );

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password Required";

    bool hasUpper = value.contains(RegExp(r'[A-Z]'));
    bool hasLower = value.contains(RegExp(r'[a-z]'));
    bool hasNumber = value.contains(RegExp(r'[0-9]'));
    bool hasSpecial = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUpper) return "Capital Letter Required";
    if (!hasLower) return "Small Letter Required";
    if (!hasNumber) return "Number Required";
    if (!hasSpecial) return "Special Character Required";
    if (value.length < 8) return "At least 8 characters Required";
    if (userPassword.text != confirm.text) return "Passwords do not match";

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SingleChildScrollView(
          child: Form(
            key: goodToGo,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(31.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 149,
                      height: 157,
                      child:
                          Image.asset("assets/images/logo_raw.jpg"),
                    ),
                    const SizedBox(height: 35),
                    RichText(
                      text: TextSpan(
                        children: [
                          _buildTextSpan("Sign Up your ", Colors.white),
                          _buildTextSpan("Account", const Color(0xFFED2C67)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    _buildTextField(
                      controller: username,
                      hintText: "Enter your username",
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (!RegExp(r'^[A-Z][a-z]').hasMatch(value!)) {
                          return "Start with a Capital letter";
                        }
                        if (value.isEmpty) return "Username required";
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: userEmail,
                      hintText: "Enter your Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!value!.endsWith("@gmail.com")) {
                          return "Invalid email";
                        }
                        if (value.isEmpty) return "Email required";
                        return null;
                      },
                    ),
                    _buildTextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: userPassword,
                      hintText: "Enter your Password",
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    _buildTextField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirm,
                      hintText: "Confirm your Password",
                      isPassword: true,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 25), E1Button(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFED2C67), Color(0xFF3B0919)],
                            ),
                            text: "Sign Up",
                            size: 15,
                            textColor: Colors.white,
                            onPressed: () {
                              if (goodToGo.currentState!.validate()) {
                                register();
                              }
                            },
                          ),
                    const SizedBox(height: 25),
                    _buildDivider(),
                    _buildSocialLogin(),
                    const SizedBox(height: 25),
                    _buildLoginPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFieldWidget(
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        cursorColor: const Color(0xFFED2C67),
        textColor: Colors.white,
        controller: controller,
        focusBorderColor: const Color(0xFFED2C67),
        fillColor: Colors.transparent,
        errorBorderColor: Colors.red,
        borderColor: const Color(0xFFED2C67),
        hintText: hintText,
        hintColor: const Color(0xFF949494),
        curve: 20,
        hidePassword: isPassword ? _hidePassword : false,
        validate: validator,
        suffixIcon: isPassword ? _passwordIcon : null,
      ),
    );
  }

  Widget _buildDivider() {
    return Text(
      "-- OR --",
      style: GoogleFonts.oxygen(
        color: const Color(0xFFED2C67),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Text(
          "Sign Up with:",
          style: GoogleFonts.oxygen(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 17),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon("assets/icons/google.png"),
            _buildSocialIcon("assets/icons/facebook.png"),
            _buildSocialIcon("assets/icons/pintrest.png"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.5),
      child: Image.asset(assetPath, width: 31, height: 31),
    );
  }

  Widget _buildLoginPrompt() {
    return RichText(
      text: TextSpan(
        children: [
          _buildTextSpan("Already have an Account? ", Colors.white),
          TextSpan(
            text: "Log In",
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offAll(const SignIn()),
            style: GoogleFonts.oxygen(
              color: const Color(0xFFED2C67),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan(String text, Color color) {
    return TextSpan(
      text: text,
      style: GoogleFonts.oxygen(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}
