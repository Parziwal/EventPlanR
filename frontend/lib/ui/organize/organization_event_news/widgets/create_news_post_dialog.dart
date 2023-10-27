import 'package:event_planr_app/domain/models/news_post/create_news_post.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/cubit/organization_event_news_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

Future<void> showCreateNewsPostDialog(BuildContext context) async {
  final newsCubit = context.read<OrganizationEventNewsCubit>();
  final eventId = context.goRouterState.pathParameters['eventId']!;

  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: newsCubit,
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        child: _CreateNewsPostDialog(eventId: eventId),
      ),
    ),
  );
}

class _CreateNewsPostDialog extends StatefulWidget {
  const _CreateNewsPostDialog({required this.eventId});

  final String eventId;

  @override
  State<_CreateNewsPostDialog> createState() => _CreateNewsPostDialogState();
}

class _CreateNewsPostDialogState extends State<_CreateNewsPostDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return BlocListener<OrganizationEventNewsCubit, OrganizationEventNewsState>(
      listener: _stateListener,
      child: SizedBox(
        height: 430,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: theme.colorScheme.inversePrimary,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.organizationEventNews_PostNews,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _titleField(context),
                      const SizedBox(height: 16),
                      _textField(context),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: !loading ? _submit : null,
                            style: FilledButton.styleFrom(
                              textStyle: theme.textTheme.titleMedium,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Text(l10n.submit),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            onPressed: !loading ? () => context.pop() : null,
                            style: FilledButton.styleFrom(
                              textStyle: theme.textTheme.titleMedium,
                              padding: const EdgeInsets.all(16),
                            ),
                            child: Text(l10n.cancel),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _formKey.currentState!.save();

      context.read<OrganizationEventNewsCubit>().createNews(
            CreateNewsPost.fromJson(
              {..._formKey.currentState!.value, 'eventId': widget.eventId},
            ),
          );
    }
  }

  Widget _titleField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'title',
      enabled: !loading,
      decoration: InputDecoration(
        hintText: l10n.organizationEventNews_Title,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(64),
        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    final l10n = context.l10n;

    return FormBuilderTextField(
      name: 'text',
      maxLines: 6,
      enabled: !loading,
      decoration: InputDecoration(
        hintText: l10n.organizationEventNews_NewsAboutTheEvent,
        filled: true,
      ),
      validator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.required(),
        ],
      ),
    );
  }

  void _stateListener(BuildContext context, OrganizationEventNewsState state) {
    if (state.status == OrganizationEventNewsStatus.newsCreated) {
      context.pop();
    }
  }
}
