# ai – Command line utility to chat with on-device Apple Intelligence

## Background

Apple Intelligence on macOS uses an on device LLM which is made available to developers through the FoundationModels framework.

This project is a simple command line utility which allows you to chat with that model locally.

## Requirements

* A Mac with Apple Intelligence enabled (System Settings → Apple Intelligence).
* Command-line tools for Xcode, including Swift with support for FoundationModels.

## Quick start

First, clone the repo

```sh
git clone https://github.com/liamnewmarch/ai
cd ai
```

Run a single prompt – streams the response to stdout and exits.

```sh
swift main.swift 'Write three haiku poems about a golden retriever'
```

Start an interactive shell – maintains session context until exit.

```sh
swift main.swift
> Enter your prompt here
```

Type "exit", "quit" or ctrl-d to quit.

## Installation

You can also compile the program and put it somewhere in your `PATH` for easy access.

```sh
swiftc main.swift -o ai
sudo mv ai /usr/local/bin
```

Use `ai tell me a joke`, or run `ai` to start the interactive shell.
