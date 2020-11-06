// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {
	let widgetDisposable = vscode.commands.registerCommand('mwwm-generator.create-widget', async (...args: any[]) => {
		try {
			const widgetPath = getWidgetLocation(args);
			if (widgetPath === "") return;

			// const widgetName = await getWidgetName();
			const widgetName = "Testing";
			if (!checkName(widgetName)) return;

			const filePrefix = getFilePrefix(widgetName);
			const folderPath = createFolder(widgetPath, filePrefix);

			const sourceCodeFolderPath = vscode.Uri.file(path.join(context.extensionPath, 'templates', 'widget')).fsPath;
			createTemplate(sourceCodeFolderPath, widgetName, folderPath, filePrefix, false);
			createWm(sourceCodeFolderPath, widgetName, folderPath, filePrefix);
			createDi(sourceCodeFolderPath, widgetName, folderPath, filePrefix);
		}
		catch (e) {
			console.log(e);
		}
	});

	let screenDisposable = vscode.commands.registerCommand('mwwm-generator.create-screen', (...args: any[]) => {
		const screenPath = getWidgetLocation(args);
		if (screenPath === "") return;

		// const widgetName = await getScreenName();
		const screenName = "Settings";
		if (!checkName(screenName)) return;

		const filePrefix = getFilePrefix(screenName);
		const folderPath = createFolder(screenPath, filePrefix);

		const sourceCodeFolderPath = vscode.Uri.file(path.join(context.extensionPath, 'templates', 'screen')).fsPath;
		createTemplate(sourceCodeFolderPath, screenName, folderPath, filePrefix, true);
		createWm(sourceCodeFolderPath, screenName, folderPath, filePrefix);
		createDi(sourceCodeFolderPath, screenName, folderPath, filePrefix);
		createRoute(sourceCodeFolderPath, screenName, folderPath, filePrefix);
	});

	context.subscriptions.push(widgetDisposable);
	context.subscriptions.push(screenDisposable);
}

// this method is called when your extension is deactivated
export function deactivate() { }

// Return path to create widget/screen
function getWidgetLocation(args: any[]): string {
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

// Return widget name
async function getWidgetName(): Promise<string> {
	let options: vscode.InputBoxOptions = {
		prompt: "Widget name: ",
		placeHolder: "Input widget name (PascalCase)"
	}
	let widgetName: string = await vscode.window.showInputBox(options).then(value => {
		if (!value) return '';
		return value;
	});
	return widgetName;
}

// Return screen name
async function getScreenName(): Promise<string> {
	let options: vscode.InputBoxOptions = {
		prompt: "Screen name: ",
		placeHolder: "Input screen name (PascalCase)"
	}
	let widgetName: string = await vscode.window.showInputBox(options).then(value => {
		if (!value) return '';
		return value;
	});
	return widgetName;
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

/// Create Template(Widget/Screen) file
function createTemplate(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string, isScreen: boolean) {
	const widgetSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template.txt')).fsPath;
	let className = name;
	if (isScreen) {
		className = `${className}Screen`;
	}
	const widgetSourceCode = fs.readFileSync(widgetSourceCodePath, 'utf8').replace(/Template/gi, className);

	let fileName;
	if (isScreen) {
		fileName = `${filePrefix}_screen.dart`;

	} else {
		fileName = `${filePrefix}.dart`;
	}
	const filePath = vscode.Uri.file(path.join(folderPath, fileName)).fsPath

	fs.writeFileSync(filePath, widgetSourceCode);
}

/// Create WM file
function createWm(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
	const wmSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template_wm.txt')).fsPath;
	const wmSourceCode = fs.readFileSync(wmSourceCodePath, 'utf8').replace(/Template/gi, name);

	const filePath = vscode.Uri.file(path.join(folderPath, `${filePrefix}_wm.dart`)).fsPath
	fs.writeFileSync(filePath, wmSourceCode);
}

/// Create all dependencies for widget/screen
function createDi(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
	const diFolderPath = createDiFolder(folderPath);

	const diSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'di', 'template_component.txt')).fsPath;
	const diSourceCode = fs.readFileSync(diSourceCodePath, 'utf8').replace(/Template/gi, name);

	const filePath = vscode.Uri.file(path.join(diFolderPath, `${filePrefix}_component.dart`)).fsPath
	fs.writeFileSync(filePath, diSourceCode);
}

/// Create Route file
function createRoute(sourceCodeFolderPath: string, name: string, folderPath: string, filePrefix: string) {
	const routeSourceCodePath = vscode.Uri.file(path.join(sourceCodeFolderPath, 'template_route.txt')).fsPath;
	const routeSourceCode = fs.readFileSync(routeSourceCodePath, 'utf8').replace(/Template/gi, name);

	const filePath = vscode.Uri.file(path.join(folderPath, `${filePrefix}_route.dart`)).fsPath
	fs.writeFileSync(filePath, routeSourceCode);
}