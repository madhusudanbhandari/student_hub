import 'package:flutter/material.dart';
import '../Services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileService = ProfileService();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final collegeController = TextEditingController();
  final bioController = TextEditingController();

  bool isLoading = false;
  bool isEditing = false;
  bool isFetching = true;
  Map<String, dynamic>? profile;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    collegeController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> getProfile() async {
    setState(() => isFetching = true);
    final response = await profileService.getProfile();
    if (!mounted) return;
    setState(() {
      profile = response;
      isFetching = false;
      if (profile != null) {
        usernameController.text = profile!['username'] ?? '';
        emailController.text = profile!['email'] ?? '';
        collegeController.text = profile!['college'] ?? '';
        bioController.text = profile!['bio'] ?? '';
      }
    });
  }

  Future<void> saveProfile() async {
    try {
      setState(() => isLoading = true);
      await profileService.createProfile(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        bio: bioController.text.trim(),
        college: collegeController.text.trim(),
      );
      await getProfile();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile created")));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> updateProfile() async {
    try {
      setState(() => isLoading = true);
      await profileService.updateProfile(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        bio: bioController.text.trim(),
        college: collegeController.text.trim(),
      );
      await getProfile();
      if (!mounted) return;
      setState(() => isEditing = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Profile updated")));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _styledField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF64748B)),
        prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 20),
        filled: true,
        fillColor: const Color(0xFF1E293B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEditing) ...[
          GestureDetector(
            onTap: () => setState(() => isEditing = false),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF818CF8),
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Back to profile',
                  style: TextStyle(color: Color(0xFF818CF8), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Icon + heading
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: Color(0xFF818CF8),
            size: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          profile == null ? 'Set up your profile' : 'Edit profile',
          style: const TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          profile == null
              ? 'Fill in your details to get started'
              : 'Update your information below',
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
        ),
        const SizedBox(height: 28),

        _styledField(
          controller: usernameController,
          label: 'Username',
          icon: Icons.badge_outlined,
        ),
        const SizedBox(height: 14),
        _styledField(
          controller: emailController,
          label: 'Email',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        _styledField(
          controller: collegeController,
          label: 'College',
          icon: Icons.school_outlined,
        ),
        const SizedBox(height: 14),
        _styledField(
          controller: bioController,
          label: 'Bio',
          icon: Icons.edit_note_rounded,
          maxLines: 3,
        ),
        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : profile == null
                ? saveProfile
                : updateProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              disabledBackgroundColor: const Color(0xFF6366F1).withOpacity(0.5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    profile == null ? 'Save profile' : 'Update profile',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget buildProfile() {
    final initials = (profile!['username'] ?? '?')
        .toString()
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .take(2)
        .map((w) => w[0].toUpperCase())
        .join();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Color(0xFF818CF8),
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                profile!['username'] ?? '—',
                style: const TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                profile!['email'] ?? '—',
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Info tiles
        _infoTile(
          icon: Icons.school_outlined,
          label: 'College',
          value: profile!['college'] ?? '—',
        ),
        const SizedBox(height: 10),
        _infoTile(
          icon: Icons.edit_note_rounded,
          label: 'Bio',
          value: profile!['bio'] ?? '—',
        ),
        const SizedBox(height: 28),

        // Edit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => setState(() => isEditing = true),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text(
              'Edit profile',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF475569), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFE2E8F0),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFFE2E8F0),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: isFetching
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF6366F1),
                  strokeWidth: 2,
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: profile == null || isEditing
                    ? buildForm()
                    : buildProfile(),
              ),
      ),
    );
  }
}
