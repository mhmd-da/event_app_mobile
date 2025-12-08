import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Event App'**
  String get welcomeMessage;

  /// No description provided for @noEventSelected.
  ///
  /// In en, this message translates to:
  /// **'No event selected'**
  String get noEventSelected;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @agenda.
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agenda;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Event App'**
  String get appTitle;

  /// No description provided for @toggleLanguage.
  ///
  /// In en, this message translates to:
  /// **'Toggle language'**
  String get toggleLanguage;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule'**
  String get mySchedule;

  /// No description provided for @errorLoadingSchedule.
  ///
  /// In en, this message translates to:
  /// **'Error loading schedule'**
  String get errorLoadingSchedule;

  /// No description provided for @noSessionsInYourSchedule.
  ///
  /// In en, this message translates to:
  /// **'No sessions in your schedule'**
  String get noSessionsInYourSchedule;

  /// No description provided for @noSessionsFound.
  ///
  /// In en, this message translates to:
  /// **'No sessions found'**
  String get noSessionsFound;

  /// No description provided for @mentors.
  ///
  /// In en, this message translates to:
  /// **'Mentors'**
  String get mentors;

  /// No description provided for @noMentorsFound.
  ///
  /// In en, this message translates to:
  /// **'No mentors found'**
  String get noMentorsFound;

  /// No description provided for @errorLoadingMentors.
  ///
  /// In en, this message translates to:
  /// **'Error loading mentors'**
  String get errorLoadingMentors;

  /// No description provided for @speakers.
  ///
  /// In en, this message translates to:
  /// **'Speakers'**
  String get speakers;

  /// No description provided for @noSpeakersFound.
  ///
  /// In en, this message translates to:
  /// **'No speakers found'**
  String get noSpeakersFound;

  /// No description provided for @errorLoadingSpeakers.
  ///
  /// In en, this message translates to:
  /// **'Error loading speakers'**
  String get errorLoadingSpeakers;

  /// No description provided for @noSessionsLinkedYet.
  ///
  /// In en, this message translates to:
  /// **'No sessions linked yet.'**
  String get noSessionsLinkedYet;

  /// No description provided for @selectEvent.
  ///
  /// In en, this message translates to:
  /// **'Select Event'**
  String get selectEvent;

  /// No description provided for @speakersLabel.
  ///
  /// In en, this message translates to:
  /// **'🎤 Speakers'**
  String get speakersLabel;

  /// No description provided for @mentorsLabel.
  ///
  /// In en, this message translates to:
  /// **'🧠 Mentors'**
  String get mentorsLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, company or position...'**
  String get searchHint;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noSessionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No sessions available'**
  String get noSessionsAvailable;

  /// No description provided for @browseAllSessionsBanner.
  ///
  /// In en, this message translates to:
  /// **'Browse all sessions, speakers, and event schedule'**
  String get browseAllSessionsBanner;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @future.
  ///
  /// In en, this message translates to:
  /// **'Future'**
  String get future;

  /// No description provided for @workshops.
  ///
  /// In en, this message translates to:
  /// **'Workshops'**
  String get workshops;

  /// No description provided for @roundtables.
  ///
  /// In en, this message translates to:
  /// **'Roundtables'**
  String get roundtables;

  /// No description provided for @mentorship.
  ///
  /// In en, this message translates to:
  /// **'Mentorship'**
  String get mentorship;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @sponsors.
  ///
  /// In en, this message translates to:
  /// **'Sponsors'**
  String get sponsors;

  /// No description provided for @partners.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get partners;

  /// No description provided for @exhibitions.
  ///
  /// In en, this message translates to:
  /// **'Exhibitions'**
  String get exhibitions;

  /// No description provided for @eventInfo.
  ///
  /// In en, this message translates to:
  /// **'Event Info'**
  String get eventInfo;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue your event journey.'**
  String get loginToContinue;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email,ID, Phone Number'**
  String get emailLabel;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @dontHaveAccountRegister.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? Register'**
  String get dontHaveAccountRegister;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faqs;

  /// No description provided for @languageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Language updated to {language}'**
  String languageUpdated(Object language);

  /// No description provided for @languageUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update language'**
  String get languageUpdateFailed;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @venue.
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// No description provided for @profile_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profile_name;

  /// No description provided for @profile_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profile_email;

  /// No description provided for @profile_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get profile_phone;

  /// No description provided for @profile_university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get profile_university;

  /// No description provided for @profile_department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get profile_department;

  /// No description provided for @profile_major.
  ///
  /// In en, this message translates to:
  /// **'Major'**
  String get profile_major;

  /// No description provided for @groupByTime.
  ///
  /// In en, this message translates to:
  /// **'Show by Time'**
  String get groupByTime;

  /// No description provided for @groupByTrack.
  ///
  /// In en, this message translates to:
  /// **'Show by Track'**
  String get groupByTrack;

  /// No description provided for @groupByCategory.
  ///
  /// In en, this message translates to:
  /// **'Show by Category'**
  String get groupByCategory;

  /// No description provided for @allTracks.
  ///
  /// In en, this message translates to:
  /// **'All Tracks'**
  String get allTracks;

  /// No description provided for @allCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get allCategories;

  /// No description provided for @sessionSpeakers.
  ///
  /// In en, this message translates to:
  /// **'Session Speakers'**
  String get sessionSpeakers;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered By'**
  String get poweredBy;

  /// No description provided for @addToAgenda.
  ///
  /// In en, this message translates to:
  /// **'Add to Agenda'**
  String get addToAgenda;

  /// No description provided for @removeFromAgenda.
  ///
  /// In en, this message translates to:
  /// **'Remove from Agenda'**
  String get removeFromAgenda;

  /// No description provided for @addedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Added successfully!'**
  String get addedSuccess;

  /// No description provided for @removedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Removed successfully!'**
  String get removedSuccess;

  /// No description provided for @actionFailed.
  ///
  /// In en, this message translates to:
  /// **'Action failed. Please try again.'**
  String get actionFailed;

  /// No description provided for @mentorshipSessions.
  ///
  /// In en, this message translates to:
  /// **'Mentorship Sessions'**
  String get mentorshipSessions;

  /// No description provided for @mentorshipTimeSlots.
  ///
  /// In en, this message translates to:
  /// **'Mentorship Time Slots'**
  String get mentorshipTimeSlots;

  /// No description provided for @noTimeSlotsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No time slots available.'**
  String get noTimeSlotsAvailable;

  /// No description provided for @errorLoadingTimeSlots.
  ///
  /// In en, this message translates to:
  /// **'Error loading time slots.'**
  String get errorLoadingTimeSlots;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @unregister.
  ///
  /// In en, this message translates to:
  /// **'Unregister'**
  String get unregister;

  /// No description provided for @maxCapacityReached.
  ///
  /// In en, this message translates to:
  /// **'Max Capacity Reached'**
  String get maxCapacityReached;

  /// No description provided for @registered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get registered;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @major.
  ///
  /// In en, this message translates to:
  /// **'Major'**
  String get major;

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred Language'**
  String get preferredLanguage;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get profileImage;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @verifyCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCodeTitle;

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get otpLabel;

  /// No description provided for @otpError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid OTP'**
  String get otpError;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendOtpIn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in'**
  String get resendOtpIn;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get weakPassword;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get lastNameHint;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
