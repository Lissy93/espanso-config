
<h1 align="center">My Espanso Config</h1>

## Intro

<img align="right" width="350" src="https://i.ibb.co/0GTVC02/espanso-octocat.png">

[Espanso](https://espanso.org/) is an open source, privacy-first, corss-platform text expander developed by [@federico-terzi](https://github.com/federico-terzi) and written in Rust. In short, it detects when you type a certain keyword, and replaces it on the fly with a pre-defined string or dynamic output.

It uses a file-based configuration, written entirely in YAML (but I think there is a GUI [in development](https://github.com/federico-terzi/espanso/issues/255)), and for the most part is quick and easy to it it configured exactly to your liking. It runs on Windows, MacOS and Linux, and works with pretty much any program. Espanso not only supports simple text replacement/ expansion, but also images, custom scripts and shell commands, app-specific configurations and built-in date support. It's under active development, so hopefully there will be additional functionality added in the future. 

This repo contains my personal configuration, which is bundled into my [dotfiles](https://github.com/Lissy93/dotfiles) to make setting up new systems easier. But I hope that it might also demonstrate a few of the awesome things that you can use Espanso for, including:
- Quickly typing characters that do not appear on you're keyboard (such as foreign language characters, emojis or specialist symbols)
- Easily inserting longer strings that would otherwise have required many keystrokes
- Inserting dynamic content, such as the output of a script, response from an API call, or time/ date info
- Making typing easier, with a custom spelling and grammar auto-correct system

## Setup

- Install [Espanso](https://espanso.org/install/) if not already
- Run `espanso path` to determine where you're config should be stored. Within this folder, there should be a directory called `user/`, this is where you store all your custom scripts
- Fork this (or another) repo, and clone it to your system, then setup a symlink to the directory mentioned above. Running `espanso restart` will reload with your new config
- You can now edit the YAML files to meet your needs, and reload Espanso for changes to take effect

See Also: [Espanso: Getting Started](https://espanso.org/docs/get-started/)

## Usage 

### Utilities [`[utils.yml]`](https://github.com/Lissy93/espanso-config/blob/master/utils.yml)

Contains a bunch of random, but handy utilitis, including:
- Get dynamic information: `:ip` for your public IP address, `:weather` will return the weather in your current location, `:date`, `:time` and `:month` will output time/ date info
- Lots of ASCII emojis/ Lenny faces: just type `:lenny` and a dropdown will appear
- Closing brackets, quotes and symbols: Save a keypress with `:(` and the corresponding bracket will be closed, with the cursor in the middle. This works for `()`, `[]`, `{}`, `<>`, `` ` ` ``, `''`, `""`, `__`, `--` and `**`
- Markdown shortcuts: `:md-code` and `:md-collapse` output their corresponding markdown elements, and place the cursor inside
- HTML shortcuts: Common tags, like `:hr`, `:br`, `:div`, `:span`, `:para`, `:h1`, `:h2` etc are autofilled, with the cursor placed inside the tag ready for the value. For custom web components and XML tags, use `:tag`, then type the name of the element
- Easily format a link: With a link in the clipboard use `:html-anchor` (HTML), `:md-anchor` (markdown) or `:bb-anchor` (BB Code) to create an element with the href already set, and the cursor in the center ready for title/ name
- Generate deterministic passwords with Lesspass: Type `:pass` and then when prompted ender site name, account and master pass, and the password will be returned. (Requires the [Lesspass CLI tool](https://github.com/lesspass/lesspass/tree/master/cli) to be installed)
- Formulate web searches: `:srch` followed by the service name will construct the search URL, and place the cursor in the right place to type the query. Works for DuckDuckGo, Wikipedia, Github, Stackoverflow, DockerHub, Wolframalpha, Reddit, BBC, Virus Total, Amazon, YouTube, Maps and Google. E.g. `:srch-wiki`

See: [Full Example Usage](https://listed.to/p/SCECNfepuR) 


### Spelling Auto-Correct [`[alicia-auto-correct.yml]`](https://github.com/Lissy93/espanso-config/blob/master/alicia-auto-correct.yml)

This script simply replaces misspelled words with their correct spelling. E.g. typing `lentgh` will result in `length`.

The word will not update until a terminator character (such as space or enter) is pressed (defined by `word: true`). The case will be propogated, (because `propagate_case` is set to `true`), so the output will match the case of the original word (either lower-case, upper-case or capitalized)

The word list is based on the [words that I personally most commonly mistype](https://listed.to/p/0zNFIsk6mk), but I have also comppiled a more generic list of [4,200 commonly mispelled English words](https://listed.to/p/nWcfB31ZTD). For more info see [here](https://listed.to/@lissy93/22944/spelling-auto-correct-system).


