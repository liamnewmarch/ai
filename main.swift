#!/usr/bin/swift
import Foundation
import FoundationModels

enum ModelError: Error, CustomStringConvertible {
    case message(String)
    var description: String {
        switch self {
            case .message(let s):
                return s
        }
    }
}

func exitWithError(error: Error) {
    fputs("Error: \(error)\n", stderr)
    exit(1)
}

func checkModelAvailable() {
    let model = SystemLanguageModel.default
    guard model.availability == .available else {
        return exitWithError(error: ModelError.message("Model not available"))
    }
}

@MainActor
func streamPrompt(session: LanguageModelSession, _ promptText: String) async throws {
    let stream = session.streamResponse(to: Prompt(promptText))
    var lastContent = ""
    for try await partial in stream {
        let content = partial.content
        guard !content.isEmpty else { continue }
        if content.hasPrefix(lastContent) {
            let delta = content.dropFirst(lastContent.count)
            if !delta.isEmpty {
                print(String(delta), terminator: "")
                fflush(stdout)
            }
        } else {
            print(content, terminator: "")
            fflush(stdout)
        }
        lastContent = content
    }
    print("")
}

Task {
    checkModelAvailable()

    let args = CommandLine.arguments
    if args.count >= 2 {
        let promptText = args.dropFirst().joined(separator: " ")
        do {
            let session = LanguageModelSession()
            try await streamPrompt(session: session, promptText)
            exit(0)
        } catch {
            return exitWithError(error: error)
        }
    }

    do {
        let session = LanguageModelSession()
        session.prewarm()
        while true {
            print("> ", terminator: "")
            guard let line = readLine(strippingNewline: true) else {
                exit(0)
            }
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                continue
            }
            if ["exit", "quit"].contains(trimmed) {
                exit(0)
            }
            print("")
            try await streamPrompt(session: session, trimmed)
            print("")
        }
    } catch {
        return exitWithError(error: error)
    }
}
RunLoop.main.run()
