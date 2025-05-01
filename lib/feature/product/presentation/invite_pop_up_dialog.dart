import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';

import 'package:sippy_cart_sharing/feature/session/data/local/local_session_repository.dart';

import 'package:sippy_cart_sharing/feature/user/activer_user.dart';
import 'package:sippy_cart_sharing/routes/auto_router.gr.dart';

class InviteModal extends StatefulWidget {
  const InviteModal({super.key});

  @override
  State<InviteModal> createState() => _InviteModalState();
}

class _InviteModalState extends State<InviteModal> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();

  bool _isGenerating = false;
  String? _sessionId;
  bool _linkCopied = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final activeUserProvider = Provider.of<ActiveUserProvider>(
        context,
        listen: false,
      );
      if (activeUserProvider.name.isNotEmpty) {
        _nameController.text = activeUserProvider.name;
      }
    });
  }

  Future<void> _createSession() async {
    final name = _nameController.text.trim();
    final title = _titleController.text.trim();

    if (name.isEmpty || title.isEmpty) {
      setState(
        () => _errorMessage = 'Please enter both name and session title.',
      );
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });

    try {
      final repo = Provider.of<LocalSessionRepositoryImpl>(
        context,
        listen: false,
      );
      await repo.startSession(creatorId: name);

      final sessionId = repo.session?.sessionId;
      if (sessionId == null) throw Exception('Failed to create session');

      // Set active user name
      Provider.of<ActiveUserProvider>(context, listen: false).name = name;

      if (mounted) {
        setState(() {
          _sessionId = sessionId;
          _isGenerating = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _copyToClipboard() {
    if (_sessionId == null) return;

    Clipboard.setData(ClipboardData(text: _sessionId!));
    setState(() => _linkCopied = true);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _linkCopied = false);
    });
  }

  void _continueToProducts(BuildContext context) {
    Navigator.pop(context);
    context.router.replaceAll([const ProductRoute()]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _sessionId == null ? 'Create Shopping Session' : 'Session Created',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_sessionId == null) ...[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.words,
              ),
              const Gap(16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Session Title',
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                textCapitalization: TextCapitalization.words,
              ),
            ] else ...[
              const Text('Session ID (share with friends):'),
              const Gap(8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _sessionId!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _linkCopied ? Icons.check : Icons.copy,
                        color: _linkCopied ? Colors.green : null,
                      ),
                      onPressed: _copyToClipboard,
                      tooltip: _linkCopied ? 'Copied!' : 'Copy to clipboard',
                    ),
                  ],
                ),
              ),
              const Gap(16),
              const Text(
                'Share this ID with friends so they can join your shopping session.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
            if (_isGenerating) ...[
              const Gap(24),
              const Center(child: CustomLoadingIndicator()),
            ],
            if (_errorMessage != null) ...[
              const Gap(16),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isGenerating ? null : () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed:
              _isGenerating
                  ? null
                  : _sessionId == null
                  ? _createSession
                  : () => _continueToProducts(context),
          child: Text(_sessionId == null ? 'CREATE' : 'CONTINUE SHOPPING'),
        ),
      ],
    );
  }
}
