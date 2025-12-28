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
  /// **'Welcome to KSU Tamkeen X 2026'**
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
  /// **'KSU Tamkeen X 2026'**
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

  /// No description provided for @loginHeading.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get loginHeading;

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
  String languageUpdated(String language);

  /// No description provided for @languageUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update language'**
  String get languageUpdateFailed;

  /// No description provided for @sessionChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Session Chat'**
  String get sessionChatTitle;

  /// No description provided for @typeMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeMessageHint;

  /// No description provided for @sendLabel.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendLabel;

  /// No description provided for @youLabel.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get youLabel;

  /// No description provided for @myQrTitle.
  ///
  /// In en, this message translates to:
  /// **'My QR'**
  String get myQrTitle;

  /// No description provided for @myQrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show this code to staff for check-in.'**
  String get myQrSubtitle;

  /// No description provided for @qrNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'QR code not available.'**
  String get qrNotAvailable;

  /// No description provided for @qrNotAvailableHint.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again while online.'**
  String get qrNotAvailableHint;

  /// No description provided for @qrTitle.
  ///
  /// In en, this message translates to:
  /// **'QR'**
  String get qrTitle;

  /// No description provided for @scanQrTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQrTitle;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing…'**
  String get processing;

  /// No description provided for @checkInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Checked in'**
  String get checkInSuccess;

  /// No description provided for @checkInFailed.
  ///
  /// In en, this message translates to:
  /// **'Check-in failed'**
  String get checkInFailed;

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

  /// No description provided for @venueMap.
  ///
  /// In en, this message translates to:
  /// **'Venue Map'**
  String get venueMap;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @aboutEvent.
  ///
  /// In en, this message translates to:
  /// **'About Event'**
  String get aboutEvent;

  /// No description provided for @venueAndInfo.
  ///
  /// In en, this message translates to:
  /// **'Venue & Info'**
  String get venueAndInfo;

  /// No description provided for @venueMapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View all halls and rooms'**
  String get venueMapSubtitle;

  /// No description provided for @faqsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Common questions'**
  String get faqsSubtitle;

  /// No description provided for @contactUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reach the organizers'**
  String get contactUsSubtitle;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description available.'**
  String get noDescriptionAvailable;

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

  /// No description provided for @materials.
  ///
  /// In en, this message translates to:
  /// **'Materials'**
  String get materials;

  /// No description provided for @giveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give Feedback'**
  String get giveFeedback;

  /// No description provided for @sessionFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Session Feedback'**
  String get sessionFeedbackTitle;

  /// No description provided for @feedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Write your feedback (optional)'**
  String get feedbackHint;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @pleaseSelectRating.
  ///
  /// In en, this message translates to:
  /// **'Please select a rating'**
  String get pleaseSelectRating;

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

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get passwordStrengthModerate;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

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

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationTitle;

  /// No description provided for @verificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will send you a One Time Password\nvia email to verify your account'**
  String get verificationSubtitle;

  /// No description provided for @verificationCodeResent.
  ///
  /// In en, this message translates to:
  /// **'Verification code resent'**
  String get verificationCodeResent;

  /// No description provided for @failedToResendCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend code: {error}'**
  String failedToResendCode(String error);

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

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match.'**
  String get passwordsDontMatch;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle dark/light'**
  String get toggleTheme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile details'**
  String get profileDetails;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @failedToLoadNotifications.
  ///
  /// In en, this message translates to:
  /// **'Failed to load notifications'**
  String get failedToLoadNotifications;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// No description provided for @noReminderSet.
  ///
  /// In en, this message translates to:
  /// **'No reminder set'**
  String get noReminderSet;

  /// No description provided for @alertMeBefore.
  ///
  /// In en, this message translates to:
  /// **'Alert me before'**
  String get alertMeBefore;

  /// No description provided for @disableReminder.
  ///
  /// In en, this message translates to:
  /// **'Disable reminder'**
  String get disableReminder;

  /// No description provided for @minutesBefore.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes before'**
  String minutesBefore(int minutes);

  /// No description provided for @contactFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactFormTitle;

  /// No description provided for @contactFormHeader.
  ///
  /// In en, this message translates to:
  /// **'We value your feedback and inquiries. Please fill the form and we will get back to you shortly.'**
  String get contactFormHeader;

  /// No description provided for @contactCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get contactCategory;

  /// No description provided for @contactSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get contactSubject;

  /// No description provided for @contactMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactMessage;

  /// No description provided for @contactSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get contactSubmit;

  /// No description provided for @contactSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your message has been sent'**
  String get contactSuccess;

  /// No description provided for @contactError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message'**
  String get contactError;

  /// No description provided for @category_GENERAL.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get category_GENERAL;

  /// No description provided for @category_TECHNICAL_ISSUE.
  ///
  /// In en, this message translates to:
  /// **'Technical Issue'**
  String get category_TECHNICAL_ISSUE;

  /// No description provided for @category_SESSION_QUESTION.
  ///
  /// In en, this message translates to:
  /// **'Session Question'**
  String get category_SESSION_QUESTION;

  /// No description provided for @category_VENUE_ACCESS.
  ///
  /// In en, this message translates to:
  /// **'Venue Access'**
  String get category_VENUE_ACCESS;

  /// No description provided for @category_FEEDBACK.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get category_FEEDBACK;

  /// No description provided for @category_OTHER.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_OTHER;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @openWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open Website'**
  String get openWebsite;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get openMap;

  /// No description provided for @noVenueInfo.
  ///
  /// In en, this message translates to:
  /// **'No venue information available.'**
  String get noVenueInfo;

  /// No description provided for @floorPlans.
  ///
  /// In en, this message translates to:
  /// **'Floor Plans'**
  String get floorPlans;

  /// No description provided for @mapOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open map.'**
  String get mapOpenFailed;

  /// No description provided for @eventPhotos.
  ///
  /// In en, this message translates to:
  /// **'Event Photos'**
  String get eventPhotos;

  /// No description provided for @photosPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get photosPrevious;

  /// No description provided for @photosNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get photosNext;

  /// No description provided for @photosPage.
  ///
  /// In en, this message translates to:
  /// **'Page {pageIndex}'**
  String photosPage(int pageIndex);

  /// No description provided for @openChat.
  ///
  /// In en, this message translates to:
  /// **'Open Chat'**
  String get openChat;

  /// No description provided for @joinChat.
  ///
  /// In en, this message translates to:
  /// **'Join Chat'**
  String get joinChat;

  /// No description provided for @exitGroup.
  ///
  /// In en, this message translates to:
  /// **'Exit Group'**
  String get exitGroup;

  /// No description provided for @chatJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined chat'**
  String get chatJoined;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @usernameEmailIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Username / Email / ID'**
  String get usernameEmailIdLabel;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @forgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email'**
  String get forgotPasswordSuccess;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get enterVerificationCode;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @enter6Digits.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 digits'**
  String get enter6Digits;

  /// No description provided for @min6Chars.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get min6Chars;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressBackAgainToExit;

  /// No description provided for @userIdentifier.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get userIdentifier;

  /// No description provided for @notEditable.
  ///
  /// In en, this message translates to:
  /// **'Not editable'**
  String get notEditable;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @hoursShort.
  ///
  /// In en, this message translates to:
  /// **'{hours} hr'**
  String hoursShort(int hours);

  /// Heading text shown on the registration page
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get registerHeading;

  /// No description provided for @quickPolls.
  ///
  /// In en, this message translates to:
  /// **'Quick Polls'**
  String get quickPolls;

  /// No description provided for @noQuickPolls.
  ///
  /// In en, this message translates to:
  /// **'No quick polls for this session'**
  String get noQuickPolls;

  /// No description provided for @vote.
  ///
  /// In en, this message translates to:
  /// **'Vote'**
  String get vote;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @pollIndexOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Poll {index} of {total}'**
  String pollIndexOfTotal(int index, int total);

  /// No description provided for @totalVotes.
  ///
  /// In en, this message translates to:
  /// **'Total votes: {count}'**
  String totalVotes(int count);

  /// No description provided for @pollNotOpenYet.
  ///
  /// In en, this message translates to:
  /// **'Poll not open yet'**
  String get pollNotOpenYet;

  /// No description provided for @pollClosed.
  ///
  /// In en, this message translates to:
  /// **'Poll closed'**
  String get pollClosed;

  /// No description provided for @openUntilTime.
  ///
  /// In en, this message translates to:
  /// **'Open until {time}'**
  String openUntilTime(String time);

  /// No description provided for @youVoted.
  ///
  /// In en, this message translates to:
  /// **'You voted'**
  String get youVoted;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @contactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact Info'**
  String get contactInfo;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @offlineActionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Action unavailable.'**
  String get offlineActionUnavailable;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get requiredField;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @unlimitedCapacity.
  ///
  /// In en, this message translates to:
  /// **'Unlimited capacity'**
  String get unlimitedCapacity;
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
