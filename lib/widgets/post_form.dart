import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialBody;
  final Future<void> Function(String title, String body) onSubmit;

  PostForm({
    Key? key,
    this.initialTitle,
    this.initialBody,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _bodyController = TextEditingController(text: widget.initialBody ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'you must enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'you must enter a body';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _isLoading
                      ? null
                      : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await widget.onSubmit(
                              _titleController.text,
                              _bodyController.text,
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        }
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF182C54),
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                        'submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
