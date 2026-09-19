part of 'template_gallery_bloc.dart';

abstract class TemplateGalleryEvent extends Equatable {
  const TemplateGalleryEvent();

  @override
  List<Object?> get props => [];
}

class LoadTemplates extends TemplateGalleryEvent {}

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

class ExportTemplate extends TemplateGalleryEvent {
  final int templateId;

  const ExportTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class ExportTemplateToFile extends TemplateGalleryEvent {
  final int templateId;

  const ExportTemplateToFile(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class ImportTemplate extends TemplateGalleryEvent {
  final String jsonString;

  const ImportTemplate(this.jsonString);

  @override
  List<Object?> get props => [jsonString];
}

class ImportTemplateFromFile extends TemplateGalleryEvent {}

class ShareTemplate extends TemplateGalleryEvent {
  final int templateId;

  const ShareTemplate(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class GenerateTemplateQRCode extends TemplateGalleryEvent {
  final int templateId;

  const GenerateTemplateQRCode(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

class RefreshTemplates extends TemplateGalleryEvent {}