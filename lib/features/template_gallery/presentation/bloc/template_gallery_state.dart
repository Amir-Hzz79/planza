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
    this.selectedCategory = 'all',
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

class TemplateGalleryActionFailure extends TemplateGalleryState {
  final String message;

  const TemplateGalleryActionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class TemplateExported extends TemplateGalleryState {
  final String jsonString;

  const TemplateExported(this.jsonString);

  @override
  List<Object?> get props => [jsonString];
}
