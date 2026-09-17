part of 'template_bloc.dart';

abstract class TemplateState extends Equatable {
  const TemplateState();

  @override
  List<Object?> get props => [];
}

class TemplateInitial extends TemplateState {}

class TemplateLoading extends TemplateState {}

class TemplateLoaded extends TemplateState {
  final List<TemplateModel> templates;

  const TemplateLoaded(this.templates);

  @override
  List<Object?> get props => [templates];
}

class TemplateError extends TemplateState {
  final String message;

  const TemplateError(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateActionSuccess extends TemplateState {
  final String message;

  const TemplateActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateExported extends TemplateState {
  final String jsonString;

  const TemplateExported(this.jsonString);

  @override
  List<Object?> get props => [jsonString];
}