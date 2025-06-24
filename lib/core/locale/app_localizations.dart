import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Lang
/// returned by `Lang.of(context)`.
///
/// Applications need to include `Lang.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'locale/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Lang.localizationsDelegates,
///   supportedLocales: Lang.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Lang.supportedLocales
/// property.
abstract class Lang {
  Lang(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Lang? of(BuildContext context) {
    return Localizations.of<Lang>(context, Lang);
  }

  static const LocalizationsDelegate<Lang> delegate = _LangDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Planza'**
  String get appName;

  /// No description provided for @general_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get general_add;

  /// No description provided for @general_save.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get general_save;

  /// No description provided for @general_create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get general_create;

  /// No description provided for @general_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get general_delete;

  /// No description provided for @general_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get general_deleteConfirm;

  /// No description provided for @general_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get general_edit;

  /// No description provided for @general_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get general_cancel;

  /// No description provided for @general_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get general_done;

  /// No description provided for @general_tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get general_tasks;

  /// No description provided for @general_goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get general_goals;

  /// No description provided for @general_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get general_description;

  /// No description provided for @general_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get general_title;

  /// No description provided for @general_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get general_status;

  /// No description provided for @general_priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get general_priority;

  /// No description provided for @general_tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get general_tags;

  /// No description provided for @general_deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get general_deadline;

  /// No description provided for @general_color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get general_color;

  /// No description provided for @general_icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get general_icon;

  /// No description provided for @general_optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get general_optional;

  /// No description provided for @general_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get general_today;

  /// No description provided for @general_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get general_overdue;

  /// No description provided for @general_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get general_completed;

  /// No description provided for @general_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get general_profile;

  /// No description provided for @general_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get general_language;

  /// No description provided for @general_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get general_settings;

  /// No description provided for @general_support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get general_support;

  /// No description provided for @general_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get general_about;

  /// No description provided for @general_exitConfirm.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get general_exitConfirm;

  /// No description provided for @general_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get general_share;

  /// No description provided for @general_achievement.
  ///
  /// In en, this message translates to:
  /// **'ACHIEVEMENT'**
  String get general_achievement;

  /// No description provided for @general_duration_day.
  ///
  /// In en, this message translates to:
  /// **'{dayCount} Days'**
  String general_duration_day(int dayCount);

  /// No description provided for @homePage_title.
  ///
  /// In en, this message translates to:
  /// **'Your Dashboard'**
  String get homePage_title;

  /// No description provided for @homePage_greeting_morning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning!'**
  String get homePage_greeting_morning;

  /// No description provided for @homePage_greeting_afternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon!'**
  String get homePage_greeting_afternoon;

  /// No description provided for @homePage_greeting_evening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening!'**
  String get homePage_greeting_evening;

  /// No description provided for @homePage_todaysFocus_title.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Focus 🔥'**
  String get homePage_todaysFocus_title;

  /// No description provided for @homePage_todaysFocus_empty.
  ///
  /// In en, this message translates to:
  /// **'You\'re all clear for today!\nReady to plan your next move?'**
  String get homePage_todaysFocus_empty;

  /// No description provided for @homePage_activeGoals_title.
  ///
  /// In en, this message translates to:
  /// **'Driving These Goals'**
  String get homePage_activeGoals_title;

  /// No description provided for @homePage_momentum_title.
  ///
  /// In en, this message translates to:
  /// **'Your Weekly Momentum'**
  String get homePage_momentum_title;

  /// No description provided for @homePage_energy_title.
  ///
  /// In en, this message translates to:
  /// **'Where Your Energy Goes'**
  String get homePage_energy_title;

  /// No description provided for @homePage_fab_addTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get homePage_fab_addTask;

  /// No description provided for @homePage_fab_addGoal.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get homePage_fab_addGoal;

  /// No description provided for @goalsPage_title.
  ///
  /// In en, this message translates to:
  /// **'My Ambitions'**
  String get goalsPage_title;

  /// No description provided for @goalsPage_active_tab.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get goalsPage_active_tab;

  /// No description provided for @goalsPage_completed_tab.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get goalsPage_completed_tab;

  /// No description provided for @goalsPage_active_empty.
  ///
  /// In en, this message translates to:
  /// **'Every great journey starts with a single goal.\nAdd your first one!'**
  String get goalsPage_active_empty;

  /// No description provided for @goalsPage_completed_empty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t completed any goals yet.\nKeep going!'**
  String get goalsPage_completed_empty;

  /// No description provided for @goalsPage_goals_empty.
  ///
  /// In en, this message translates to:
  /// **'Your ambitions will appear here.\nLet\'s create your first goal!'**
  String get goalsPage_goals_empty;

  /// No description provided for @goalsPage_addGoal_button.
  ///
  /// In en, this message translates to:
  /// **'Create a Goal'**
  String get goalsPage_addGoal_button;

  /// No description provided for @goalsPage_featuredGoals_title.
  ///
  /// In en, this message translates to:
  /// **'Up Next...'**
  String get goalsPage_featuredGoals_title;

  /// No description provided for @goalsPage_activeGoals_title.
  ///
  /// In en, this message translates to:
  /// **'Keep Going!'**
  String get goalsPage_activeGoals_title;

  /// No description provided for @goalsPage_completedGoals_title.
  ///
  /// In en, this message translates to:
  /// **'Hall of Fame 🏆'**
  String get goalsPage_completedGoals_title;

  /// No description provided for @goalDetailsPage_notExist.
  ///
  /// In en, this message translates to:
  /// **'This goal no longer exists.'**
  String get goalDetailsPage_notExist;

  /// No description provided for @goalDetailsPage_editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get goalDetailsPage_editGoal;

  /// No description provided for @goalDetailsPage_deleteGoal.
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get goalDetailsPage_deleteGoal;

  /// No description provided for @goalCard_taskCount.
  ///
  /// In en, this message translates to:
  /// **'{taskCount} Tasks'**
  String goalCard_taskCount(int taskCount);

  /// No description provided for @tasksPage_title.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get tasksPage_title;

  /// No description provided for @tasksPage_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks, goals, tags...'**
  String get tasksPage_search_hint;

  /// No description provided for @tasksPage_filter_title.
  ///
  /// In en, this message translates to:
  /// **'Sort & Filter'**
  String get tasksPage_filter_title;

  /// No description provided for @tasksPage_filter_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get tasksPage_filter_reset;

  /// No description provided for @tasksPage_filter_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get tasksPage_filter_apply;

  /// No description provided for @tasksPage_filter_showCompleted.
  ///
  /// In en, this message translates to:
  /// **'Show Completed Tasks'**
  String get tasksPage_filter_showCompleted;

  /// No description provided for @tasksPage_filter_goal_title.
  ///
  /// In en, this message translates to:
  /// **'Filter by Goal'**
  String get tasksPage_filter_goal_title;

  /// No description provided for @tasksPage_filter_goal_selected.
  ///
  /// In en, this message translates to:
  /// **'{goalCount} selected'**
  String tasksPage_filter_goal_selected(int goalCount);

  /// No description provided for @tasksPage_filter_goalSelection_title.
  ///
  /// In en, this message translates to:
  /// **'Select Goals'**
  String get tasksPage_filter_goalSelection_title;

  /// No description provided for @tasksPage_filter_tag_title.
  ///
  /// In en, this message translates to:
  /// **'Filter by Tags'**
  String get tasksPage_filter_tag_title;

  /// No description provided for @tasksPage_filter_tag_selected.
  ///
  /// In en, this message translates to:
  /// **'{tagCount} selected'**
  String tasksPage_filter_tag_selected(int tagCount);

  /// No description provided for @tasksPage_filter_tagSelection_title.
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get tasksPage_filter_tagSelection_title;

  /// No description provided for @tasksPage_calendar_noTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks for this day.'**
  String get tasksPage_calendar_noTasks;

  /// No description provided for @tasksPage_calendar_addTask_toolTip.
  ///
  /// In en, this message translates to:
  /// **'Add Task for this day'**
  String get tasksPage_calendar_addTask_toolTip;

  /// No description provided for @tasksPage_calendar_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Tasks for {date}'**
  String tasksPage_calendar_sheet_title(String date);

  /// No description provided for @tasksPage_grouped_overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get tasksPage_grouped_overdue;

  /// No description provided for @tasksPage_grouped_today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tasksPage_grouped_today;

  /// No description provided for @tasksPage_grouped_tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tasksPage_grouped_tomorrow;

  /// No description provided for @tasksPage_grouped_noDate.
  ///
  /// In en, this message translates to:
  /// **'No Date'**
  String get tasksPage_grouped_noDate;

  /// No description provided for @tasksPage_grouped_empty.
  ///
  /// In en, this message translates to:
  /// **'No tasks found.'**
  String get tasksPage_grouped_empty;

  /// No description provided for @taskDetailsPage_goal_label.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get taskDetailsPage_goal_label;

  /// No description provided for @taskDetailsPage_date_label.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get taskDetailsPage_date_label;

  /// No description provided for @taskDetailsPage_priority_label.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get taskDetailsPage_priority_label;

  /// No description provided for @taskDetailsPage_tags_label.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get taskDetailsPage_tags_label;

  /// No description provided for @taskDetailsPage_checklist_title.
  ///
  /// In en, this message translates to:
  /// **'Checklist ({subtaskCount})'**
  String taskDetailsPage_checklist_title(int subtaskCount);

  /// No description provided for @taskDetailsPage_priorityLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String taskDetailsPage_priorityLevel(int level);

  /// No description provided for @addGoalPage_title_add.
  ///
  /// In en, this message translates to:
  /// **'Create a Goal'**
  String get addGoalPage_title_add;

  /// No description provided for @addGoalPage_title_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get addGoalPage_title_edit;

  /// No description provided for @addGoalPage_name_label.
  ///
  /// In en, this message translates to:
  /// **'Goal Name'**
  String get addGoalPage_name_label;

  /// No description provided for @addGoalPage_name_validator.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get addGoalPage_name_validator;

  /// No description provided for @addGoalPage_name_required.
  ///
  /// In en, this message translates to:
  /// **'Every goal needs a name!'**
  String get addGoalPage_name_required;

  /// No description provided for @addGoalPage_description_label.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get addGoalPage_description_label;

  /// No description provided for @addGoalPage_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Add more details about your goal...'**
  String get addGoalPage_description_hint;

  /// No description provided for @addGoalPage_color_label.
  ///
  /// In en, this message translates to:
  /// **'Choose a Color'**
  String get addGoalPage_color_label;

  /// No description provided for @addGoalPage_icon_label.
  ///
  /// In en, this message translates to:
  /// **'Choose an Icon'**
  String get addGoalPage_icon_label;

  /// No description provided for @addGoalPage_deadline_label.
  ///
  /// In en, this message translates to:
  /// **'Deadline (Optional)'**
  String get addGoalPage_deadline_label;

  /// No description provided for @addGoalPage_deadline_notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get addGoalPage_deadline_notSet;

  /// No description provided for @addGoalPage_tasks_label.
  ///
  /// In en, this message translates to:
  /// **'Add first steps (Optional)'**
  String get addGoalPage_tasks_label;

  /// No description provided for @addGoalPage_tasks_hint.
  ///
  /// In en, this message translates to:
  /// **'Add a new step...'**
  String get addGoalPage_tasks_hint;

  /// No description provided for @addGoalPage_button_add.
  ///
  /// In en, this message translates to:
  /// **'Create Goal'**
  String get addGoalPage_button_add;

  /// No description provided for @addGoalPage_button_edit.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get addGoalPage_button_edit;

  /// No description provided for @addGoalPage_noDate.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get addGoalPage_noDate;

  /// No description provided for @addGoalPage_tasks_index.
  ///
  /// In en, this message translates to:
  /// **'Task #{index}'**
  String addGoalPage_tasks_index(int index);

  /// No description provided for @addTaskSheet_title_add.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get addTaskSheet_title_add;

  /// No description provided for @addTaskSheet_title_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get addTaskSheet_title_edit;

  /// No description provided for @addTaskSheet_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Finish presentation by 5 PM'**
  String get addTaskSheet_hint;

  /// No description provided for @addTaskSheet_button_add.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTaskSheet_button_add;

  /// No description provided for @addTaskSheet_button_edit.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get addTaskSheet_button_edit;

  /// No description provided for @addTaskSheet_chip_noGoal.
  ///
  /// In en, this message translates to:
  /// **'No Goal'**
  String get addTaskSheet_chip_noGoal;

  /// No description provided for @addTaskSheet_chip_dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get addTaskSheet_chip_dueDate;

  /// No description provided for @addTaskSheet_edit_successMessage.
  ///
  /// In en, this message translates to:
  /// **'Task Updated!'**
  String get addTaskSheet_edit_successMessage;

  /// No description provided for @addTaskSheet_add_successMessage.
  ///
  /// In en, this message translates to:
  /// **'Task Added!'**
  String get addTaskSheet_add_successMessage;

  /// No description provided for @deleteDialog_goal_title.
  ///
  /// In en, this message translates to:
  /// **'Delete \'{goalName}\'?'**
  String deleteDialog_goal_title(String goalName);

  /// No description provided for @deleteDialog_goal_content.
  ///
  /// In en, this message translates to:
  /// **'This goal contains {taskCount} tasks. This action cannot be undone.'**
  String deleteDialog_goal_content(int taskCount);

  /// No description provided for @deleteDialog_goal_options_title.
  ///
  /// In en, this message translates to:
  /// **'Please choose how to handle these tasks:'**
  String get deleteDialog_goal_options_title;

  /// No description provided for @deleteDialog_goal_option_unassign_title.
  ///
  /// In en, this message translates to:
  /// **'Unassign tasks & delete goal'**
  String get deleteDialog_goal_option_unassign_title;

  /// No description provided for @deleteDialog_goal_option_unassign_subtitle.
  ///
  /// In en, this message translates to:
  /// **'The tasks will be kept without a goal.'**
  String get deleteDialog_goal_option_unassign_subtitle;

  /// No description provided for @deleteDialog_goal_option_deleteAll_title.
  ///
  /// In en, this message translates to:
  /// **'Delete goal AND all tasks'**
  String get deleteDialog_goal_option_deleteAll_title;

  /// No description provided for @deleteDialog_goal_option_deleteAll_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All \${taskCount} tasks will be permanently deleted.'**
  String deleteDialog_goal_option_deleteAll_subtitle(int taskCount);

  /// No description provided for @deleteDialog_task_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Task?'**
  String get deleteDialog_task_title;

  /// No description provided for @deleteDialog_task_content.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this task? This action cannot be undone.'**
  String get deleteDialog_task_content;

  /// A string indicating the number of days left until a deadline.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Due today} =1{1 day left} other{{count} days left}}'**
  String daysLeft(int count);

  /// No description provided for @goalSelection_noGoal.
  ///
  /// In en, this message translates to:
  /// **'No Goal'**
  String get goalSelection_noGoal;
}

class _LangDelegate extends LocalizationsDelegate<Lang> {
  const _LangDelegate();

  @override
  Future<Lang> load(Locale locale) {
    return SynchronousFuture<Lang>(lookupLang(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_LangDelegate old) => false;
}

Lang lookupLang(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return LangEn();
    case 'fa': return LangFa();
  }

  throw FlutterError(
    'Lang.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
