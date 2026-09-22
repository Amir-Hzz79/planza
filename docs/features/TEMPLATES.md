# Templates

Template system: predefined goal+task+tag structures that users can discover, use, import, export, and share.

## What It Does

- Built-in templates across categories: Habit, Project, Learning, Fitness, Custom
- Template gallery UI with category tabs, search, filter
- "Use Template" action creates a goal + tasks + tags from the template payload
- Create template from existing goal
- Export template as JSON file
- Import template from JSON file / QR code
- Share template via system share sheet
- Create template from scratch

## Key Files

```
lib/core/data/
├── models/
│   └── template_model.dart          # Template entity (id, name, description, category, icon, color, payloadJson, isBuiltin, createdAt/updatedAt)
├── data_access_object/
│   └── template_dao.dart           # CRUD, watch streams, category filtering, import/export
└── bloc/
    └── template_bloc/
        ├── template_bloc.dart       # Load, Add, Update, Delete, CreateFromGoal, Import, Export
        ├── template_event.dart
        ├── template_state.dart      # Initial, Loading, Loaded (list), Error
        └── template_bloc_builder.dart

lib/features/template_gallery/
├── presentation/
│   ├── bloc/
│   │   ├── template_gallery_bloc.dart   # Gallery UI state: filter, search, use, export/import/share, QR
│   │   ├── template_gallery_event.dart
│   │   └── template_gallery_state.dart  # Initial, Loading, Loaded (templates, category, query), Error
│   ├── pages/
│   │   └── template_gallery_page.dart   # Category tabs, search, template grid
│   └── widgets/
│       ├── template_card.dart           # Template preview card
│       └── index.dart
```

## BLoC: TemplateBloc (core)

Events: `LoadTemplates`, `LoadBuiltinTemplates`, `LoadTemplatesByCategory`, `AddTemplate`, `UpdateTemplate`, `DeleteTemplate`, `CreateTemplateFromGoal`, `ImportTemplate`, `ExportTemplate`

The core TemplateBloc is registered in app.dart and wired to GoalBloc/TaskBloc/TagBloc for "Use Template" creation.

## BLoC: TemplateGalleryBloc (feature UI)

Wraps core TemplateBloc. Adds gallery-specific events: `FilterByCategory`, `SearchTemplates`, `UseTemplate`, `ExportTemplate`, `ExportTemplateToFile`, `ImportTemplate`, `ImportTemplateFromFile`, `ShareTemplate`, `GenerateTemplateQRCode`, `RefreshTemplates`.

State carries: templates list, selectedCategory, searchQuery.

## Template Payload

`payloadJson` stores the full goal+tasks+tags structure as JSON. When "Use Template" fires, the gallery bloc calls into TemplateBloc which reads the payload and creates GoalModel + TaskModel + TagModel via GoalBloc/TaskBloc/TagBloc.

## Categories

Habit, Project, Learning, Fitness, Custom — displayed as category tabs in the gallery.

## Integration Points

- Goals/Tasks/Tags: template use creates these via their respective blocs
- File system: export/import JSON files (uses MethodChannel-based AppPaths for paths)
- QR codes: import via scan
- Share: system share sheet for template JSON
