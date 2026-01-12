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
  String get moderator => 'مُدير الجلسة';

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
  String get socialLinks => 'روابط التواصل';

  @override
  String get noSocialLinksAvailable => 'لا توجد روابط تواصل.';

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
  String get loginHeading => 'تسجيل الدخول';

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
  String languageUpdated(String language) {
    return 'تم تحديث اللغة إلى $language';
  }

  @override
  String get languageUpdateFailed => 'فشل في تحديث اللغة';

  @override
  String get sessionChatTitle => 'دردشة الجلسة';

  @override
  String get typeMessageHint => 'اكتب رسالة';

  @override
  String get sendLabel => 'إرسال';

  @override
  String get youLabel => 'أنت';

  @override
  String get myQrTitle => 'رمز الاستجابة السريعة الخاص بي';

  @override
  String get myQrSubtitle => 'اعرض هذا الرمز للموظفين لإتمام تسجيل الدخول.';

  @override
  String get qrNotAvailable => 'رمز الاستجابة السريعة غير متوفر.';

  @override
  String get qrNotAvailableHint =>
      'يرجى تسجيل الدخول مرة أخرى أثناء الاتصال بالإنترنت.';

  @override
  String get qrTitle => 'رمز QR';

  @override
  String get scanQrTitle => 'مسح رمز QR';

  @override
  String get processing => 'جارٍ المعالجة…';

  @override
  String get checkInSuccess => 'تم تسجيل الدخول';

  @override
  String get checkInFailed => 'فشل تسجيل الدخول';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get venue => 'المكان';

  @override
  String get venueMap => 'خريطة المكان';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get aboutEvent => 'عن الفعالية';

  @override
  String get venueAndInfo => 'المكان والمعلومات';

  @override
  String get venueMapSubtitle => 'عرض جميع القاعات والغرف';

  @override
  String get faqsSubtitle => 'أسئلة شائعة';

  @override
  String get contactUsSubtitle => 'تواصل مع المنظمين';

  @override
  String get readMore => 'اقرأ المزيد';

  @override
  String get noDescriptionAvailable => 'لا يوجد وصف متاح.';

  @override
  String get homeNumbersTitle => 'الملتقى في أرقام';

  @override
  String get homeNumbersGuidanceHours => 'ساعة إرشادية';

  @override
  String get homeNumbersSpeakersExperts => 'متحدث وخبير';

  @override
  String get homeNumbersParticipatingEntities => 'جهة مشاركة';

  @override
  String get homeNumbersWorkshopsExperiences => 'ورشة عمل وتجارب عملية';

  @override
  String get homeNumbersVolunteers => 'متطوع ومتطوعة';

    @override
    String get countdownTitle => 'العد التنازلي حتى بدء الملتقى';

    @override
    String get countdownEventDateLine => '19 يناير 2026 • الساعة 10 صباحًا';

    @override
    String get countdownDays => 'يوم';

    @override
    String get countdownHours => 'ساعة';

    @override
    String get countdownMinutes => 'دقيقة';

    @override
    String get countdownSeconds => 'ثانية';

    @override
    String get homeQuoteText =>
      'إن مستقبل المملكة أيها الإخوة والأخوات مبشر وواعد، بإذن الله، و تستحق بلادنا الغالية أكثر مما تحقق. لدينا قدرات سنقوم بمضاعفة دورها وزيادة إسهامها في صناعة هذا المستقبل.';

    @override
    String get homeQuoteLeaderTitle => 'صاحب السمو الملكي';

    @override
    String get homeQuoteLeaderName =>
      'الأمير محمد بن سلمان بن عبد العزيز آل سعود';

    @override
    String get homeQuoteLeaderRole =>
      'ولي العهد، رئيس مجلس الوزراء، ورئيس مجلس الشؤون الاقتصادية والتنمية';

      @override
      String get forumAxesTitle => 'محاور الملتقى';

      @override
      String get day1Title => 'اليوم الأول';

      @override
      String get day1Description => 'بناء القدرات لمستقبل تنافسي';

      @override
      String get day2Title => 'اليوم الثاني';

      @override
      String get day2Description => 'بناء المهارات للجيل القادم: التمكين للمستقبل';

      @override
      String get day3Title => 'اليوم الثالث';

      @override
      String get day3Description => 'الأثر المجتمعي من خلال التدريب والتطوير';

      @override
      String get generalObjectiveTitle => 'الهدف العام';

      @override
      String get generalObjectiveDescription =>
        'تنمية القدرات البشرية لمنسوبي الجامعة من خلال التدريب وتعزيز بناء الشراكات المحلية والدولية لدعم التحول والتطوير المهني والأكاديمي بالجامعة بما يساهم في خدمة المجتمع.';

      @override
      String get visionTitle => 'الرؤية';

      @override
      String get visionDescription =>
        'الريادة في تطوير المهارات وتمكين رأس المال البشري عبر برامج تدريبية وشراكات نوعية.';

      @override
      String get missionTitle => 'الرسالة';

      @override
      String get missionDescription =>
        'الإسهام في تنمية قدرات منسوبي الجامعة لتمكينهم من المساهمة الفاعلة في خدمة المجتمع.';

  @override
  String get profile_name => 'الاسم';

  @override
  String get profile_email => 'البريد الإلكتروني';

  @override
  String get profile_phone => 'رقم الهاتف';

  @override
  String get profile_university => 'الجامعة';

  @override
  String get profile_department => 'القسم';

  @override
  String get profile_major => 'التخصص';

  @override
  String get groupByTime => 'عرض حسب الوقت';

  @override
  String get groupByTrack => 'عرض حسب المسار';

  @override
  String get groupByCategory => 'عرض حسب الفئة';

  @override
  String get allTracks => 'جميع المسارات';

  @override
  String get allCategories => 'جميع الفئات';

  @override
  String get sessionSpeakers => 'متحدثو الجلسة';

  @override
  String get poweredBy => 'برعاية';

  @override
  String get materials => 'المواد';

  @override
  String get giveFeedback => 'أرسل رأيك';

  @override
  String get sessionFeedbackTitle => 'ملاحظات الجلسة';

  @override
  String get feedbackHint => 'اكتب رأيك (اختياري)';

  @override
  String get submit => 'إرسال';

  @override
  String get pleaseSelectRating => 'يرجى اختيار تقييم';

  @override
  String get addToAgenda => 'أضف إلى الأجندة';

  @override
  String get removeFromAgenda => 'إزالة من الأجندة';

  @override
  String get addedSuccess => 'تمت الإضافة بنجاح!';

  @override
  String get removedSuccess => 'تمت الإزالة بنجاح!';

  @override
  String get actionFailed => 'فشلت العملية. حاول مرة أخرى.';

  @override
  String get saveDialogUnavailableRestart =>
      'تعذّر فتح نافذة الحفظ الآن. الرجاء إعادة تشغيل التطبيق ثم المحاولة مرة أخرى.';

  @override
  String get failedToUpdateReminder => 'فشل تحديث التذكير';

  @override
  String savedToFile(String fileName) {
    return 'تم الحفظ في $fileName';
  }

  @override
  String get downloadedEmptyResponse => 'تم تنزيل محتوى فارغ';

  @override
  String get feedbackSubmittedThankYou => 'تم إرسال ملاحظاتك. شكرًا لك!';

  @override
  String get loading => 'جارٍ التحميل…';

  @override
  String get success => 'تم بنجاح';

  @override
  String get mentorshipSessions => 'جلسات الإرشاد';

  @override
  String get mentorshipTimeSlots => 'أوقات جلسات الإرشاد';

  @override
  String get noTimeSlotsAvailable => 'لا توجد أوقات متاحة.';

  @override
  String get errorLoadingTimeSlots => 'خطأ في تحميل الأوقات.';

  @override
  String get register => 'تسجيل';

  @override
  String get unregister => 'إلغاء التسجيل';

  @override
  String get maxCapacityReached => 'تم الوصول إلى الحد الأقصى';

  @override
  String get registered => 'مسجل';

  @override
  String get available => 'متاح';

  @override
  String get registerTitle => 'التسجيل';

  @override
  String get title => 'اللقب';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get bio => 'السيرة الذاتية';

  @override
  String get university => 'الجامعة';

  @override
  String get department => 'القسم';

  @override
  String get major => 'التخصص';

  @override
  String get preferredLanguage => 'اللغة المفضلة';

  @override
  String get profileImage => 'صورة الملف الشخصي';

  @override
  String get registerButton => 'تسجيل';

  @override
  String get verificationCode => 'رمز التحقق';

  @override
  String get verifyButton => 'تحقق';

  @override
  String get gender => 'الجنس';

  @override
  String get genderMale => 'ذكر';

  @override
  String get genderFemale => 'أنثى';

  @override
  String get passwordStrengthWeak => 'ضعيف';

  @override
  String get passwordStrengthModerate => 'متوسط';

  @override
  String get passwordStrengthStrong => 'قوي';

  @override
  String get verifyCodeTitle => 'تأكيد الرمز';

  @override
  String get otpLabel => 'أدخل الرمز';

  @override
  String get otpError => 'يرجى إدخال رمز صالح';

  @override
  String get resendOtp => 'إعادة إرسال الرمز';

  @override
  String get resendOtpIn => 'إعادة إرسال الرمز خلال';

  @override
  String get seconds => 'ثواني';

  @override
  String get verificationTitle => 'التحقق';

  @override
  String get verificationSubtitle =>
      'سنرسل لك رمز تحقق لمرة واحدة\nعبر البريد الإلكتروني لتأكيد حسابك';

  @override
  String get verificationCodeResent => 'تم إعادة إرسال رمز التحقق';

  @override
  String failedToResendCode(String error) {
    return 'فشل إعادة إرسال الرمز: $error';
  }

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب.';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صالح.';

  @override
  String get weakPassword => 'كلمة المرور ضعيفة للغاية.';

  @override
  String get passwordsDontMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get registrationFailed => 'فشل التسجيل. يرجى المحاولة مرة أخرى.';

  @override
  String get settings => 'الإعدادات';

  @override
  String get timeZone => 'المنطقة الزمنية';

  @override
  String get timeZoneSystem => 'النظام';

  @override
  String get timeZoneHelper => 'الافتراضي: المنطقة الزمنية للنظام';

  @override
  String get theme => 'السمة';

  @override
  String get toggleTheme => 'تبديل الوضع الداكن/الفاتح';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get profileDetails => 'تفاصيل الملف الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get failedToLoadNotifications => 'فشل تحميل الإشعارات';

  @override
  String get reminder => 'تذكير';

  @override
  String get noReminderSet => 'لا يوجد تذكير';

  @override
  String get alertMeBefore => 'نبّهني قبل';

  @override
  String get disableReminder => 'إيقاف التذكير';

  @override
  String minutesBefore(int minutes) {
    return 'قبل $minutes دقيقة';
  }

  @override
  String get contactFormTitle => 'اتصل بنا';

  @override
  String get contactFormHeader =>
      'نقدّر ملاحظاتك واستفساراتك. يرجى تعبئة النموذج وسنعاود التواصل معك قريبًا.';

  @override
  String get contactCategory => 'الفئة';

  @override
  String get contactSubject => 'الموضوع';

  @override
  String get contactMessage => 'الرسالة';

  @override
  String get contactSubmit => 'إرسال';

  @override
  String get contactSuccess => 'تم إرسال رسالتك';

  @override
  String get contactError => 'فشل إرسال الرسالة';

  @override
  String get category_GENERAL => 'عام';

  @override
  String get category_TECHNICAL_ISSUE => 'مشكلة تقنية';

  @override
  String get category_SESSION_QUESTION => 'سؤال عن الجلسة';

  @override
  String get category_VENUE_ACCESS => 'الوصول للموقع';

  @override
  String get category_FEEDBACK => 'ملاحظات';

  @override
  String get category_OTHER => 'أخرى';

  @override
  String get type => 'النوع';

  @override
  String get openWebsite => 'افتح الموقع';

  @override
  String get openMap => 'افتح الخريطة';

  @override
  String get tapToOpenMap => 'انقر لفتح الخريطة';

  @override
  String get noVenueInfo => 'لا تتوفر معلومات عن المكان.';

  @override
  String get floorPlans => 'مخططات الطوابق';

  @override
  String get mapOpenFailed => 'تعذر فتح الخريطة.';

  @override
  String get eventPhotos => 'صور الفعالية';

  @override
  String get photosPrevious => 'السابق';

  @override
  String get photosNext => 'التالي';

  @override
  String photosPage(int pageIndex) {
    return 'الصفحة $pageIndex';
  }

  @override
  String get openChat => 'افتح المحادثة';

  @override
  String get joinChat => 'انضم للمحادثة';

  @override
  String get exitGroup => 'الخروج من المجموعة';

  @override
  String get chatJoined => 'تم الانضمام إلى المحادثة';

  @override
  String get forgotPasswordLink => 'هل نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get usernameEmailIdLabel =>
      'اسم المستخدم / البريد الإلكتروني / المعرف';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get forgotPasswordSuccess =>
      'تم إرسال رمز التحقق إلى بريدك الإلكتروني';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get enterVerificationCode => 'أدخل رمز التحقق';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get resetPasswordButton => 'إعادة تعيين كلمة المرور';

  @override
  String get enter6Digits => 'أدخل 6 أرقام';

  @override
  String get min6Chars => '6 أحرف على الأقل';

  @override
  String get pressBackAgainToExit => 'اضغط رجوع مرة أخرى للخروج';

  @override
  String get userIdentifier => 'المعرف';

  @override
  String get notEditable => 'غير قابل للتعديل';

  @override
  String get today => 'اليوم';

  @override
  String get tomorrow => 'غدًا';

  @override
  String minutesShort(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String hoursShort(int hours) {
    return '$hours س';
  }

  @override
  String get registerHeading => 'تسجيل';

  @override
  String get quickPolls => 'استبيانات سريعة';

  @override
  String get noQuickPolls => 'لا توجد استبيانات لهذه الجلسة';

  @override
  String get vote => 'تصويت';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get results => 'النتائج';

  @override
  String pollIndexOfTotal(int index, int total) {
    return 'استبيان $index من $total';
  }

  @override
  String totalVotes(int count) {
    return 'إجمالي الأصوات: $count';
  }

  @override
  String get pollNotOpenYet => 'الاستبيان غير مفتوح بعد';

  @override
  String get pollClosed => 'تم إغلاق الاستبيان';

  @override
  String openUntilTime(String time) {
    return 'مفتوح حتى $time';
  }

  @override
  String get youVoted => 'لقد قمت بالتصويت';

  @override
  String get website => 'الموقع الإلكتروني';

  @override
  String get contactInfo => 'معلومات التواصل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get mobile => 'الجوال';

  @override
  String get phone => 'الهاتف';

  @override
  String get name => 'الاسم';

  @override
  String get position => 'المنصب';

  @override
  String get category => 'الفئة';

  @override
  String get offlineActionUnavailable =>
      'أنت غير متصل بالإنترنت. لا يمكن تنفيذ الإجراء.';

  @override
  String get requiredField => 'هذا الحقل مطلوب.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get edit => 'تعديل';

  @override
  String get unlimitedCapacity => 'سعة غير محدودة';
}
