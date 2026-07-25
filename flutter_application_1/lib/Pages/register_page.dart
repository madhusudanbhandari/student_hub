import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/add_todo.dart';
import 'package:flutter_application_1/Services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscure = true;
  bool isconfirmObscure = true;
  bool isloading = false;

  final AuthService authService = AuthService();

  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords did not match')));
    }

    setState(() {
      isloading = true;
    });

    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration successfull')));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Create Account',
      //     style: TextStyle(color: Colors.blue, fontSize: 20),
      //   ),
      // ),
      backgroundColor: const Color.fromARGB(255, 235, 239, 243),
      body: Column(
        children: [
          SizedBox(height: 40),
          Center(
            child: Text(
              'Create account',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          SizedBox(height: 15),

          // Center(
          //   child: Text(
          //     'Create an account so you can explore all the \n                     existing jobs',
          //     style: TextStyle(color: Colors.black),
          //   ),
          // ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                const TextSpan(
                  text: "Create an account so you can explore all \n",
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 75),
                    child: Text(
                      'existing jobs',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 50),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 230, 242, 248),
              ),
            ),
          ),
          const SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 230, 242, 248),
              ),
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: isconfirmObscure,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isconfirmObscure = !isconfirmObscure;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 230, 242, 248),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isloading ? null : register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: isloading
                    ? const CircularProgressIndicator()
                    : Text('Sign up'),
              ),
            ),
          ),
          SizedBox(height: 10),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Already have an account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              'Or continue with',
              style: TextStyle(color: const Color.fromARGB(255, 15, 114, 196)),
            ),
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.g_mobiledata),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.facebook),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.apple)),
            ],
          ),
        ],
      ),
    );
  }
}
