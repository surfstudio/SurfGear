import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';

/// Creator for Mwwm Widget
export class MwwmWidgetCreator {
    async create(context: vscode.ExtensionContext, args: any[]) {
        const pathFolderToCreateFiles = getPathFolderToCreateFiles(args);
        if (pathFolderToCreateFiles === "") {
            return;
        }

        const widgetName = await getWidgetName();
        if (!checkName(widgetName)) { return; }

        const filePrefix = getFilePrefix(widgetName);
        const filesFolderPath = createFolder(pathFolderToCreateFiles, filePrefix);

        const sourceCodeFolderPath = getSourceCodeFolderPath(context, 'mwwm_widget');
        createTemplate(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix, false);
        createWm(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix);
        createDi(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix);
    }
}

/// Creator for Surf-Mwwm Widget
export class SurfMwwmWidgetCreator {
    async create(context: vscode.ExtensionContext, args: any[]) {
        const pathFolderToCreateFiles = getPathFolderToCreateFiles(args);
        if (pathFolderToCreateFiles === "") { return; }

        const widgetName = await getWidgetName();
        if (!checkName(widgetName)) { return; }

        const filePrefix = getFilePrefix(widgetName);
        const filesFolderPath = createFolder(pathFolderToCreateFiles, filePrefix);

        const sourceCodeFolderPath = getSourceCodeFolderPath(context, 'surf_mwwm_widget');
        createTemplate(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix, false);
        createWm(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix);
        createDi(sourceCodeFolderPath, widgetName, filesFolderPath, filePrefix);
    }
}

/// Creator for Surf-Mwwm Screen
export class SurfMwwmScreenCreator {
    async create(context: vscode.ExtensionContext, args: any[]) {
        const pathFolderToCreateFiles = getPathFolderToCreateFiles(args);
        if (pathFolderToCreateFiles === "") { return; }

        const screenName = await this.getScreenName();
        if (!checkName(screenName)) { return; }

        const filePrefix = getFilePrefix(screenName);
        const filesFolderPath = createFolder(pathFolderToCreateFiles, filePrefix);

        const sourceCodeFolderPath = getSourceCodeFolderPath(context, 'surf_mwwm_screen');
        createTemplate(sourceCodeFolderPath, screenName, filesFolderPath, filePrefix, true);
        createWm(sourceCodeFolderPath, screenName, filesFolderPath, filePrefix);
        createDi(sourceCodeFolderPath, screenName, filesFolderPath, filePrefix);
        createRoute(sourceCodeFolderPath, screenName, filesFolderPath, filePrefix);
    }

    // Return screen name
    private async getScreenName(): Promise<string> {
        let options: vscode.InputBoxOptions = {
            prompt: "Screen name: ",
            placeHolder: "Input screen name (PascalCase)"
        };
        let widgetName: string = await vscode.window.showInputBox(options).then(value => {
            if (!value) { return ''; }
            return value;
        });
        return widgetName;
    }
}


// Return path to create widget/screen
function getPathFolderToCreateFiles(args: any[]): string {
    const fileInput = args[0].path;

    const inputStats = fs.statSync(fileInput);
    let fileLocation = "";
    if (inputStats.isDirectory()) {
        fileLocation = fileInput;
    } else if (inputStats.isFile()) {
        fileLocation = path.dirname(fileInput);
    } else {
        vscode.window.showInformationMessage("Exception! Can't determine file location");
    }
    return fileLocation;
}


// Check name is valid
function checkName(widgetName: string): Boolean {
    if (widgetName === "") {
        vscode.window.showInformationMessage("Widget name can't be empty!");
        return false;
    } else if (!/^[A-Z][A-Za-z]*$/.test(widgetName)) {
        vscode.window.showInformationMessage("Widget name isn't in PascalCase");
        return false;
    } else {
        return true;
    }
}

function getSourceCodeFolderPath(context: vscode.ExtensionContext, lastFolderName: string): string {
    let sourceCodeFolderPath: string = '';
    let workspaceFolders = vscode.workspace.workspaceFolders;
    if (workspaceFolders) {
        const workspacePath = workspaceFolders[0].uri.path;
        const templateFolderPath = vscode.Uri.file(path.join(workspacePath, 'templates', lastFolderName)).fsPath;
        if (fs.existsSync(templateFolderPath)) {
            sourceCodeFolderPath = templateFolderPath;
        }
    }

    if (sourceCodeFolderPath === '' || sourceCodeFolderPath === null) {
        sourceCodeFolderPath = vscode.Uri.file(path.join(context.extensionPath, 'templates', lastFolderName)).fsPath;
    }

    return sourceCodeFolderPath;
}

/// Files name prefix
function getFilePrefix(widgetName: String): string {
    const camelToSnakeCase = widgetName.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
    return camelToSnakeCase.substring(1);
}

/// Create folder for widget/screen-files
function createFolder(widgetPath: string, filePrefix: string): string {
    const folderPath = vscode.Uri.file(path.join(widgetPath, filePrefix)).fsPath;

    if (!fs.existsSync(folderPath)) {
        fs.mkdirSync(folderPath);
    }
    return folderPath;
}

/// Create DI folder
function createDiFolder(parentFolderPath: string): string {
    const folderPath = vscode.Uri.file(path.join(parentFolderPath, "di")).fsPath;

    if (!fs.existsSync(folderPath)) {
        fs.mkdirSync(folderPath);
    }

    return folderPath;
}

/// Create Template file
function createTemplate(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string, isScreen: boolean) {
    const widgetSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template.dart')).fsPath;
    const widgetSourceCode = fs.readFileSync(widgetSourceCodePath, 'utf8').replace(/Template/gi, name);
    const filePath = vscode.Uri.file(path.join(folderPath, `${filePrefix}.dart`)).fsPath;

    fs.writeFileSync(filePath, widgetSourceCode);
}

/// Create WM file
function createWm(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
    const wmSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template_wm.dart')).fsPath;
    const wmSourceCode = fs.readFileSync(wmSourceCodePath, 'utf8').replace(/Template/gi, name);

    const filePath = vscode.Uri.file(path.join(folderPath, `${filePrefix}_wm.dart`)).fsPath;
    fs.writeFileSync(filePath, wmSourceCode);
}

/// Create all dependencies for widget/screen
function createDi(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
    const diFolderPath = createDiFolder(folderPath);

    const diSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'di', 'template_component.dart')).fsPath;
    const diSourceCode = fs.readFileSync(diSourceCodePath, 'utf8').replace(/Template/gi, name);

    const filePath = vscode.Uri.file(path.join(diFolderPath, `${filePrefix}_component.dart`)).fsPath;
    fs.writeFileSync(filePath, diSourceCode);
}



/// Create Route file
function createRoute(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
    const routeSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template_route.dart')).fsPath;
    const routeSourceCode = fs.readFileSync(routeSourceCodePath, 'utf8').replace(/Template/gi, name);

    const filePath = vscode.Uri.file(path.join(folderPath, `${filePrefix}_route.dart`)).fsPath;
    fs.writeFileSync(filePath, routeSourceCode);
}

// Return widget name
async function getWidgetName(): Promise<string> {
    let options: vscode.InputBoxOptions = {
        prompt: "Widget name: ",
        placeHolder: "Input widget name (PascalCase)"
    };
    let widgetName: string = await vscode.window.showInputBox(options).then(value => {
        if (!value) { return ''; }
        return value;
    });
    return widgetName;
}