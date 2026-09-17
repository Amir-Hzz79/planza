part of 'template_bloc.dart';

abstract class TemplateEvent extends Equatable {
  const TemplateEvent();

  @override
  List<Object?> get props => [];
}

class LoadTemplates extends TemplateEvent {}

class LoadBuiltinTemplates extends TemplateEvent {}

class LoadTemplatesByCategory extends TemplateEvent {
  final String category;

  const LoadTemplatesByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class AddTemplate extends TemplateEvent {
  final TemplateModel template;

  const AddTemplate(this.template);

  @override
  List<Object?> get props => [template];
}

class UpdateTemplate extends TemplateEvent {
  final TemplateModel template;

  const UpdateTemplate(this.template);

  @override
  List<Object?> get props => [template];
}

class DeleteTemplate extends TemplateEvent {
  final int templateId;

  const DeleteTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class CreateTemplateFromGoal extends TemplateEvent {
  final GoalModel goal;
  final String name;
  final String category;

  const CreateTemplateFromGoal({
    required this.goal,
    required this.name,
    required this.category,
  });

  @override
  List<Object?> get props => [goal, name, category];
}

class ImportTemplate extends TemplateEvent {
  final String jsonString;

  const ImportTemplate(this.jsonString);

  @override
  List<Object?> get props => [jsonString];
}

class ExportTemplate extends TemplateEvent {
  final int templateId;

  const ExportTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}