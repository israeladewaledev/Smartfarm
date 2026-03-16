import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SystemSupportScreen extends StatelessWidget {
  const SystemSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('System Support'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                   Icon(Icons.headset_mic, color: Colors.white, size: 40),
                   SizedBox(width: 20),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Need Help?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                         Text('Our team is available 24/7 to assist with your sensor node.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                       ],
                     ),
                   ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Quick Contacts', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _SupportAction(icon: Icons.chat_bubble_outline, title: 'Chat on WhatsApp', color: const Color(0xFF25D366)),
            _SupportAction(icon: Icons.email_outlined, title: 'Email Support', color: AppColors.primary),
            _SupportAction(icon: Icons.phone_in_talk_outlined, title: 'Call a Technician', color: Colors.blue),
            const SizedBox(height: 32),
            Text('Frequently Asked Questions', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _FaqTile(q: 'How often should I clean the solar panel?', a: 'Once every month or after heavy dust storms in the North.'),
            _FaqTile(q: 'What if the sensor shows "0%" moisture?', a: 'Check if the sensor probes are securely plugged into the soil.'),
            _FaqTile(q: 'How do I update the app?', a: 'New versions are sent via WhatsApp or distributed by extension workers.'),
          ],
        ),
      ),
    );
  }
}

class _SupportAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SupportAction({required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String q;
  final String a;

  const _FaqTile({required this.q, required this.a});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(q, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(a, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
