import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/contact/data/contact_repository.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactFormPage extends ConsumerStatefulWidget {
  const ContactFormPage({super.key});

  @override
  ConsumerState<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends ConsumerState<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String? _selectedCategory;
  bool _submitting = false;

  List<String> get _categories => const [
    'General',
    'TechnicalIssue',
    'SessionQuestion',
    'VenueAccess',
    'Feedback',
    'Other',
  ];

  String _categoryLabel(BuildContext context, String key) {
    final l = AppLocalizations.of(context)!;
    switch (key) {
      case 'General': return l.category_GENERAL;
      case 'TechnicalIssue': return l.category_TECHNICAL_ISSUE;
      case 'SessionQuestion': return l.category_SESSION_QUESTION;
      case 'VenueAccess': return l.category_VENUE_ACCESS;
      case 'Feedback': return l.category_FEEDBACK;
      case 'Other': return l.category_OTHER;
      default: return key;
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return AppScaffold(
      title: l.contactFormTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fancy header card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      'We value your feedback and inquiries. Please fill the form and we will get back to you shortly.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Category
              InputDecorator(
                decoration: InputDecoration(
                  labelText: l.contactCategory,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategory,
                    items: _categories.map((c) => DropdownMenuItem<String>(
                      value: c,
                      child: Text(_categoryLabel(context, c)),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedCategory = val),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Subject
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  labelText: l.contactSubject,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              ),
              const SizedBox(height: 16),

              // Message
              TextFormField(
                controller: _messageController,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: l.contactMessage,
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              ),

              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: _submitting ? const SizedBox(
                    width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  ) : const Icon(Icons.send_rounded),
                  label: Text(l.contactSubmit),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _submitting ? null : () async {
                    if (_selectedCategory == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.contactCategory)));
                      return;
                    }
                    if (!_formKey.currentState!.validate()) return;

                    setState(() => _submitting = true);
                    try {
                      final repo = ContactRepository(ref.read(apiClientProvider));
                      final ok = await repo.submitContact(
                        category: _selectedCategory!,
                        subject: _subjectController.text.trim(),
                        message: _messageController.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? l.contactSuccess : l.contactError)));
                      _formKey.currentState!.reset();
                      setState(() { _selectedCategory = null; });
                    } catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.contactError)));
                    } finally {
                      setState(() => _messageController.text = '');
                      setState(() => _subjectController.text = '');
                      setState(() => _submitting = false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
