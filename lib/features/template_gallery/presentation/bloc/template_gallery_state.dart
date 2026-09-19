part of 'template_gallery_bloc.dart';

abstract class TemplateGalleryState extends Equatable {
  const TemplateGalleryState();

  @override
  List<Object?> get props => [];
}

class TemplateGalleryInitial extends TemplateGalleryState {}

class TemplateGalleryLoading extends TemplateGalleryState {}

class TemplateGalleryLoaded extends TemplateGalleryState {
  final List<TemplateModel> templates;
  final String selectedCategory;
  final String? searchQuery;

  const TemplateGalleryLoaded({
    required this.templates,
    required this.selectedCategory,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [templates, selectedCategory, searchQuery];
}

class TemplateGalleryError extends TemplateGalleryState {
  final String message;

  const TemplateGalleryError(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateGalleryActionInProgress extends TemplateGalleryState {
  final String message;

  const TemplateGalleryActionInProgress(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateGalleryActionSuccess extends TemplateGalleryState {
  final String message;

  const TemplateGalleryActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateExportedToFile extends TemplateGalleryState {
  final String filePath;

  const TemplateExportedToFile(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class TemplateImportedFromFile extends TemplateGalleryState {
  final String filePath;

  const TemplateImportedFromFile(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class TemplateQRCodeGenerated extends TemplateGalleryState {
  final String qrData;

  const TemplateQRCodeGenerated(this.qrData);

  @override
  List<Object?> get props => [qrData];
}
