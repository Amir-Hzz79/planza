import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/bloc/template_bloc/template_bloc.dart';
import 'package:planza/core/data/models/template_model.dart';

class TemplateBlocBuilder extends StatelessWidget {
  final Widget Function(List<TemplateModel>) onDataLoaded;
  final Widget Function()? onLoading;
  final Widget Function(String)? onError;

  const TemplateBlocBuilder({
    super.key,
    required this.onDataLoaded,
    this.onLoading,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateBloc, TemplateState>(
      builder: (context, state) {
        if (state is TemplateLoading) {
          return onLoading?.call() ??
              const Center(child: CircularProgressIndicator());
        } else if (state is TemplateLoaded) {
          return onDataLoaded(state.templates);
        } else if (state is TemplateError) {
          return onError?.call(state.message) ??
              Center(child: Text('Error: ${state.message}'));
        } else if (state is TemplateActionSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          });
          return BlocBuilder<TemplateBloc, TemplateState>(
            builder: (context, state) {
              if (state is TemplateLoaded) {
                return onDataLoaded(state.templates);
              }
              return onLoading?.call() ??
                  const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is TemplateExported) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Template exported to clipboard')),
            );
          });
          return BlocBuilder<TemplateBloc, TemplateState>(
            builder: (context, state) {
              if (state is TemplateLoaded) {
                return onDataLoaded(state.templates);
              }
              return onLoading?.call() ??
                  const Center(child: CircularProgressIndicator());
            },
          );
        }
        return onLoading?.call() ??
            const Center(child: CircularProgressIndicator());
      },
    );
  }
}
