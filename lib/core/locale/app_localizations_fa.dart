// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class LangFa extends Lang {
  LangFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'پلانزا';

  @override
  String get general_add => 'افزودن';

  @override
  String get general_save => 'ذخیره تغییرات';

  @override
  String get general_create => 'ساختن';

  @override
  String get general_delete => 'حذف';

  @override
  String get general_deleteConfirm => 'تایید حذف';

  @override
  String get general_edit => 'ویرایش';

  @override
  String get general_cancel => 'لغو';

  @override
  String get general_done => 'انجام شد';

  @override
  String get general_tasks => 'کارها';

  @override
  String get general_goals => 'اهداف';

  @override
  String get general_description => 'توضیحات';

  @override
  String get general_title => 'عنوان';

  @override
  String get general_status => 'وضعیت';

  @override
  String get general_priority => 'اولویت';

  @override
  String get general_tags => 'برچسب‌ها';

  @override
  String get general_deadline => 'موعد مقرر';

  @override
  String get general_color => 'رنگ';

  @override
  String get general_icon => 'آیکون';

  @override
  String get general_optional => '(اختیاری)';

  @override
  String get general_today => 'امروز';

  @override
  String get general_overdue => 'موعد گذشته';

  @override
  String get general_completed => 'تکمیل شده';

  @override
  String get general_profile => 'پروفایل';

  @override
  String get general_language => 'زبان';

  @override
  String get general_settings => 'تنظیمات';

  @override
  String get general_support => 'پشتیبانی';

  @override
  String get general_about => 'درباره ما';

  @override
  String get general_exitConfirm => 'برای خروج دوباره بازگشت را بزنید';

  @override
  String get general_share => 'اشتراک‌گذاری';

  @override
  String get general_achievement => 'دستاورد';

  @override
  String general_duration_day(int dayCount) {
    return '$dayCount روز';
  }

  @override
  String get homePage_title => 'داشبورد شما';

  @override
  String get homePage_greeting_morning => 'صبح بخیر!';

  @override
  String get homePage_greeting_afternoon => 'عصر بخیر!';

  @override
  String get homePage_greeting_evening => 'شب بخیر!';

  @override
  String get homePage_todaysFocus_title => 'تمرکز امروز 🔥';

  @override
  String get homePage_todaysFocus_empty => 'برای امروز همه چیز تمیزه!\nبرای حرکت بعدی آماده‌ای؟';

  @override
  String get homePage_activeGoals_title => 'در مسیر این اهداف';

  @override
  String get homePage_momentum_title => 'مومنتوم هفتگی شما';

  @override
  String get homePage_energy_title => 'انرژی شما کجا صرف می‌شود';

  @override
  String get homePage_fab_addTask => 'کار جدید';

  @override
  String get homePage_fab_addGoal => 'هدف جدید';

  @override
  String get goalsPage_title => 'جاه‌طلبی‌های من';

  @override
  String get goalsPage_active_tab => 'فعال';

  @override
  String get goalsPage_completed_tab => 'تکمیل شده';

  @override
  String get goalsPage_active_empty => 'هر سفر بزرگی با یک قدم کوچک شروع می‌شه.\nاولین هدفت رو بساز!';

  @override
  String get goalsPage_completed_empty => 'هنوز هیچ هدفی رو کامل نکردی.\nادامه بده!';

  @override
  String get goalsPage_goals_empty => 'جاه‌طلبی‌های تو اینجا نمایش داده می‌شن.\nبیا اولین هدفت رو بسازیم!';

  @override
  String get goalsPage_addGoal_button => 'ساختن یک هدف';

  @override
  String get goalsPage_featuredGoals_title => 'قدم بعدی...';

  @override
  String get goalsPage_activeGoals_title => 'ادامه بده!';

  @override
  String get goalsPage_completedGoals_title => 'تالار افتخارات 🏆';

  @override
  String get goalDetailsPage_notExist => 'این هدف دیگر وجود ندارد.';

  @override
  String get goalDetailsPage_editGoal => 'ویرایش هدف';

  @override
  String get goalDetailsPage_deleteGoal => 'حذف هدف';

  @override
  String goalCard_taskCount(int taskCount) {
    return '$taskCount کار';
  }

  @override
  String get tasksPage_title => 'کارهای من';

  @override
  String get tasksPage_search_hint => 'جستجوی کار، هدف، برچسب...';

  @override
  String get tasksPage_filter_title => 'مرتب‌سازی و فیلتر';

  @override
  String get tasksPage_filter_reset => 'بازنشانی';

  @override
  String get tasksPage_filter_apply => 'اعمال فیلترها';

  @override
  String get tasksPage_filter_showCompleted => 'نمایش کارهای تکمیل شده';

  @override
  String get tasksPage_filter_goal_title => 'فیلتر بر اساس هدف';

  @override
  String tasksPage_filter_goal_selected(int goalCount) {
    return '$goalCount انتخاب شده';
  }

  @override
  String get tasksPage_filter_goalSelection_title => 'انتخاب اهداف';

  @override
  String get tasksPage_filter_tag_title => 'فیلتر بر اساس برچسب';

  @override
  String tasksPage_filter_tag_selected(int tagCount) {
    return '$tagCount انتخاب شده';
  }

  @override
  String get tasksPage_filter_tagSelection_title => 'انتخاب برچسب‌ها';

  @override
  String get tasksPage_calendar_noTasks => 'کاری برای این روز نیست.';

  @override
  String get tasksPage_calendar_addTask_toolTip => 'افزودن کار برای این روز';

  @override
  String tasksPage_calendar_sheet_title(String date) {
    return 'کارهای تاریخ $date';
  }

  @override
  String get tasksPage_grouped_overdue => 'موعد گذشته';

  @override
  String get tasksPage_grouped_today => 'امروز';

  @override
  String get tasksPage_grouped_tomorrow => 'فردا';

  @override
  String get tasksPage_grouped_noDate => 'بدون تاریخ';

  @override
  String get tasksPage_grouped_empty => 'کاری یافت نشد.';

  @override
  String get taskDetailsPage_goal_label => 'هدف';

  @override
  String get taskDetailsPage_date_label => 'موعد';

  @override
  String get taskDetailsPage_priority_label => 'اولویت';

  @override
  String get taskDetailsPage_tags_label => 'برچسب‌ها';

  @override
  String taskDetailsPage_checklist_title(int subtaskCount) {
    return 'چک‌لیست ($subtaskCount)';
  }

  @override
  String taskDetailsPage_priorityLevel(int level) {
    return 'سطح $level';
  }

  @override
  String get addGoalPage_title_add => 'ساختن هدف';

  @override
  String get addGoalPage_title_edit => 'ویرایش هدف';

  @override
  String get addGoalPage_name_label => 'نام هدف';

  @override
  String get addGoalPage_name_validator => 'لطفا یک نام وارد کنید';

  @override
  String get addGoalPage_name_required => 'هر هدفی به یک نام نیاز داره!';

  @override
  String get addGoalPage_description_label => 'توضیحات (اختیاری)';

  @override
  String get addGoalPage_description_hint => 'جزئیات بیشتری درباره هدفت بنویس...';

  @override
  String get addGoalPage_color_label => 'یک رنگ انتخاب کن';

  @override
  String get addGoalPage_icon_label => 'یک آیکون انتخاب کن';

  @override
  String get addGoalPage_deadline_label => 'موعد مقرر (اختیاری)';

  @override
  String get addGoalPage_deadline_notSet => 'تعیین نشده';

  @override
  String get addGoalPage_tasks_label => 'اولین قدم‌ها رو اضافه کن (اختیاری)';

  @override
  String get addGoalPage_tasks_hint => 'اضافه کردن یک قدم جدید...';

  @override
  String get addGoalPage_button_add => 'بسازش!';

  @override
  String get addGoalPage_button_edit => 'ذخیره تغییرات';

  @override
  String get addGoalPage_noDate => 'تعیین نشده';

  @override
  String addGoalPage_tasks_index(int index) {
    return 'کار #$index';
  }

  @override
  String get addTaskSheet_title_add => 'کار جدید';

  @override
  String get addTaskSheet_title_edit => 'ویرایش کار';

  @override
  String get addTaskSheet_hint => 'مثلا: تمام کردن گزارش تا ساعت ۵ عصر';

  @override
  String get addTaskSheet_button_add => 'افزودن کار';

  @override
  String get addTaskSheet_button_edit => 'ذخیره تغییرات';

  @override
  String get addTaskSheet_chip_noGoal => 'بدون هدف';

  @override
  String get addTaskSheet_chip_dueDate => 'تاریخ موعد';

  @override
  String get addTaskSheet_edit_successMessage => 'کار ویرایش شد!';

  @override
  String get addTaskSheet_add_successMessage => 'کار اضافه شد!';

  @override
  String deleteDialog_goal_title(String goalName) {
    return 'حذف هدف \'$goalName\'؟';
  }

  @override
  String deleteDialog_goal_content(int taskCount) {
    return 'این هدف شامل $taskCount کار است. این عمل قابل بازگشت نیست.';
  }

  @override
  String get deleteDialog_goal_options_title => 'لطفا مشخص کنید با این کارها چه شود:';

  @override
  String get deleteDialog_goal_option_unassign_title => 'حذف هدف و بی‌هدف کردن کارها';

  @override
  String get deleteDialog_goal_option_unassign_subtitle => 'کارها باقی می‌مانند اما دیگر هدفی ندارند.';

  @override
  String get deleteDialog_goal_option_deleteAll_title => 'حذف هدف و تمام کارهای آن';

  @override
  String deleteDialog_goal_option_deleteAll_subtitle(int taskCount) {
    return 'تمام \$$taskCount کار برای همیشه حذف خواهند شد.';
  }

  @override
  String get deleteDialog_task_title => 'حذف کار؟';

  @override
  String get deleteDialog_task_content => 'آیا از حذف دائمی این کار مطمئن هستید؟ این عمل قابل بازگشت نیست.';

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز مانده',
      one: '۱ روز مانده',
      zero: 'موعد امروز است',
    );
    return '$_temp0';
  }

  @override
  String get goalSelection_noGoal => 'بدون هدف';
}
