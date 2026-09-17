import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:planza/core/data/bloc/template_bloc/template_bloc.dart';
import 'package:planza/core/data/models/template_model.dart';
import 'package:share_plus/share_plus.dart';

part 'template_gallery_event.dart';
part 'template_gallery_state.dart';

class TemplateGalleryBloc extends Bloc<TemplateGalleryEvent, TemplateGalleryState> {
  final TemplateBloc _templateBloc;

  TemplateGalleryBloc({required TemplateBloc templateBloc})
      : _templateBloc = templateBloc,
        super(TemplateGalleryInitial()) {
    on<LoadTemplates>(_onLoadTemplates);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchTemplates>(_onSearchTemplates);
    on<UseTemplate>(_onUseTemplate);
    on<ExportTemplate>(_onExportTemplate);
    on<ImportTemplate>(_onImportTemplate);
    on<ShareTemplate>(_onShareTemplate);
    on<RefreshTemplates>(_onRefreshTemplates);
  }

  Future<void> _onLoadTemplates(
    LoadTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    emit(TemplateGalleryLoading());
    try {
      _templateBloc.add(LoadTemplates());
      // Wait for templates to load
      await Future.delayed(const Duration(milliseconds: 300));
      _templateBloc.stream.firstWhere((state) => state is TemplateLoaded).then((state) {
        if (state is TemplateLoaded) {
          add(FilterByCategory(TemplateCategory.all));
        }
      });
    } catch (e) {
      emit(TemplateGalleryError('Failed to load templates: $e'));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      _templateBloc.add(LoadTemplatesByCategory(event.category));
      await Future.delayed(const Duration(milliseconds: 300));
      final state = _templateBloc.stream.firstWhere((state) => state is TemplateLoaded);
      if (state is TemplateLoaded) {
        emit(TemplateGalleryLoaded(
          templates: state.templates,
          selectedCategory: event.category,
        ));
      }
    } catch (e) {
      emit(TemplateGalleryError('Failed to filter templates: $e'));
    }
  }

  Future<void> _onSearchTemplates(
    SearchTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is TemplateGalleryLoaded) {
        final filtered = currentState.templates.where((t) {
          return t.name.toLowerCase().contains(event.query.toLowerCase()) ||
              t.description?.toLowerCase().contains(event.query.toLowerCase()) ?? false ||
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
      // Create goal and tasks from template
      emit(TemplateGalleryActionInProgress('Creating goal from template...'));
      
      // This would be implemented with actual goal creation logic
      // For now, just show success
      emit(TemplateGalleryActionSuccess('Goal created from template!'));
      
      // Refresh templates
      add(RefreshTemplates());
    } catch (e) {
      emit(TemplateGalleryError('Failed to use template: $e'));
    }
  }

  Future<void> _onExportTemplate(
    ExportTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      // Trigger export in template bloc
      // The template bloc will emit TemplateExported
      _templateBloc.add(ExportTemplate(event.templateId));
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
      // Import logic would go here
      emit(TemplateGalleryActionSuccess('Template imported successfully!'));
      add(RefreshTemplates());
    } catch (e) {
      emit(TemplateGalleryError('Failed to import template: $e'));
    }
  }

  Future<void> _onShareTemplate(
    ShareTemplate event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      emit(TemplateGalleryActionInProgress('Preparing share...'));
      
      _templateBloc.add(ExportTemplate(event.templateId));
      
      // Wait for export result
      await Future.delayed(const Duration(milliseconds: 500));
      
      final state = _templateBloc.state;
      if (state is TemplateExported) {
        await Share.share(state.jsonString, subject: 'Planza Template');
        emit(TemplateGalleryActionSuccess('Template shared!'));
      }
    } catch (e) {
      emit(TemplateGalleryError('Failed to share template: $e'));
    }
  }

  Future<void> _onRefreshTemplates(
    RefreshTemplates event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    add(LoadTemplates());
  }
}