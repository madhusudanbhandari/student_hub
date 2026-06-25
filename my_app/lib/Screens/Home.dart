import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_app/screens/Login.dart';
import 'Notes.dart';
import 'Tasks.dart';
import 'Profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        title: const Text(
          'Student Hub',
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back 👋',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              ),
              const SizedBox(height: 4),
              const Text(
                'What would you like to do?',
                style: TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),
              _NavCard(
                icon: Icons.notes_rounded,
                label: 'Notes',
                description: 'View and manage your notes',
                iconColor: const Color(0xFF818CF8),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Notes()),
                ),
              ),
              const SizedBox(height: 16),
              _NavCard(
                icon: Icons.check_circle_outline_rounded,
                label: 'Tasks',
                description: 'Track your to-dos and deadlines',
                iconColor: const Color(0xFF34D399),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TasksScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _NavCard(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                description: 'Edit your account details',
                iconColor: const Color(0xFF60A5FA),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFFF6B6B),
                    size: 18,
                  ),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      color: Color(0xFFFF6B6B),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: Color(0x33FF6B6B),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color iconColor;
  final VoidCallback onTap;

  const _NavCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Color(0xFFE2E8F0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF475569),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
