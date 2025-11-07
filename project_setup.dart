import 'dart:developer';
import 'dart:io';
import 'dart:convert';

void main() async {
  final config = jsonDecode(await File('setup.json').readAsString());

  for (final pkg in List<String>.from(config["packages"])) {
    final args = ["pub", "add"];

    if (pkg.startsWith("--dev")) {
      args.add("--dev");
      args.add(pkg.replaceFirst("--dev ", ""));
    } else {
      args.add(pkg);
    }

    print("📦 Installing $pkg...");
    final result = await Process.run("flutter", args, runInShell: true);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }

  await Process.run("flutter", ["pub", "get"], runInShell: true);
  log("✅ All packages installed successfully!");
}
