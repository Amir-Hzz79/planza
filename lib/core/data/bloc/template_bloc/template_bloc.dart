import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';
import 'package:planza/core/data/bloc/tag_bloc/tag_bloc.dart';
import 'package:planza/core/data/data_access_object/template_dao.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/models/tag_model.dart';
import 'package:planza/core/data/models/template_model.dart';

part 'template_event.dart';
part 'template_state.dart';

class TemplateBloc extends Bloc<TemplateEvent, TemplateState> {
  final TemplateDao _templateDao = GetIt.instance.get<TemplateDao>();
  final GoalBloc _goalBloc;
  final TaskBloc _taskBloc;
  final TagBloc _tagBloc;

  TemplateBloc({
    required GoalBloc goalBloc,
    required TaskBloc taskBloc,
    required TagBloc tagBloc,
  })  : _goalBloc = goalBloc,
        _taskBloc = taskBloc,
        _tagBloc = tagBloc,
        super(TemplateInitial()) {
    on<LoadTemplates>(_onLoadTemplates);
    on<LoadBuiltinTemplates>(_onLoadBuiltinTemplates);
    on<LoadTemplatesByCategory>(_onLoadTemplatesByCategory);
    on<AddTemplate>(_onAddTemplate);
    on<UpdateTemplate>(_onUpdateTemplate);
    on<DeleteTemplate>(_onDeleteTemplate);
    on<CreateTemplateFromGoal>(_onCreateTemplateFromGoal);
    on<ImportTemplate>(_onImportTemplate);
    on<ExportTemplate>(_onExportTemplate);
  }

  Future<void> _onLoadTemplates(
    LoadTemplates event,
    Emitter<TemplateState> emit,
  ) async {
    emit(TemplateLoading());
    try {
      final templates = await _templateDao.getAllTemplates();
      emit(TemplateLoaded(templates));
    } catch (e) {
      emit(TemplateError('Failed to load templates: $e'));
    }
  }

  Future<void> _onLoadBuiltinTemplates(
    LoadBuiltinTemplates event,
    Emitter<TemplateState> emit,
  ) async {
    emit(TemplateLoading());
    try {
      final templates = await _templateDao.getBuiltinTemplates();
      emit(TemplateLoaded(templates));
    } catch (e) {
      emit(TemplateError('Failed to load builtin templates: $e'));
    }
  }

  Future<void> _onLoadTemplatesByCategory(
    LoadTemplatesByCategory event,
    Emitter<TemplateState> emit,
  ) async {
    emit(TemplateLoading());
    try {
      final templates = await _templateDao.getTemplatesByCategory(event.category);
      emit(TemplateLoaded(templates));
    } catch (e) {
      emit(TemplateError('Failed to load templates: $e'));
    }
  }

  Future<void> _onAddTemplate(
    AddTemplate event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      await _templateDao.insertTemplate(event.template);
      add(LoadTemplates());
      emit(TemplateActionSuccess('Template created successfully'));
    } catch (e) {
      emit(TemplateError('Failed to create template: $e'));
    }
  }

  Future<void> _onUpdateTemplate(
    UpdateTemplate event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      await _templateDao.updateTemplate(event.template);
      add(LoadTemplates());
      emit(TemplateActionSuccess('Template updated successfully'));
    } catch (e) {
      emit(TemplateError('Failed to update template: $e'));
    }
  }

  Future<void> _onDeleteTemplate(
    DeleteTemplate event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      await _templateDao.deleteTemplate(event.templateId);
      add(LoadTemplates());
      emit(TemplateActionSuccess('Template deleted successfully'));
    } catch (e) {
      emit(TemplateError('Failed to delete template: $e'));
    }
  }

  Future<void> _onCreateTemplateFromGoal(
    CreateTemplateFromGoal event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      // Get tasks for this goal
      final goalState = _goalBloc.state;
      List<TaskModel> goalTasks = [];
      if (goalState is GoalsLoadedState) {
        goalTasks = goalState.goals
            .where((g) => g.id == event.goal.id)
            .expand((g) => g.tasks)
            .toList();
      } else {
        final tasksState = _taskBloc.state;
        if (tasksState is TasksLoadedState) {
          goalTasks = tasksState.tasks
              .where((t) => t.goal?.id == event.goal.id)
              .toList();
        }
      }

      // Get tags for these tasks
      final tags = <TagModel>[];
      for (final task in goalTasks) {
        tags.addAll(task.tags);
      }

      // Create payload JSON
      final payload = {
        'goal': event.goal.toJson(),
        'tasks': goalTasks.map((t) => t.toJson()).toList(),
        'tags': tags.map((t) => t.toJson()).toList(),
      };

      final payloadJson = jsonEncode(payload);

      final template = TemplateModel(
        name: event.name,
        description: 'Template created from goal: ${event.goal.name}',
        category: event.category,
        icon: event.goal.icon,
        color: event.goal.color,
        payloadJson: payloadJson,
        isBuiltin: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _templateDao.insertTemplate(template);
      add(LoadTemplates());
      emit(TemplateActionSuccess('Template created from goal successfully'));
    } catch (e) {
      emit(TemplateError('Failed to create template from goal: $e'));
    }
  }

  Future<void> _onImportTemplate(
    ImportTemplate event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      // Validate JSON
      final json = jsonDecode(event.jsonString);
      
      // Validate required fields
      if (!json.containsKey('name') || !json.containsKey('category') || !json.containsKey('payloadJson')) {
        throw Exception('Invalid template format');
      }
      
      final template = TemplateModel(
        name: json['name'] as String,
        description: json['description'] as String?,
        category: json['category'] as String,
        icon: json['icon'] != null ? IconData(json['icon'] as int, fontFamily: 'MaterialIcons') : null,
        color: json['color'] != null ? Color(json['color'] as int) : null,
        payloadJson: json['payloadJson'] as String,
        isBuiltin: json['isBuiltin'] as bool? ?? false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _templateDao.insertTemplate(template);
      add(LoadTemplates());
      emit(TemplateActionSuccess('Template imported successfully'));
    } catch (e) {
      emit(TemplateError('Failed to import template: $e'));
    }
  }

  Future<void> _onExportTemplate(
    ExportTemplate event,
    Emitter<TemplateState> emit,
  ) async {
    try {
      final template = await _templateDao.getTemplateById(event.templateId);
      if (template == null) {
        emit(TemplateError('Template not found'));
        return;
      }

      final jsonString = jsonEncode({
        'name': template.name,
        'description': template.description,
        'category': template.category,
        'icon': template.icon?.codePoint,
        'color': template.color?.toARGB32(),
        'payloadJson': template.payloadJson,
        'isBuiltin': template.isBuiltin,
      });

      emit(TemplateExported(jsonString));
    } catch (e) {
      emit(TemplateError('Failed to export template: $e'));
    }
  }
}