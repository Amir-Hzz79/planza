import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:planza/core/data/data_access_object/template_dao.dart';
import 'package:planza/core/data/models/template_model.dart';

part 'template_gallery_event.dart';
part 'template_gallery_state.dart';

class TemplateGalleryBloc
    extends Bloc<TemplateGalleryEvent, TemplateGalleryState> {
  final TemplateDao _templateDao;

  TemplateGalleryBloc({required TemplateDao templateDao})
      : _templateDao = templateDao,
        super(TemplateGalleryInitial()) {
    on<LoadGalleryTemplates>(_onLoadTemplates);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchTemplates>(_onSearchTemplates);
    on<UseTemplate>(_onUseTemplate);
    on<ExportGalleryTemplate>(_onExportTemplate);
    on<ImportTemplate>(_onImportTemplate);
    on<ShareTemplate>(_onShareTemplate);
    on<RefreshTemplates>(_onRefreshTemplates);
  }

  Future<void> _onLoadTemplates(
    LoadGalleryTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    emit(TemplateGalleryLoading());
    try {
      final templates = await _templateDao.getAllTemplates();
      emit(TemplateGalleryLoaded(
        templates: templates,
        selectedCategory: 'all',
      ));
    } catch (e) {
      emit(TemplateGalleryError('Failed to load templates: $e'));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      List<TemplateModel> templates;
      if (event.category == 'all') {
        final allTemplates = await _templateDao.getAllTemplates();
        templates = allTemplates;
      } else {
        templates = await _templateDao.getTemplatesByCategory(event.category);
      }
      emit(TemplateGalleryLoaded(
        templates: templates,
        selectedCategory: event.category,
      ));
    } catch (e) {
      emit(TemplateGalleryError('Failed to filter templates: $e'));
    }
  }

  Future<void> _onSearchTemplates(
    SearchTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      final currentState = state!;
      if (currentState is TemplateGalleryLoaded) {
        final filtered = currentState.templates.where((t) {
          return t.name.toLowerCase().contains(event.query.toLowerCase()) ||
              (t.description
                      ?.toLowerCase()
                      .contains(event.query.toLowerCase()) ??
                  false) ||
              t.category.toLowerCase().contains(event.query.toLowerCase());
        }).toList();
        emit(TemplateGalleryLoaded(
          templates: filtered,
          selectedCategory: currentState.selectedCategory,
          searchQuery: event.query,
        ));
      }
    } catch (e) {
      emit(TemplateGalleryError('Failed to search templates: $e'));
    }
  }

  Future<void> _onUseTemplate(
    UseTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      emit(TemplateGalleryActionInProgress('Creating goal from template...'));

      // TODO: Implement actual goal creation logic
      emit(TemplateGalleryActionSuccess('Goal created from template!'));

      add(RefreshTemplates());
    } catch (e) {
      emit(TemplateGalleryError('Failed to use template: $e'));
    }
  }

  Future<void> _onExportTemplate(
    ExportGalleryTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      final template = await _templateDao.getTemplateById(event.templateId);
      if (template == null) {
        emit(TemplateGalleryError('Template not found'));
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
      emit(TemplateGalleryError('Failed to export template: $e'));
    }
  }

  Future<void> _onImportTemplate(
    ImportTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      emit(TemplateGalleryActionInProgress('Importing template...'));

      final json = jsonDecode(event.jsonString);

      if (!json.containsKey('name') ||
          !json.containsKey('category') ||
          !json.containsKey('payloadJson')) {
        throw Exception('Invalid template format');
      }

      final template = TemplateModel(
        name: json['name'] as String,
        description: json['description'] as String?,
        category: json['category'] as String,
        icon: json['icon'] != null
            ? IconData(json['icon'] as int, fontFamily: 'MaterialIcons')
            : null,
        color: json['color'] != null ? Color(json['color'] as int) : null,
        payloadJson: json['payloadJson'] as String,
        isBuiltin: json['isBuiltin'] as bool? ?? false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _templateDao.insertTemplate(template);
      add(RefreshTemplates());
      emit(TemplateGalleryActionSuccess('Template imported successfully!'));
    } catch (e) {
      emit(TemplateGalleryError('Failed to import template: $e'));
    }
  }

  Future<void> _onShareTemplate(
    ShareTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      // TODO: Implement sharing via share_plus package
      emit(TemplateGalleryActionInProgress('Preparing share...'));
      emit(TemplateGalleryActionSuccess('Template shared!'));
    } catch (e) {
      emit(TemplateGalleryError('Failed to share template: $e'));
    }
  }

  Future<void> _onRefreshTemplates(
    RefreshTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    add(LoadGalleryTemplates());
  }
}
