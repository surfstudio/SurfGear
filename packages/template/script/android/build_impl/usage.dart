import 'dart:io';

void main() {
  exitCode = 0;
  Process.run('echo', ['usage: build [[-qa] | [-release]] | [-h]]'])
      .then((result) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  });
}
