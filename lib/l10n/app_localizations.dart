import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_te.dart';

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
    Locale('en'),
    Locale('hi'),
    Locale('te'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Carefinity'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get diagnostics;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get medicines;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

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

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @loggedInAs.
  ///
  /// In en, this message translates to:
  /// **'Logged in as'**
  String get loggedInAs;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get unknownUser;

  /// No description provided for @familyProfiles.
  ///
  /// In en, this message translates to:
  /// **'Family Profiles'**
  String get familyProfiles;

  /// No description provided for @manageFamilyMembers.
  ///
  /// In en, this message translates to:
  /// **'Manage family members'**
  String get manageFamilyMembers;

  /// No description provided for @appointmentHistory.
  ///
  /// In en, this message translates to:
  /// **'Appointment History'**
  String get appointmentHistory;

  /// No description provided for @diagnosticHistory.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic History'**
  String get diagnosticHistory;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments found.'**
  String get noAppointments;

  /// No description provided for @noDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'No diagnostic bookings found.'**
  String get noDiagnostics;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get hindi;

  /// No description provided for @telugu.
  ///
  /// In en, this message translates to:
  /// **'తెలుగు'**
  String get telugu;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning 👋'**
  String get goodMorning;

  /// No description provided for @welcomeToCarefinity.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Carefinity'**
  String get welcomeToCarefinity;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your health, consult doctors, book diagnostics, and get AI-powered assistance—all in one place.'**
  String get homeDescription;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @topDoctors.
  ///
  /// In en, this message translates to:
  /// **'Top Doctors'**
  String get topDoctors;

  /// No description provided for @upcomingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointment'**
  String get upcomingAppointment;

  /// No description provided for @todaysHealthTip.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Health Tip'**
  String get todaysHealthTip;

  /// No description provided for @consultSpecialists.
  ///
  /// In en, this message translates to:
  /// **'Consult Specialists'**
  String get consultSpecialists;

  /// No description provided for @bookLabTests.
  ///
  /// In en, this message translates to:
  /// **'Book Lab Tests'**
  String get bookLabTests;

  /// No description provided for @healthGuidance.
  ///
  /// In en, this message translates to:
  /// **'Health Guidance'**
  String get healthGuidance;

  /// No description provided for @medicineReminders.
  ///
  /// In en, this message translates to:
  /// **'Medication Reminders'**
  String get medicineReminders;

  /// No description provided for @medicalReports.
  ///
  /// In en, this message translates to:
  /// **'Medical Reports'**
  String get medicalReports;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @medicalCenter.
  ///
  /// In en, this message translates to:
  /// **'Carefinity Medical Center'**
  String get medicalCenter;

  /// No description provided for @cardiologist.
  ///
  /// In en, this message translates to:
  /// **'Cardiologist'**
  String get cardiologist;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields.'**
  String get fillAllFields;

  /// No description provided for @medicationAdded.
  ///
  /// In en, this message translates to:
  /// **'Medication added successfully.'**
  String get medicationAdded;

  /// No description provided for @medicationReminder.
  ///
  /// In en, this message translates to:
  /// **'Medication Reminder'**
  String get medicationReminder;

  /// No description provided for @medicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name'**
  String get medicineName;

  /// No description provided for @dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get dosage;

  /// No description provided for @dosageHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500 mg'**
  String get dosageHint;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @addMedication.
  ///
  /// In en, this message translates to:
  /// **'Add Medication'**
  String get addMedication;

  /// No description provided for @yourMedications.
  ///
  /// In en, this message translates to:
  /// **'Your Medications'**
  String get yourMedications;

  /// No description provided for @noMedications.
  ///
  /// In en, this message translates to:
  /// **'No medications added.'**
  String get noMedications;

  /// No description provided for @aiAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get aiAssistant;

  /// No description provided for @askHealthQuestions.
  ///
  /// In en, this message translates to:
  /// **'Ask health questions'**
  String get askHealthQuestions;

  /// No description provided for @healthLocker.
  ///
  /// In en, this message translates to:
  /// **'Health Locker'**
  String get healthLocker;

  /// No description provided for @bookDoctors.
  ///
  /// In en, this message translates to:
  /// **'Book Doctors'**
  String get bookDoctors;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @manageMembers.
  ///
  /// In en, this message translates to:
  /// **'Manage Members'**
  String get manageMembers;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @selectReport.
  ///
  /// In en, this message translates to:
  /// **'Please select a report.'**
  String get selectReport;

  /// No description provided for @reportUploaded.
  ///
  /// In en, this message translates to:
  /// **'Report uploaded successfully.'**
  String get reportUploaded;

  /// No description provided for @uploadNewReport.
  ///
  /// In en, this message translates to:
  /// **'Upload New Report'**
  String get uploadNewReport;

  /// No description provided for @chooseReport.
  ///
  /// In en, this message translates to:
  /// **'Choose Report'**
  String get chooseReport;

  /// No description provided for @reportName.
  ///
  /// In en, this message translates to:
  /// **'Report Name'**
  String get reportName;

  /// No description provided for @hospitalName.
  ///
  /// In en, this message translates to:
  /// **'Hospital Name'**
  String get hospitalName;

  /// No description provided for @reportType.
  ///
  /// In en, this message translates to:
  /// **'Report Type'**
  String get reportType;

  /// No description provided for @uploadReport.
  ///
  /// In en, this message translates to:
  /// **'Upload Report'**
  String get uploadReport;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @uploadedReports.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Reports'**
  String get uploadedReports;

  /// No description provided for @digitalHealthLocker.
  ///
  /// In en, this message translates to:
  /// **'Digital Health Locker'**
  String get digitalHealthLocker;

  /// No description provided for @digitalHealthLockerDescription.
  ///
  /// In en, this message translates to:
  /// **'Securely upload, organize and access all your medical reports in one place.'**
  String get digitalHealthLockerDescription;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @healthLockerDescription.
  ///
  /// In en, this message translates to:
  /// **'Securely upload, organize and access all your medical reports in one place.'**
  String get healthLockerDescription;

  /// No description provided for @noReports.
  ///
  /// In en, this message translates to:
  /// **'No reports uploaded yet.'**
  String get noReports;

  /// No description provided for @noReportsDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload your first medical report to securely store it here.'**
  String get noReportsDescription;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @analyzeWithAi.
  ///
  /// In en, this message translates to:
  /// **'Analyze with AI'**
  String get analyzeWithAi;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @aiReportAnalyzer.
  ///
  /// In en, this message translates to:
  /// **'AI Report Analyzer'**
  String get aiReportAnalyzer;

  /// No description provided for @pasteMedicalReport.
  ///
  /// In en, this message translates to:
  /// **'Paste Medical Report'**
  String get pasteMedicalReport;

  /// No description provided for @pasteReportText.
  ///
  /// In en, this message translates to:
  /// **'Please paste the report text.'**
  String get pasteReportText;

  /// No description provided for @reportHint.
  ///
  /// In en, this message translates to:
  /// **'Paste your blood report, prescription or medical report here...'**
  String get reportHint;

  /// No description provided for @analyzeReport.
  ///
  /// In en, this message translates to:
  /// **'Analyze Report'**
  String get analyzeReport;

  /// No description provided for @analyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get analyzing;

  /// No description provided for @aiAnalysis.
  ///
  /// In en, this message translates to:
  /// **'AI Analysis'**
  String get aiAnalysis;
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
      <String>['en', 'hi', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
