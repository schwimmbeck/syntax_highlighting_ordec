// SPDX-FileCopyrightText: 2026 ORDeC contributors
// SPDX-License-Identifier: Apache-2.0

const vscode = require("vscode");
const { LanguageClient } = require("vscode-languageclient/node");

const LANGUAGE_ID = "ord";
const CLIENT_ID = "ordecLanguageServer";
const CLIENT_NAME = "ORD Language Server";

let client;
let outputChannel;

function activate(context) {
  outputChannel = vscode.window.createOutputChannel(CLIENT_NAME);
  context.subscriptions.push(outputChannel);

  context.subscriptions.push(
    vscode.commands.registerCommand("ord.restartLanguageServer", async () => {
      await restartLanguageServer(context, true);
    }),
    vscode.commands.registerCommand("ord.showLanguageServerOutput", () => {
      outputChannel.show(true);
    }),
    vscode.workspace.onDidChangeConfiguration(event => {
      if (event.affectsConfiguration("ord.languageServer")) {
        void restartLanguageServer(context, false);
      }
    })
  );

  if (isLanguageServerEnabled()) {
    void restartLanguageServer(context, false);
  }
}

async function deactivate() {
  await stopLanguageServer();
}

async function restartLanguageServer(context, userInitiated) {
  await stopLanguageServer();

  if (!isLanguageServerEnabled()) {
    outputChannel.appendLine("ORD language server disabled by configuration.");
    if (userInitiated) {
      void vscode.window.showInformationMessage("ORD language server is disabled.");
    }
    return;
  }

  const serverOptions = createServerOptions(context);
  const clientOptions = createClientOptions();

  outputChannel.appendLine(
    `Starting ${CLIENT_NAME}: ${serverOptions.run.command} ${serverOptions.run.args.join(" ")}`
  );

  client = new LanguageClient(CLIENT_ID, CLIENT_NAME, serverOptions, clientOptions);

  try {
    await Promise.resolve(client.start());
    if (userInitiated) {
      void vscode.window.showInformationMessage("ORD language server restarted.");
    }
  } catch (error) {
    const message = formatError(error);
    outputChannel.appendLine(`Failed to start ${CLIENT_NAME}: ${message}`);
    client = undefined;
    void vscode.window.showWarningMessage(
      `Failed to start ORD language server. See '${CLIENT_NAME}' output for details.`
    );
  }
}

async function stopLanguageServer() {
  if (!client) {
    return;
  }

  const activeClient = client;
  client = undefined;
  await activeClient.stop();
}

function isLanguageServerEnabled() {
  const config = vscode.workspace.getConfiguration("ord");
  return config.get("languageServer.enabled", true);
}

function createServerOptions(context) {
  const config = vscode.workspace.getConfiguration("ord");
  const command = resolveTemplate(
    config.get("languageServer.command", "ordec-lsp"),
    context
  );
  const args = config
    .get("languageServer.args", [])
    .map(arg => resolveTemplate(arg, context));
  const configuredCwd = config.get("languageServer.cwd", "${workspaceFolder}");
  const cwd = resolveTemplate(configuredCwd, context);
  const envOverrides = config.get("languageServer.env", {});

  return {
    run: {
      command,
      args,
      options: {
        cwd,
        env: {
          ...process.env,
          ...resolveEnv(envOverrides, context),
        },
      },
    },
    debug: {
      command,
      args,
      options: {
        cwd,
        env: {
          ...process.env,
          ...resolveEnv(envOverrides, context),
        },
      },
    },
  };
}

function createClientOptions() {
  const watcher = vscode.workspace.createFileSystemWatcher("**/*.ord");
  const config = vscode.workspace.getConfiguration("ord");

  return {
    documentSelector: [
      { scheme: "file", language: LANGUAGE_ID },
      { scheme: "untitled", language: LANGUAGE_ID },
    ],
    synchronize: {
      fileEvents: watcher,
    },
    outputChannel,
    traceOutputChannel: outputChannel,
    initializationOptions: {
      language: "ord2",
    },
    markdown: {
      isTrusted: false,
    },
    trace: config.get("languageServer.trace.server", "off"),
  };
}

function resolveEnv(envOverrides, context) {
  const resolved = {};
  for (const [key, value] of Object.entries(envOverrides)) {
    resolved[key] = resolveTemplate(String(value), context);
  }
  return resolved;
}

function resolveTemplate(value, context) {
  const folder = vscode.workspace.workspaceFolders?.[0];
  const workspaceFolder = folder ? folder.uri.fsPath : "";
  const workspaceFolderBasename = folder ? folder.name : "";

  return String(value)
    .replaceAll("${workspaceFolder}", workspaceFolder)
    .replaceAll("${workspaceFolderBasename}", workspaceFolderBasename)
    .replaceAll("${extensionPath}", context.extensionPath);
}

function formatError(error) {
  if (error instanceof Error) {
    return error.stack || error.message;
  }
  return String(error);
}

module.exports = {
  activate,
  deactivate,
};
