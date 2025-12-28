import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/contact/data/contact_repository.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/app_dropdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/notifier.dart';

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
      case 'General':
        return l.category_GENERAL;
      case 'TechnicalIssue':
        return l.category_TECHNICAL_ISSUE;
      case 'SessionQuestion':
        return l.category_SESSION_QUESTION;
      case 'VenueAccess':
        return l.category_VENUE_ACCESS;
      case 'Feedback':
        return l.category_FEEDBACK;
      case 'Other':
        return l.category_OTHER;
      default:
        return key;
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
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withAlpha(180),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.contactFormHeader,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Category
              AppDropdown<String>(
                value: _selectedCategory,
                items: _categories,
                itemLabel: (c) => _categoryLabel(context, c),
                onChanged: (val) => setState(() => _selectedCategory = val),
                label: l.contactCategory,
                outlined: true,
                validator: (v) => v == null ? l.fieldRequired : null,
              ),
              const SizedBox(height: 16),

              // Subject
              AppTextInput(
                controller: _subjectController,
                label: l.contactSubject,
                outlined: true,
                validator: (v) => (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              ),
              const SizedBox(height: 16),

              // Message
              AppTextInput(
                controller: _messageController,
                label: l.contactMessage,
                outlined: true,
                minLines: 6,
                maxLines: 6,
                validator: (v) => (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              ),

              const SizedBox(height: 24),

              // Submit button
              AppPrimaryButton(
                label: l.contactSubmit,
                onPressed: _submitting
                    ? () {}
                    : () {
                        // ignore: void_checks
                        (() async {
                          if (_selectedCategory == null) {
                            AppNotifier.info(context, l.contactCategory);
                            return;
                          }
                          if (!_formKey.currentState!.validate()) return;

                          setState(() => _submitting = true);
                          try {
                            final repo = ContactRepository(
                              ref.read(apiClientProvider),
                            );
                            final ok = await repo.submitContact(
                              category: _selectedCategory!,
                              subject: _subjectController.text.trim(),
                              message: _messageController.text.trim(),
                            );
                            if (!mounted) return;
                            if (ok) {
                              AppNotifier.success(context, l.contactSuccess);
                            } else {
                              AppNotifier.error(context, l.contactError);
                            }
                            _formKey.currentState!.reset();
                            setState(() {
                              _selectedCategory = null;
                            });
                          } catch (_) {
                            if (!mounted) return;
                            AppNotifier.error(context, l.contactError);
                          } finally {
                            if (mounted) {
                              setState(() => _messageController.text = '');
                              setState(() => _subjectController.text = '');
                              setState(() => _submitting = false);
                            }
                          }
                        })();
                      },
                expanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
