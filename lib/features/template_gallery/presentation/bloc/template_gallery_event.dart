part of 'template_gallery_bloc.dart';

abstract class TemplateGalleryEvent extends Equatable {
  const TemplateGalleryEvent();

  @override
  List<Object?> get props => [];
}

class LoadGalleryTemplates extends TemplateGalleryEvent {}

class FilterByCategory extends TemplateGalleryEvent {
  final String category;

  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class SearchTemplates extends TemplateGalleryEvent {
  final String query;

  const SearchTemplates(this.query);

  @override
  List<Object?> get props => [query];
}

class UseTemplate extends TemplateGalleryEvent {
  final TemplateModel template;

  const UseTemplate(this.template);

  @override
  List<Object?> get props => [template];
}

class ExportGalleryTemplate extends TemplateGalleryEvent {
  final int templateId;

  const ExportGalleryTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class ImportTemplate extends TemplateGalleryEvent {
  final String jsonString;

  const ImportTemplate(this.jsonString);

  @override
  List<Object?> get props => [jsonString];
}

class ShareTemplate extends TemplateGalleryEvent {
  final int templateId;

  const ShareTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class RefreshTemplates extends TemplateGalleryEvent {}
