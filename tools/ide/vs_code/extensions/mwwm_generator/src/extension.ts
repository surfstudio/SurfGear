// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';
import { MwwmWidgetCreator, SurfMwwmScreenCreator, SurfMwwmWidgetCreator } from './creators';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {
	let mwwmWidgetDisposable = vscode.commands.registerCommand('mwwm-generator.create-mwwm-widget', async (...args: any[]) => {
		try {
			const creator = new MwwmWidgetCreator();
			creator.create(context, args);
		} catch (e) { console.log(e); }
	});

	let surfMwwmWidgetDisposable = vscode.commands.registerCommand('mwwm-generator.create-surf-mwwm-widget', async (...args: any[]) => {
		try {
			const creator = new SurfMwwmWidgetCreator();
			creator.create(context, args);
		} catch (e) { console.log(e); }
	});

	let surfMwwmScreenDisposable = vscode.commands.registerCommand('mwwm-generator.create-surf-mwwm-screen', async (...args: any[]) => {
		try {
			const creator = new SurfMwwmScreenCreator();
			creator.create(context, args);
		} catch (e) { console.log(e); }
	});

	context.subscriptions.push(mwwmWidgetDisposable);
	context.subscriptions.push(surfMwwmWidgetDisposable);
	context.subscriptions.push(surfMwwmScreenDisposable);
}

// this method is called when your extension is deactivated
export function deactivate() { }
