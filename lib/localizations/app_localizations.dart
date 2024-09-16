import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
    Locale('es')
  ];

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @accept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get accept;

  /// No description provided for @connection_problems_you_try_again_later.
  ///
  /// In es, this message translates to:
  /// **'Problemas de conexión vuelve a intentarlo más tarde'**
  String get connection_problems_you_try_again_later;

  /// No description provided for @server_sent_a_incorrect_response_try_again.
  ///
  /// In es, this message translates to:
  /// **'El servidor envió una respuesta incorrecta. Intenta más tarde, nuevamente.'**
  String get server_sent_a_incorrect_response_try_again;

  /// No description provided for @need_internet_connection.
  ///
  /// In es, this message translates to:
  /// **'Necesitas conexión a internet'**
  String get need_internet_connection;

  /// No description provided for @connection_established.
  ///
  /// In es, this message translates to:
  /// **'¡Conexión establecida!'**
  String get connection_established;

  /// No description provided for @no_internet_connection.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión a internet'**
  String get no_internet_connection;

  /// No description provided for @error_connection.
  ///
  /// In es, this message translates to:
  /// **'Error de conexión'**
  String get error_connection;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @app_not_found.
  ///
  /// In es, this message translates to:
  /// **'Aplicación no encontrada'**
  String get app_not_found;

  /// No description provided for @app_not_found_descripcion_var.
  ///
  /// In es, this message translates to:
  /// **'Parece que no hay una aplicación en tu dispositivo para abrir archivos tipo ([%]). Te recomendamos instalar una aplicación compatible para poder ver el archivo.'**
  String get app_not_found_descripcion_var;

  /// No description provided for @install.
  ///
  /// In es, this message translates to:
  /// **'Instalar'**
  String get install;

  /// No description provided for @we_are_working_to_app_works_back.
  ///
  /// In es, this message translates to:
  /// **'Estamos trabajando para que la app vuelva a funcionar con normalidad. Intenta más tarde.'**
  String get we_are_working_to_app_works_back;

  /// No description provided for @we_sorry.
  ///
  /// In es, this message translates to:
  /// **'¡Lo sentimos!'**
  String get we_sorry;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando'**
  String get loading;

  /// No description provided for @today.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get today;

  /// No description provided for @yerterday.
  ///
  /// In es, this message translates to:
  /// **'Ayer'**
  String get yerterday;

  /// No description provided for @enter_valid_link.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un enlace válido'**
  String get enter_valid_link;

  /// No description provided for @timezone.
  ///
  /// In es, this message translates to:
  /// **'Zona horaria'**
  String get timezone;

  /// No description provided for @select.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar'**
  String get select;

  /// No description provided for @select_all.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar todos'**
  String get select_all;

  /// No description provided for @unselect_all.
  ///
  /// In es, this message translates to:
  /// **'Deseleccionar todos'**
  String get unselect_all;

  /// No description provided for @update.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get update;

  /// No description provided for @we_sorry_no_access_to_database.
  ///
  /// In es, this message translates to:
  /// **'¡Lo sentimos! Sin acceso a la base de datos'**
  String get we_sorry_no_access_to_database;

  /// No description provided for @server_no_response.
  ///
  /// In es, this message translates to:
  /// **'El servidor no responde'**
  String get server_no_response;

  /// No description provided for @error_server_response.
  ///
  /// In es, this message translates to:
  /// **'Error en respuesta del servidor'**
  String get error_server_response;

  /// No description provided for @in_this_moment_you_can_access_to_database_try_later.
  ///
  /// In es, this message translates to:
  /// **'En este momento, no se puede acceder a la base de datos. Intenta más tarde, nuevamente.'**
  String get in_this_moment_you_can_access_to_database_try_later;

  /// No description provided for @in_this_moment_app_can_not_connect_with_server_try_later.
  ///
  /// In es, this message translates to:
  /// **'En este momento, la app no se puede conectar con el servidor. Intenta más tarde, nuevamente.'**
  String get in_this_moment_app_can_not_connect_with_server_try_later;

  /// No description provided for @please_check_your_connection_network_try_with_other_network.
  ///
  /// In es, this message translates to:
  /// **'Por favor, comprueba tu conexión a la red. O prueba con otra red para conectarte.'**
  String get please_check_your_connection_network_try_with_other_network;

  /// No description provided for @no_records.
  ///
  /// In es, this message translates to:
  /// **'Sin registros'**
  String get no_records;

  /// No description provided for @no_records_found.
  ///
  /// In es, this message translates to:
  /// **'No se han encontrado registros'**
  String get no_records_found;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
