import 'package:golden_house/Helpers/res/user_data.dart';
import 'package:golden_house/Stacks/Auth/Controllers/auth_controller.dart';
import 'package:golden_house/Stacks/Auth/Screens/signup.dart';
import 'package:golden_house/Helpers/Widgets/e1_button.dart';
import 'package:golden_house/Helpers/Widgets/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golden_house/Stacks/User/Screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> goodToGo = GlobalKey<FormState>();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> login() async {
    final email = userEmail.text;
    final password = userPassword.text;
    try {
      await authService.login(email, password);
      user_uid = authService.getCurrentUserUid();
      user_email = authService.getCurrentUserEmail();
      user_Data = await authService.getData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally{
      Get.to( MainScreen(userData: user_Data,));
    }
  }

  // Password Visibility Icons
  bool _hidePassword = true;
  Widget get _passwordIcon => GestureDetector(
        onTap: () {
          setState(() {
            _hidePassword = !_hidePassword;
          });
        },
        child: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/icons/Ellipse 66.png",
                scale: .8,
              ),
              if (!_hidePassword) Image.asset("assets/icons/Ellipse 65.png"),
            ],
          ),
        ),
      );

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
                  const SizedBox(
                    height: 43,
                  ),
                  SizedBox(
                    width: 149,
                    height: 157,
                    child:
                        Image.asset("assets/images/logo_raw.jpg"),
                  ),
                  const SizedBox(
                    height: 56,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Log In your ",
                          style: GoogleFonts.oxygen(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        TextSpan(
                          text: "Account",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle tap event
                            },
                          style: GoogleFonts.oxygen(
                            color: const Color(0xFFED2C67),
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            // decoration: TextDecoration
                            //     .underline, // Optional: Underline clickable text
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 28,
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
                    controller: userPassword,
                    hintText: "Enter your Password",
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) return "Password required";
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 28,
                  ), E1Button(
                          gradient: const LinearGradient(
                              colors: [Color(0xFFED2C67), Color(0xFF3B0919)]),
                          text: "Log In",
                          size: 15,
                          textColor: Colors.white,
                          onPressed: () {
                            login();
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
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFieldWidget(
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
            _buildSocialIcon("assets/icons/pinterest.png"),
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
          _buildTextSpan("Don't have an Account? ", Colors.white),
          TextSpan(
            text: "Sign Up",
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offAll(const SignUp()),
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
