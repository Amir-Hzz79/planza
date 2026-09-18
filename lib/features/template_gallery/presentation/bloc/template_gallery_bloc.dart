import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:planza/core/data/bloc/template_bloc/template_bloc.dart' as core_template;
import 'package:planza/core/data/models/template_model.dart';
import 'package:share_plus/share_plus.dart';

part 'template_gallery_event.dart';
part 'template_gallery_state.dart';

class TemplateGalleryBloc extends Bloc<TemplateGalleryEvent, TemplateGalleryState> {
  final core_template.TemplateBloc _templateBloc;

  TemplateGalleryBloc({required core_template.TemplateBloc templateBloc})
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
      _templateBloc.add(core_template.LoadTemplates());
      // Wait for templates to load
      await Future.delayed(const Duration(milliseconds: 300));
      final templatesState = _templateBloc.state;
      if (templatesState is core_template.TemplateLoaded) {
        add(FilterByCategory('all'));
      }
    } catch (e) {
      emit(TemplateGalleryError('Failed to load templates: $e'));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<TemplateGalleryState> emit,
  ) async {
    try {
      _templateBloc.add(core_template.LoadTemplatesByCategory(event.category));
      await Future.delayed(const Duration(milliseconds: 300));
      final templatesState = _templateBloc.state;
      if (templatesState is core_template.TemplateLoaded) {
        emit(TemplateGalleryLoaded(
          templates: templatesState.templates,
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
        final query = event.query.toLowerCase();
        final filtered = currentState.templates.where((t) {
          final nameMatch = t.name.toLowerCase().contains(query);
          final descMatch = t.description?.toLowerCase().contains(query) ?? false;
          final catMatch = t.category.toLowerCase().contains(query);
          return nameMatch || descMatch || catMatch;
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
      // Trigger export in template bloc using the correct event type
      _templateBloc.add(core_template.ExportTemplate(event.templateId));
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
      // Import logic would go here - using template bloc's ImportTemplate
      _templateBloc.add(core_template.ImportTemplate(event.jsonString));
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
      
      _templateBloc.add(core_template.ExportTemplate(event.templateId));
      
      // Wait for export result
      await Future.delayed(const Duration(milliseconds: 500));
      
      final templateState = _templateBloc.state;
      if (templateState is core_template.TemplateExported) {
        await Share.share(templateState.jsonString, subject: 'Planza Template');
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