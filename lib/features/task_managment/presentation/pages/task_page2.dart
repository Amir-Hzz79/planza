import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/data/models/task_model.dart';
import '../widgets/calendar_task_view.dart';
import '../widgets/glassy_task_tile.dart';
import '../widgets/grouped_task_list_view.dart';

class TasksPage2 extends StatefulWidget {
  const TasksPage2({super.key});

  @override
  State<TasksPage2> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage2> {
  bool _isCalendarView = false;

  // State for managing search UI
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Add a listener to dispatch search events as the user types.
    _searchController.addListener(() {
      context
          .read<TaskBloc>()
          .add(SearchTasksRequested(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Helper method to build the animated search bar
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search tasks, goals, tags...',
        border: InputBorder.none,
        hintStyle:
            TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
      ),
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        // If we close search, clear the query and the results
        _searchController.clear();
        context.read<TaskBloc>().add(ClearSearch());
      }
    });
  }

  Future<bool?> _showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Are you sure you want to close the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isSearching,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        if (_isSearching) {
          _toggleSearch();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // The title is now conditional based on search state
          title: _isSearching
              ? _buildSearchBar()
              : const Text('My Tasks',
                  style: TextStyle(fontWeight: FontWeight.bold)),
          actions: _isSearching
              // Show a 'close' button when searching
              ? [
                  IconButton(
                      icon: const Icon(Icons.close), onPressed: _toggleSearch)
                ]
              // Show normal actions when not searching
              : [
                  IconButton(
                    icon: Icon(_isCalendarView
                        ? Icons.view_list_outlined
                        : Icons.calendar_month_outlined),
                    onPressed: () =>
                        setState(() => _isCalendarView = !_isCalendarView),
                  ),
                  IconButton(
                      icon: const Icon(Icons.filter_list), onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.search), onPressed: _toggleSearch),
                ],
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is! TasksLoadedState) {
              return const Center(child: CircularProgressIndicator());
            }

            // Determine which list to show: search results or the main list.
            final bool hasSearchResults = state.searchResults != null;
            final List<TaskModel> tasksToShow =
                hasSearchResults ? state.searchResults! : state.tasks;

            // If searching, always show a flat list. Otherwise, show the selected view.
            if (hasSearchResults) {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: tasksToShow.length,
                itemBuilder: (context, index) {
                  return GlassyTaskCard(task: tasksToShow[index]);
                },
              );
            } else {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isCalendarView
                    ? CalendarTaskView(
                        key: const ValueKey('calendar'), tasks: tasksToShow)
                    : GroupedTaskListView(
                        key: const ValueKey('list'), tasks: tasksToShow),
              );
            }
          },
        ),
      ),
    );
  }
}
