// inside bin/gen_l10n_tk_runner.dart
import 'dart:io';

Future<void> main(List<String> args) async {
  print('Starting custom localization pipeline...');

  // 1. RUN ORIGINAL flutter gen-l10n (No change needed here)
  print('1. Executing standard Flutter localization generation...');
  final genL10nResult = await Process.run('flutter', [
    'gen-l10n',
    ...args,
  ], runInShell: true);

  if (genL10nResult.exitCode != 0) {
    stderr.writeln('Standard gen-l10n failed: ${genL10nResult.stderr}');
    exit(genL10nResult.exitCode);
  }
  print('Standard gen-l10n completed successfully.');

  // --- 2. RUN POST-PROCESSING SCRIPT (THE FIX) ---
  print('2. Executing custom post-processing script...');

  // 💡 FIX: Use 'flutter pub run' to execute the *compiled* internal script.
  // Package name: flutter_localizations_tk
  // Executable name: post-process-l10n
  final postProcessResult = await Process.run('flutter', [
    'pub',
    'run',
    'flutter_localizations_tk:post_process_l10n',
  ], runInShell: true);

  // Check for success
  if (postProcessResult.exitCode != 0) {
    stderr.writeln('Post-processing failed:');
    // Output both stdout and stderr for debugging
    stderr.writeln('--- STDOUT ---\n${postProcessResult.stdout}');
    stderr.writeln('--- STDERR ---\n${postProcessResult.stderr}');
    exit(postProcessResult.exitCode);
  }
  print('Custom post-processing completed successfully.');
}
