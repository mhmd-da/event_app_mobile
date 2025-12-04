// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get welcomeMessage => 'Welcome to the Event App';

  @override
  String get noEventSelected => 'No event selected';

  @override
  String get home => 'Home';

  @override
  String get agenda => 'Agenda';

  @override
  String get profile => 'Profile';

  @override
  String get sessions => 'Sessions';

  @override
  String get appTitle => 'Event App';

  @override
  String get toggleLanguage => 'Toggle language';

  @override
  String get mySchedule => 'My Schedule';

  @override
  String get errorLoadingSchedule => 'Error loading schedule';

  @override
  String get noSessionsInYourSchedule => 'No sessions in your schedule';

  @override
  String get noSessionsFound => 'No sessions found';

  @override
  String get mentors => 'Mentors';

  @override
  String get noMentorsFound => 'No mentors found';

  @override
  String get errorLoadingMentors => 'Error loading mentors';

  @override
  String get speakers => 'Speakers';

  @override
  String get noSpeakersFound => 'No speakers found';

  @override
  String get errorLoadingSpeakers => 'Error loading speakers';

  @override
  String get noSessionsLinkedYet => 'No sessions linked yet.';

  @override
  String get selectEvent => 'Select Event';

  @override
  String get speakersLabel => '🎤 Speakers';

  @override
  String get mentorsLabel => '🧠 Mentors';

  @override
  String get searchHint => 'Search by name, company or position...';

  @override
  String get about => 'About';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noSessionsAvailable => 'No sessions available';

  @override
  String get browseAllSessionsBanner =>
      'Browse all sessions, speakers, and event schedule';

  @override
  String get past => 'Past';

  @override
  String get ongoing => 'Ongoing';

  @override
  String get future => 'Future';

  @override
  String get workshops => 'Workshops';

  @override
  String get roundtables => 'Roundtables';

  @override
  String get mentorship => 'Mentorship';

  @override
  String get resources => 'Resources';

  @override
  String get notifications => 'Notifications';

  @override
  String get sponsors => 'Sponsors';

  @override
  String get partners => 'Partners';

  @override
  String get exhibitions => 'Exhibitions';

  @override
  String get eventInfo => 'Event Info';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get loginToContinue => 'Login to continue your event journey.';

  @override
  String get emailLabel => 'Email,ID, Phone Number';

  @override
  String get password => 'Password';

  @override
  String get continueButton => 'Continue';

  @override
  String get dontHaveAccountRegister => 'Don’t have an account? Register';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get faqs => 'FAQs';

  @override
  String languageUpdated(Object language) {
    return 'Language updated to $language';
  }

  @override
  String get languageUpdateFailed => 'Failed to update language';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get venue => 'Venue';
}
