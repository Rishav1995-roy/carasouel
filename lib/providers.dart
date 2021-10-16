import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProviderLogger extends ProviderObserver {
  static final Logger logger = Logger();
}

final loggerProvider = Provider<Logger>((ref) => Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    printEmojis: true,
  ),
));

