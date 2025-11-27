import 'dart:io';

void main() {
  const filePath = 'lib/l10n/app_localizations.dart'; // Target file path
  const originalImport =
      'package:flutter_localizations/flutter_localizations.dart';
  const customImport =
      'package:flutter_localizations_tk/flutter_localizations.dart';

  final file = File(filePath);

  if (!file.existsSync()) {
    stderr.writeln(
      'Error: Generated file not found at $filePath. Did gen-l10n run successfully?',
    );
    exit(1);
  }

  try {
    String content = file.readAsStringSync();

    // Perform the string replacement
    String newContent = content.replaceAll(originalImport, customImport);

    // Overwrite the original file with the new content
    file.writeAsStringSync(newContent);

    print('Successfully updated import path in $filePath:');
    print('  Replaced "$originalImport" with "$customImport"');
  } catch (e) {
    stderr.writeln('Error processing file $filePath: $e');
    exit(1);
  }
}
