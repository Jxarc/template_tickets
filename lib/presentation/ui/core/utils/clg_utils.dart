import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:template/presentation/ui/ui.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show ClientException;
import 'package:image/image.dart' hide Color;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:url_launcher/url_launcher.dart';

final _colors = [
  Colors.blue,
  Colors.green,
  Colors.pinkAccent,
  Colors.amber,
  Colors.greenAccent,
  Colors.orange,
  Colors.red,
  Colors.purple,
];

class CLGUtils {
  static RegExp get interpolationRegex => RegExp(r'(\{%\})|(\[%\])');

  static String getAliasFromName(String name, [int length = 2]) {
    final parts = name.split(' ');
    final letters = parts.length == 1 ? parts[0] : parts.where((e) => e.isNotEmpty).map((e) => e[0]).join('');
    final end = letters.length > length ? length : letters.length;
    return letters.substring(0, end).toUpperCase();
  }

  static void setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
  }

  static Color randomColor(int? index) {
    if (index != null && index < _colors.length) {
      return _colors[index];
    } else {
      return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    }
  }

  static String getDateFromFormat(String format, int seconds, [Locale? locale, bool isUtc = true]) {
    final formatter = DateFormat(format, locale?.languageCode);
    final date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: isUtc);
    return formatter.format(date);
  }

  static Future<bool> openUrl(
    BuildContext context,
    String url, {
    CLGLaunchMode mode = CLGLaunchMode.platformDefault,
    bool showMessage = true,
  }) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: mode.mode);
        return true;
      } else if (context.mounted && showMessage) {
        context.showCustomToast(context.strings.enter_valid_link);
      }
    } catch (e) {
      debugPrint('AppUtils:openUrl - Error $e');
    }
    return false;
  }

  static String getDateFormatted(
    BuildContext context, {
    required DateTime date,
    required Locale? locale,
    bool addHour = true,
    bool addDate = false,
    bool isUtc = true,
    bool justHour = false,
  }) {
    final currentDate = DateTime.now();
    final startWeekDate = currentDate.subtract(Duration(days: currentDate.weekday));

    const formatHour = 'hh:mm';
    final formatterHour = DateFormat(formatHour, locale?.languageCode);
    final labelJourney = DateFormat('a', locale?.languageCode).format(date);
    final labelHour = '${formatterHour.format(date)} ${labelJourney.replaceAll(RegExp(r'\.?\s?'), '').toUpperCase()}';

    if (justHour) return labelHour;

    if (date.compareTo(startWeekDate) == 1) {
      const formatWeek = 'EEEE';
      final formatterWeek = DateFormat(formatWeek, locale?.languageCode);
      final labelWeek = formatterWeek.format(date).toProperCase();

      if (date.day == currentDate.day) {
        final date = addDate ? context.strings.today : '';
        final hour = addHour || date.isEmpty ? labelHour : '';
        final divider = date.isNotEmpty && hour.isNotEmpty ? ', ' : '';
        return '$date$divider$hour';
      } else if (date.day == currentDate.day - 1) {
        final date = context.strings.yerterday;
        final hour = addHour ? labelHour : '';
        final divider = date.isNotEmpty && hour.isNotEmpty ? ', ' : '';
        return '$date$divider$hour';
      }

      if (!addHour) return labelWeek;
      return '$labelWeek, $labelHour';
    }

    const format = 'dd MMM';
    final formatter = DateFormat(format, locale?.languageCode);
    final labelDate = formatter.format(date).replaceAll('.', '').toProperCase();

    if (currentDate.year == date.year) {
      if (!addHour) return labelDate;
      return '$labelDate, $labelHour';
    }

    if (!addHour) return '$labelDate, ${date.year}';
    return '$labelDate, ${date.year} $labelHour';
  }

  static Future<String?> getTemporalyPath() async {
    final directory = await path_provider.getTemporaryDirectory();
    final pathDirectory = directory.path;

    return pathDirectory;
  }

  static Future<String?> generateIdFromName(String name) async {
    final fileId = md5.convert(utf8.encode(name)).toString();
    return fileId;
  }

  static Future showLoading(BuildContext context, [String? message]) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CLGProgressDialog(message ?? context.strings.loading),
    );
  }

  static Future<String?> resizeImage(String pathSource, String target, {int? width, int? height, int quality = 100}) async {
    try {
      final originalFile = decodeImage(File(pathSource).readAsBytesSync())!;
      final thumbnail = copyResize(originalFile, width: width, height: height);
      File(target).writeAsBytesSync(encodeJpg(thumbnail, quality: quality));
      return target;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<CLGSource?> takePhoto(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) return CLGSource.file(photo.path);
    } on PlatformException catch (e) {
      debugPrint('CLGUtils:takePhoto - Error ${e.message}');
    } catch (e) {
      debugPrint('CLGUtils:takePhoto - Error $e');
    }

    return null;
  }

  static Future<List<CLGSource>> pickFiles(
    BuildContext context, {
    List<CLGFileType> types = const [],
    List<String> extensions = const [],
    bool multiple = false,
    Function? onError,
  }) async {
    try {
      final exts = types.fold<List<String>>([], (current, val) {
        current.addAll(val.ext);
        return current;
      });
      exts.addAll(extensions);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: exts.isEmpty ? FileType.any : FileType.custom,
        allowMultiple: multiple,
        allowedExtensions: exts,
      );

      if (result != null) {
        if (onError != null && result.files.isEmpty) {
          onError();
        }
        return result.files.map((e) => CLGSource.file(e.path ?? '')).where((e) => e.path.isNotEmpty).toList();
      }
    } on PlatformException catch (e) {
      debugPrint('CLGUtils:pickFiles - Error ${e.message}');
    } catch (e) {
      debugPrint('CLGUtils:pickFiles - Error $e');
    }

    return [];
  }

  static Future<List<CLGSource>> pickMedia(
    BuildContext context, {
    bool multiple = false,
    bool imagesOnly = false,
    bool videosOnly = false,
  }) async {
    try {
      FilePickerResult? result;
      if (imagesOnly && !videosOnly) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: multiple,
        );
      }
      if (videosOnly && !imagesOnly) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.video,
          allowMultiple: multiple,
        );
      }

      if (!videosOnly && !imagesOnly) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.media,
          allowMultiple: multiple,
        );
      }

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((e) => CLGSource.file(e.path ?? '')).where((e) => e.path.isNotEmpty).toList();
      }
    } on PlatformException catch (e) {
      debugPrint('CLGUtils:pickFiles - Error ${e.message}');
    } catch (e) {
      debugPrint('CLGUtils:pickFiles - Error $e');
    }

    return [];
  }

  static bool isMultimediaFileVideo(String nameFile) {
    return nameFile.contains('.mov') || nameFile.contains('.mp4') || nameFile.contains('.m4v');
  }

  static bool isFatalError(dynamic error) {
    return switch (error) {
      (HttpException _) => false,
      (SocketException _) => false,
      (ClientException _) => false,
      (HandshakeException _) => false,
      _ => true,
    };
  }

  static Future<bool> openFile(BuildContext context, String? path) async {
    if (path == null || path.isEmpty) return false;
    final result = await OpenFilex.open(path);
    if (Platform.isAndroid && result.type == ResultType.noAppToOpen) {
      if (context.mounted) showRecommendAppFileDialog(context, path);
      return false;
    }
    return true;
  }

  static Future showRecommendAppFileDialog(BuildContext context, String? path) async {
    final ext = path?.split('.').last ?? '';
    final fileType = CLGFileType.fromExtension(ext);
    return showDialog(
      context: context,
      builder: (context) => CLGConfirmDialog(
        type: CLGMessageType.warning,
        title: context.strings.app_not_found,
        description: context.strings.app_not_found_descripcion_var.interpolation([ext]),
        textPositiveButton: context.strings.install,
        textNegativeButton: context.strings.cancel,
        onNegativeButton: () {
          Navigator.pop(context);
        },
        onPositiveButton: () {
          openAppRequired(context, fileType);
          Navigator.pop(context);
        },
      ),
    );
  }

  static Future openAppRequired(BuildContext context, CLGFileType fileType) async {
    openAppUrl(String id) => CLGUtils.openUrl(context, CLGConfig.playstoreAppUrl.replaceAll(':idapp', id), mode: CLGLaunchMode.externalApplication);

    switch (fileType) {
      case CLGFileType.excel:
        openAppUrl(CLGConfig.playstoreSheetId);
        break;
      case CLGFileType.word:
        openAppUrl(CLGConfig.playstoreDocsId);
        break;
      case CLGFileType.powerPoint:
        openAppUrl(CLGConfig.playstoreSlidesId);
        break;
      case CLGFileType.pdf:
        openAppUrl(CLGConfig.playstorePdfId);
        break;
      default:
        CLGUtils.openUrl(context, CLGConfig.playstoreUrl, mode: CLGLaunchMode.externalApplication);
        break;
    }
  }

  static String getEmojiFlag(String countryCode) {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji = String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return emoji;
  }

  static Color getEnviromentColor(BuildContext context) {
    final enviroment = CLGConfig.environment;
    if (enviroment == CLGEnvironment.production.name) return context.theme.white;
    if (enviroment == CLGEnvironment.staging.name) return context.theme.tertiary;
    if (enviroment == CLGEnvironment.beta.name) return context.theme.secondary;
    if (enviroment == CLGEnvironment.development.name) return context.theme.primary;

    return context.theme.magenta;
  }

  static Future showNetworErrorDialog(
    BuildContext context, {
    Function? onClick,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CLGConfirmDialog(
        type: CLGMessageType.warning,
        title: context.strings.error_connection,
        description: context.strings.connection_problems_you_try_again_later,
        onPositiveButton: onClick,
        textPositiveButton: context.strings.retry,
      ),
    );
  }

  static Future showGenericErrorDialog(
    BuildContext context, {
    Function? onClick,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CLGConfirmDialog(
        type: CLGMessageType.error,
        title: context.strings.we_sorry,
        description: context.strings.we_are_working_to_app_works_back,
        onPositiveButton: onClick,
        textPositiveButton: context.strings.retry,
      ),
    );
  }

  static void checkNetworkConnection() {
    if (!CLGNetworkConnection().isConnected) {
      throw CLGError.type(CLGErrorType.networkConnection);
    }
  }

  static Exception parseError(dynamic error) {
    if (error is DioException) {
      if (!CLGNetworkConnection().isConnected) {
        return CLGError.type(CLGErrorType.networkConnection);
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.connectionError:
          return CLGError.type(CLGErrorType.serverConnection);
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.cancel:
          return CLGError.type(CLGErrorType.serverConnection);
        case DioExceptionType.badResponse:
          String codeError = '';
          var data = error.response?.data;
          if (data is Map) {
            if (data['error_description'] != null) {
              codeError = data['error_description'];
            } else if (data['message'] != null) {
              codeError = data['message'];
            } else if (data['error'] != null) {
              return CLGError.fromJson(data['error']);
            }
          }
          return CLGError.type(CLGErrorType.serverConnection, codeError, error.toString());

        default:
          return CLGError.type(CLGErrorType.serverConnection, error.toString());
      }
    } else if (error is! Exception) {
      return Exception(error.toString());
    }

    return error;
  }

  static Color? getColorFromHtml(String colorHtml) {
    var colorDart = colorHtml;
    if (colorDart.isNotEmpty) {
      if (colorHtml.contains('#')) {
        colorDart = colorDart.replaceAll('#', '');

        final prefix = colorDart.length == 8 ? colorDart.substring(6) : 'ff';
        final color = colorDart.length == 8 ? colorDart.substring(0, 6) : colorDart;
        colorDart = "$prefix$color";

        return Color(int.parse("0x${colorDart.isNotEmpty ? colorDart : "ff000000"}"));
      } else {
        final regex = RegExp(r'rgb\((\d+),\s*(\d+),\s*(\d+).');
        final result = regex.firstMatch(colorHtml);

        if (result != null) {
          final a = int.parse(result.group(1) ?? '0');
          final r = int.parse(result.group(2) ?? '0');
          final g = int.parse(result.group(3) ?? '0');

          return Color.fromRGBO(a, r, g, 1);
        }
      }
    }

    return null;
  }

  static String encryptTiny(String key, int id) {
    String set = key;
    String hexn = '';
    id = (id.abs()).floor();
    int radix = set.length;
    while (true) {
      int r = id % radix;
      hexn = set[r] + hexn;
      id = ((id - r) / radix).floor();
      if (id == 0) {
        break;
      }
    }
    return hexn;
  }

  static int decryptTiny(String key, String value) {
    String set = key;
    String strValue = value.toString();
    int radix = set.length;
    int strlen = strValue.length;
    int id = 0;
    for (int i = 0; i < strlen; i++) {
      id += set.indexOf(strValue[i]) * math.pow(radix, (strlen - i - 1)).toInt();
    }
    return id;
  }

  static Future lockPortrait() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static Future lockLandscape() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Future enableOrientation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Map<String, Object> filterOutNulls(Map<String, Object?> parameters) {
    final Map<String, Object> filtered = <String, Object>{};
    parameters.forEach((String key, Object? value) {
      if (value != null) {
        filtered[key] = value;
      }
    });
    return filtered;
  }

  static Future<String?> getAmplifyDownloadUrl(
    String pathStorage, {
    Duration? expiresIn,
  }) async {
    try {
      if (pathStorage.isEmpty) return null;

      final result = await Amplify.Storage.getUrl(
        path: StoragePath.fromString(pathStorage),
        options: StorageGetUrlOptions(
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: expiresIn ?? const Duration(days: 1),
          ),
        ),
      ).result;
      debugPrint('AmplifyService:getDownloadUrl - Got URL: ${result.url.toString()}');
      return result.url.toString();
    } on StorageException catch (e) {
      debugPrint('AmplifyService:getDownloadUrl - Error getting download URL: $e');
    } catch (e) {
      debugPrint('AmplifyService:getDownloadUrl - $e');
    }
    return null;
  }

  static Future<String> createTemporaryPathFromFileName(String fileName) async {
    final directory = await path_provider.getTemporaryDirectory();
    final fileId = md5.convert(utf8.encode(fileName)).toString();
    final ext = fileName.split('.').last;

    return '${directory.path}/temp_colegium_$fileId.$ext';
  }

  static String generateAvatar(String fullName) {
    const url = 'https://ui-avatars.com/api/?';
    final params = {
      'name': fullName,
      'background': '237CE1',
      'color': 'FFFFFF',
      'font-size': '0.5',
      'bold': true,
    };
    return '$url${params.keys.map((e) => '$e=${params[e]}').join('&')}';
  }

  static Future<String> getDeviceInfo() async {
    var deviceInfo = '';

    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      deviceInfo = '${androidInfo.model}~Android-${androidInfo.version.release}';
    } catch (exception) {
      print(exception);
    }
    try {
      final iOSInfo = await DeviceInfoPlugin().iosInfo;
      deviceInfo = '${iOSInfo.utsname.machine}~iOS-${iOSInfo.systemVersion}';
    } catch (exception) {
      print(exception);
    }

    if (deviceInfo.isNotEmpty) {
      final packageInfo = await PackageInfo.fromPlatform();
      deviceInfo += '~${packageInfo.appName}~${packageInfo.version}';
    }
    return deviceInfo;
  }

  static DateTime applyTimeZone(DateTime date, Duration? timeZoneOffset) {
    if (timeZoneOffset != null) {
      if (timeZoneOffset < Duration.zero) {
        date = date.gmt0.subtract(timeZoneOffset.abs());
      } else {
        date = date.gmt0.add(timeZoneOffset.abs());
      }
    }
    return date;
  }

  static int applyTimeZoneToSeconds(int seconds, Duration? timeZoneOffset) {
    return applyTimeZone(DateTime.fromMillisecondsSinceEpoch(seconds * 1000), timeZoneOffset).secondsSinceEpoch;
  }

  static String getHour12HFormat(String hour) {
    final data = hour.split(':');
    final dateNow = DateTime.now();
    final hours = int.tryParse(data[0]) ?? 0;
    final minutes = int.tryParse(data[1]) ?? 0;
    final date = DateTime(dateNow.year, dateNow.month, dateNow.day, hours, minutes);
    final formatter = DateFormat('hh:mm a');
    return formatter.format(date);
  }

  static String formatNumber({Locale? locale, num value = 0}) {
    return NumberFormat.decimalPatternDigits(
      decimalDigits: 2,
      locale: locale?.languageCode,
    ).format(value);
  }
}
