import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';
import 'package:sippy_cart_sharing/feature/user/activer_user.dart';
import 'package:sippy_cart_sharing/routes/auto_router.gr.dart';

class JoinModal extends StatefulWidget {
  const JoinModal({super.key});

  @override
  State<JoinModal> createState() => _JoinModalState();
}

class _JoinModalState extends State<JoinModal> {
  final _nameController = TextEditingController();
  final _sessionIdController = TextEditingController();
  bool _isJoining = false;
  String? _errorMessage;

  Future<void> _joinSession() async {
    final name = _nameController.text.trim();
    final sessionId = _sessionIdController.text.trim();

    if (name.isEmpty || sessionId.isEmpty) {
      setState(() => _errorMessage = 'Name and Session ID are required.');
      return;
    }

    setState(() {
      _isJoining = true;
      _errorMessage = null;
    });

    try {
      final repo = Provider.of<LocalSessionRepositoryImpl>(
        context,
        listen: false,
      );
      final session = await repo.getSessionById(sessionId);

      // Add this user as a guest
      await repo.addGuest(guestId: name, guestName: name);

      Provider.of<ActiveUserProvider>(context, listen: false).name = name;

      if (mounted) {
        Navigator.pop(context);
        context.router.replaceAll([const ProductRoute()]);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isJoining = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sessionIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Join a Shopping Session"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Your Name"),
          ),
          const Gap(12),
          TextField(
            controller: _sessionIdController,
            decoration: const InputDecoration(labelText: "Session ID"),
          ),
          if (_errorMessage != null) ...[
            const Gap(12),
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isJoining ? null : () => Navigator.pop(context),
          child: const Text("CANCEL"),
        ),
        ElevatedButton(
          onPressed: _isJoining ? null : _joinSession,
          child: Text(_isJoining ? "Joining..." : "JOIN"),
        ),
      ],
    );
  }
}
