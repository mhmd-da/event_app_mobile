// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحبا';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get welcomeMessage => 'مرحبًا بك في KSU Tamkeen X 2026';

  @override
  String get noEventSelected => 'لم يتم اختيار أي حدث';

  @override
  String get home => 'الرئيسية';

  @override
  String get agenda => 'برنامج';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get sessions => 'المحاضرات';

  @override
  String get appTitle => 'KSU Tamkeen X 2026';

  @override
  String get toggleLanguage => 'تبديل اللغة';

  @override
  String get mySchedule => 'جدولي';

  @override
  String get errorLoadingSchedule => 'خطأ في تحميل البرنامج';

  @override
  String get noSessionsInYourSchedule => 'لا توجد محاضرات في جدولك';

  @override
  String get noSessionsFound => 'لم يتم العثور على محاضرات';

  @override
  String get mentors => 'المرشدون';

  @override
  String get noMentorsFound => 'لم يتم العثور على مرشدين';

  @override
  String get errorLoadingMentors => 'خطأ في تحميل المرشدين';

  @override
  String get speakers => 'المتحدثون';

  @override
  String get noSpeakersFound => 'لم يتم العثور على متحدثين';

  @override
  String get errorLoadingSpeakers => 'خطأ في تحميل المتحدثين';

  @override
  String get noSessionsLinkedYet => 'لا توجد محاضرات مرتبطة بعد.';

  @override
  String get selectEvent => 'اختر حدثًا';

  @override
  String get speakersLabel => '🎤 المتحدثون';

  @override
  String get mentorsLabel => '🧠 المرشدون';

  @override
  String get searchHint => 'ابحث بالاسم أو الشركة أو الوظيفة...';

  @override
  String get about => 'حول';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get noSessionsAvailable => 'لا توجد محاضرات متاحة';

  @override
  String get browseAllSessionsBanner =>
      'تصفح جميع المحاضرات والمتحدثين وبرنامج الفعالية';

  @override
  String get past => 'الماضية';

  @override
  String get ongoing => 'المستمرة';

  @override
  String get future => 'المستقبلية';

  @override
  String get workshops => 'ورش عمل';

  @override
  String get roundtables => 'موائد مستديرة';

  @override
  String get mentorship => 'الإرشاد';

  @override
  String get resources => 'الموارد';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get sponsors => 'الرعاة';

  @override
  String get partners => 'الشركاء';

  @override
  String get exhibitions => 'المعارض';

  @override
  String get eventInfo => 'معلومات الفعالية';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get loginToContinue => 'قم بتسجيل الدخول لمتابعة رحلتك في الفعالية.';

  @override
  String get emailLabel => 'البريد الإلكتروني، المعرف، رقم الهاتف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get continueButton => 'متابعة';

  @override
  String get dontHaveAccountRegister => 'ليس لديك حساب؟ سجّل';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get faqs => 'الأسئلة الشائعة';

  @override
  String languageUpdated(Object language) {
    return 'تم تحديث اللغة إلى $language';
  }

  @override
  String get languageUpdateFailed => 'فشل في تحديث اللغة';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get venue => 'المكان';
}
