import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/home_page.dart';
import 'package:flutter_application_1/Pages/register_page.dart';
import 'package:flutter_application_1/Services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  bool isloading = false;

  AuthService authService = AuthService();

  Future<void> login() async {
    setState(() {
      isloading = true;
    });

    try {
      await authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successfull')));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 239, 243),

      // appBar: AppBar(
      //   title: Text("Todo"),
      //   centerTitle: true,
      //   backgroundColor: const Color.fromARGB(255, 235, 239, 243),
      // ),
      body: Column(
        children: [
          Image.asset('assets/images/todo.jpg', width: 100, height: 100),

          Center(
            child: Text(
              'Login here',
              style: TextStyle(
                color: Color.fromARGB(255, 36, 130, 207),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              //textAlign: Alignment.center,
            ),
          ),

          SizedBox(height: 10),

          // Center(
          //   child: const Text(
          //     "Welcome back you've \n       been missed!",
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          //   ),
          // ),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              children: [
                const TextSpan(text: 'Welcome back you have \n'),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'been missed',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                ),

                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: const Color.fromARGB(255, 230, 242, 248),
              ),
            ),
          ),

          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: isObscure,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.key),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue),
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

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blueAccent,
          //     foregroundColor: Colors.white,
          //     minimumSize: Size(500, 50),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //   ),
          //   child: Text('Sign in', style: TextStyle(fontSize: 15)),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isloading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: isloading
                    ? const CircularProgressIndicator()
                    : Text('Sign in'),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );
              },
              child: Text(
                'Create new account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Or continue with',
            style: TextStyle(color: Colors.blue),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
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
