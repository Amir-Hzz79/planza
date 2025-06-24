// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LangEn extends Lang {
  LangEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Planza';

  @override
  String get general_add => 'Add';

  @override
  String get general_save => 'Save Changes';

  @override
  String get general_create => 'Create';

  @override
  String get general_delete => 'Delete';

  @override
  String get general_deleteConfirm => 'Confirm Delete';

  @override
  String get general_edit => 'Edit';

  @override
  String get general_cancel => 'Cancel';

  @override
  String get general_done => 'Done';

  @override
  String get general_tasks => 'Tasks';

  @override
  String get general_goals => 'Goals';

  @override
  String get general_description => 'Description';

  @override
  String get general_title => 'Title';

  @override
  String get general_status => 'Status';

  @override
  String get general_priority => 'Priority';

  @override
  String get general_tags => 'Tags';

  @override
  String get general_deadline => 'Deadline';

  @override
  String get general_color => 'Color';

  @override
  String get general_icon => 'Icon';

  @override
  String get general_optional => 'Optional';

  @override
  String get general_today => 'Today';

  @override
  String get general_overdue => 'Overdue';

  @override
  String get general_completed => 'Completed';

  @override
  String get general_profile => 'Profile';

  @override
  String get general_language => 'Language';

  @override
  String get general_settings => 'Settings';

  @override
  String get general_support => 'Support';

  @override
  String get general_about => 'About';

  @override
  String get general_exitConfirm => 'Press back again to exit';

  @override
  String get general_share => 'Share';

  @override
  String get general_achievement => 'ACHIEVEMENT';

  @override
  String general_duration_day(int dayCount) {
    return '$dayCount Days';
  }

  @override
  String get homePage_title => 'Your Dashboard';

  @override
  String get homePage_greeting_morning => 'Good Morning!';

  @override
  String get homePage_greeting_afternoon => 'Good Afternoon!';

  @override
  String get homePage_greeting_evening => 'Good Evening!';

  @override
  String get homePage_todaysFocus_title => 'Today\'s Focus 🔥';

  @override
  String get homePage_todaysFocus_empty => 'You\'re all clear for today!\nReady to plan your next move?';

  @override
  String get homePage_activeGoals_title => 'Driving These Goals';

  @override
  String get homePage_momentum_title => 'Your Weekly Momentum';

  @override
  String get homePage_energy_title => 'Where Your Energy Goes';

  @override
  String get homePage_fab_addTask => 'New Task';

  @override
  String get homePage_fab_addGoal => 'New Goal';

  @override
  String get goalsPage_title => 'My Ambitions';

  @override
  String get goalsPage_active_tab => 'Active';

  @override
  String get goalsPage_completed_tab => 'Completed';

  @override
  String get goalsPage_active_empty => 'Every great journey starts with a single goal.\nAdd your first one!';

  @override
  String get goalsPage_completed_empty => 'You haven\'t completed any goals yet.\nKeep going!';

  @override
  String get goalsPage_goals_empty => 'Your ambitions will appear here.\nLet\'s create your first goal!';

  @override
  String get goalsPage_addGoal_button => 'Create a Goal';

  @override
  String get goalsPage_featuredGoals_title => 'Up Next...';

  @override
  String get goalsPage_activeGoals_title => 'Keep Going!';

  @override
  String get goalsPage_completedGoals_title => 'Hall of Fame 🏆';

  @override
  String get goalDetailsPage_notExist => 'This goal no longer exists.';

  @override
  String get goalDetailsPage_editGoal => 'Edit Goal';

  @override
  String get goalDetailsPage_deleteGoal => 'Delete Goal';

  @override
  String goalCard_taskCount(int taskCount) {
    return '$taskCount Tasks';
  }

  @override
  String get tasksPage_title => 'My Tasks';

  @override
  String get tasksPage_search_hint => 'Search tasks, goals, tags...';

  @override
  String get tasksPage_filter_title => 'Sort & Filter';

  @override
  String get tasksPage_filter_reset => 'Reset';

  @override
  String get tasksPage_filter_apply => 'Apply Filters';

  @override
  String get tasksPage_filter_showCompleted => 'Show Completed Tasks';

  @override
  String get tasksPage_filter_goal_title => 'Filter by Goal';

  @override
  String tasksPage_filter_goal_selected(int goalCount) {
    return '$goalCount selected';
  }

  @override
  String get tasksPage_filter_goalSelection_title => 'Select Goals';

  @override
  String get tasksPage_filter_tag_title => 'Filter by Tags';

  @override
  String tasksPage_filter_tag_selected(int tagCount) {
    return '$tagCount selected';
  }

  @override
  String get tasksPage_filter_tagSelection_title => 'Select Tags';

  @override
  String get tasksPage_calendar_noTasks => 'No tasks for this day.';

  @override
  String get tasksPage_calendar_addTask_toolTip => 'Add Task for this day';

  @override
  String tasksPage_calendar_sheet_title(String date) {
    return 'Tasks for $date';
  }

  @override
  String get tasksPage_grouped_overdue => 'Overdue';

  @override
  String get tasksPage_grouped_today => 'Today';

  @override
  String get tasksPage_grouped_tomorrow => 'Tomorrow';

  @override
  String get tasksPage_grouped_noDate => 'No Date';

  @override
  String get tasksPage_grouped_empty => 'No tasks found.';

  @override
  String get taskDetailsPage_goal_label => 'Goal';

  @override
  String get taskDetailsPage_date_label => 'Due Date';

  @override
  String get taskDetailsPage_priority_label => 'Priority';

  @override
  String get taskDetailsPage_tags_label => 'Tags';

  @override
  String taskDetailsPage_checklist_title(int subtaskCount) {
    return 'Checklist ($subtaskCount)';
  }

  @override
  String taskDetailsPage_priorityLevel(int level) {
    return 'Level $level';
  }

  @override
  String get addGoalPage_title_add => 'Create a Goal';

  @override
  String get addGoalPage_title_edit => 'Edit Goal';

  @override
  String get addGoalPage_name_label => 'Goal Name';

  @override
  String get addGoalPage_name_validator => 'Please enter a name';

  @override
  String get addGoalPage_name_required => 'Every goal needs a name!';

  @override
  String get addGoalPage_description_label => 'Description (Optional)';

  @override
  String get addGoalPage_description_hint => 'Add more details about your goal...';

  @override
  String get addGoalPage_color_label => 'Choose a Color';

  @override
  String get addGoalPage_icon_label => 'Choose an Icon';

  @override
  String get addGoalPage_deadline_label => 'Deadline (Optional)';

  @override
  String get addGoalPage_deadline_notSet => 'Not set';

  @override
  String get addGoalPage_tasks_label => 'Add first steps (Optional)';

  @override
  String get addGoalPage_tasks_hint => 'Add a new step...';

  @override
  String get addGoalPage_button_add => 'Create Goal';

  @override
  String get addGoalPage_button_edit => 'Save Changes';

  @override
  String get addGoalPage_noDate => 'Not set';

  @override
  String addGoalPage_tasks_index(int index) {
    return 'Task #$index';
  }

  @override
  String get addTaskSheet_title_add => 'New Task';

  @override
  String get addTaskSheet_title_edit => 'Edit Task';

  @override
  String get addTaskSheet_hint => 'e.g., Finish presentation by 5 PM';

  @override
  String get addTaskSheet_button_add => 'Add Task';

  @override
  String get addTaskSheet_button_edit => 'Save Changes';

  @override
  String get addTaskSheet_chip_noGoal => 'No Goal';

  @override
  String get addTaskSheet_chip_dueDate => 'Due Date';

  @override
  String get addTaskSheet_edit_successMessage => 'Task Updated!';

  @override
  String get addTaskSheet_add_successMessage => 'Task Added!';

  @override
  String deleteDialog_goal_title(String goalName) {
    return 'Delete \'$goalName\'?';
  }

  @override
  String deleteDialog_goal_content(int taskCount) {
    return 'This goal contains $taskCount tasks. This action cannot be undone.';
  }

  @override
  String get deleteDialog_goal_options_title => 'Please choose how to handle these tasks:';

  @override
  String get deleteDialog_goal_option_unassign_title => 'Unassign tasks & delete goal';

  @override
  String get deleteDialog_goal_option_unassign_subtitle => 'The tasks will be kept without a goal.';

  @override
  String get deleteDialog_goal_option_deleteAll_title => 'Delete goal AND all tasks';

  @override
  String deleteDialog_goal_option_deleteAll_subtitle(int taskCount) {
    return 'All \$$taskCount tasks will be permanently deleted.';
  }

  @override
  String get deleteDialog_task_title => 'Delete Task?';

  @override
  String get deleteDialog_task_content => 'Are you sure you want to permanently delete this task? This action cannot be undone.';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left',
      one: '1 day left',
      zero: 'Due today',
    );
    return '$_temp0';
  }

  @override
  String get goalSelection_noGoal => 'No Goal';
}
