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

			const widgetName = await getWidgetName();
			if (widgetName === "") return;


			console.log('widgetName ' + widgetName);
		}
		catch (e) {
			console.log(e);
		}
	});

	let screenDisposable = vscode.commands.registerCommand('mwwm-generator.create-screen', (...args: any[]) => {
		vscode.window.showInformationMessage('Create screen!');
		console.log('args ' + args);
	});

	context.subscriptions.push(widgetDisposable);
	context.subscriptions.push(screenDisposable);
}

// this method is called when your extension is deactivated
export function deactivate() { }

// Return path to create widget/screen
function getWidgetLocation(args: any[]): String {
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

// Return widget/screen name
async function getWidgetName(): Promise<String> {
	let options: vscode.InputBoxOptions = {
		prompt: "Widget name: ",
		placeHolder: "Input widget name (CamelCase)"
	}
	let widgetName: String = await vscode.window.showInputBox(options).then(value => {
		if (!value) return '';
		return value;
	});
	return widgetName;
}