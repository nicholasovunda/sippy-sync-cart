import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sippy_cart_sharing/common_widgets/animated_loader.dart';

class InviteModal extends StatefulWidget {
  const InviteModal({super.key});

  @override
  State<InviteModal> createState() => _InviteModalState();
}

class _InviteModalState extends State<InviteModal> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();

  bool _isGenerating = false;
  String? _generatedLink;
  bool _linkCopied = false;

  String _generateSessionId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(
      6,
      (i) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  Future<void> _generateLink() async {
    final name = _nameController.text.trim();
    final title = _titleController.text.trim();

    if (name.isEmpty || title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both name and title')),
      );
      return;
    }

    setState(() => _isGenerating = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _generatedLink = 'app://shop/session/${_generateSessionId()}';
      _isGenerating = false;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedLink!));
    setState(() => _linkCopied = true);
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) setState(() => _linkCopied = false);
    });
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
      title: const Text('Invite to Shop Together'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Session Title'),
            ),
            const SizedBox(height: 24),
            if (_isGenerating)
              const Center(child: CustomLoadingIndicator())
            else if (_generatedLink != null)
              Column(
                children: [
                  const Text('Share this link:'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _generatedLink!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _linkCopied ? Icons.check : Icons.copy,
                            color: _linkCopied ? Colors.green : null,
                          ),
                          onPressed: _copyToClipboard,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed:
              _generatedLink == null
                  ? _generateLink
                  : () => Navigator.pop(context),
          child: Text(_generatedLink == null ? 'GENERATE LINK' : 'DONE'),
        ),
      ],
    );
  }
}
