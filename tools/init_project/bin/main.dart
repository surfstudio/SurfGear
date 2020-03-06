import 'package:init_project/init_project.dart';
import 'package:init_project/services/check_install_git.dart';

void main(List<String> arguments) async {
  await CheckInstallGit().check();
// print(p.stdout);
// print(p.exitCode);
//  await InitProject.instance.execute(arguments);
}
