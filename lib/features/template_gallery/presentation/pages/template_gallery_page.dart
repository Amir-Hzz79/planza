import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/template_dao.dart';
import 'package:planza/core/data/models/template_model.dart';
import 'package:planza/features/template_gallery/presentation/bloc/template_gallery_bloc.dart';
import 'package:planza/features/template_gallery/presentation/widgets/template_card.dart';

class TemplateGalleryPage extends StatelessWidget {
  const TemplateGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemplateGalleryBloc(
        templateDao: GetIt.instance.get<TemplateDao>(),
      )..add(LoadGalleryTemplates()),
      child: const TemplateGalleryView(),
    );
  }
}

class TemplateGalleryView extends StatefulWidget {
  const TemplateGalleryView({super.key});

  @override
  State<TemplateGalleryView> createState() => _TemplateGalleryViewState();
}

class _TemplateGalleryViewState extends State<TemplateGalleryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const List<String> _categories = [
    'all',
    TemplateCategory.habit,
    TemplateCategory.project,
    TemplateCategory.learning,
    TemplateCategory.fitness,
    TemplateCategory.custom,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Gallery'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: ['All', 'Habit', 'Project', 'Learning', 'Fitness', 'Custom']
              .map((cat) => Tab(text: cat))
              .toList(),
          onTap: (index) {
            context.read<TemplateGalleryBloc>().add(
                  FilterByCategory(_categories[index]),
                );
          },
        ),
      ),
      body: BlocBuilder<TemplateGalleryBloc, TemplateGalleryState>(
        builder: (context, state) {
          if (state is TemplateGalleryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TemplateGalleryLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TemplateGalleryBloc>().add(RefreshTemplates());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search templates...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<TemplateGalleryBloc>().add(
                              SearchTemplates(value),
                            );
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildTemplateList(state.templates),
                  ),
                ],
              ),
            );
          } else if (state is TemplateGalleryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context
                        .read<TemplateGalleryBloc>()
                        .add(RefreshTemplates()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to create template page
        },
        icon: const Icon(Icons.add),
        label: const Text('Create Template'),
      ),
    );
  }

  Widget _buildTemplateList(List<TemplateModel> templates) {
    if (templates.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.library_books_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No templates found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Create your first template or browse categories',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TemplateCard(
            template: templates[index],
            onTap: () {
              context
                  .read<TemplateGalleryBloc>()
                  .add(UseTemplate(templates[index]));
            },
          ),
        );
      },
    );
  }
}
