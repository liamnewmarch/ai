# ai – Command-line utility to chat with the on-device foundation model on macOS

## Background

The Apple Intelligence stack has several layers. Depending on prompt complexity, a request can be handled by:

* the on-device LLM (the ‘Foundation Model’),
* Apple-managed ‘Private Cloud Compute’, or
* a third-party extension partner (currently ChatGPT).

This project is a simple command-line utility which allows you to chat with the on-device foundation model via the [Foundation Models framework](https://developer.apple.com/documentation/foundationmodels).

## Requirements

* A Mac with [Apple Intelligence enabled](https://support.apple.com/en-us/121115) (System Settings → Apple Intelligence).
* [Command-line tools for Xcode](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools), including Swift with Foundation Models support.

## Quick start

First, clone the respository:

```sh
git clone https://github.com/liamnewmarch/ai
cd ai
```

Run a single prompt (streams the response to stdout and exits):

```sh
swift main.swift 'Write three haiku poems about a golden retriever'
```

Start an interactive shell (maintains session context until exit):

```sh
swift main.swift
> Enter your prompt here
```

Type "exit", "quit" or Ctrl-D to quit.

## Installation

Compile the install to your `PATH` for easier use:

```sh
swiftc main.swift -o ai
sudo mv ai /usr/local/bin
```

Then run:

* `ai tell me a joke` – run a single prompt.
* `ai` – start an interactive shell.
