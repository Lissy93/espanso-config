
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

## Example Usage 

All triggers (except for spelling auto-correct) begin with a colon `:` (similar to Vim's Ex mode commands), followed by a symbol or short string indicating the command.

### Utilities [`[utils.yml]`](https://github.com/Lissy93/espanso-config/blob/master/utils.yml)

- Online Utilities
  - `:ip` - Outputs your current public IP address (using ipify.org)
  - `:weather` - Outputs a summary of the weather in your location (using wttr.in)
- Closures, type `:` followed by a bracket, quote or markup character, and the closing symbol will be inserted, and the cursor moved to the middle
  - `:(` --> `(|)`
  - `:[` --> `[|]`
  - `:{` --> `{|}`
  - `:<` --> `<|>`
  - `` :` `` --> `` `|` ``
  - `:'` --> `'|'`
  - `:"` --> `"|"`
  - `:_` --> `_|_`
  - `:*` --> `*|*`
  - `:-` --> `-|-`
- Markdown Shortcuts
  - `:md-code` - Inserts a markdown code block, and positions the cursor in the center
  - `:md-collapse` - Inserts a markdown collapsable section
  - `:md-anchor` - Inserts a markdown hyperlink, with the clipboard content as the URL, and the cursor moved to the center
- HTML Shortcuts
  - `:html-anchor` - Inserts a HTML anchor element, again with the clipboard used for the href attribute, and cursor moved the the body
  - Insert commonly used HTML tags, and move the cursor to the tag content where applicable
    - `:hr` --> `<hr />`
    - `:br` --> `<br />`
    - `:dev` --> `<div>|</div>`
    - `:span` --> `<span>|</span>`
    - `:para` --> `<p>|</p>`
    - `:hr` --> `<h1>|</h1>` (also `:h2`, `:h3`, `:h4`, `:h5`)
  - `:tag` Insert any custom XML or web component tag, a form will open where you can insert the element name
- Dates and Times
  - `:date` - Inserts the current date as `dd/mm/yy`
  - `:time` - Inserts the current time as `hh:mm`
  - `:month` - Inserts the current month and year, e.g. `April 2021`
- Lenny faces
  - `:lenny` - A dropdown menu will appear, from which you can select an ASCII text emoji, e.g. `¯\\_(ツ)_/¯`
- Software Licenses
  - `:mit-short` - Inserts MIT license in format of `Licensed under MIT X11, © [NAME] 2021: [URL or EMAIL]`
  - `:mit-long` - Fetches and inserts full MIT license from a Gist URL
- CLI Commands
  - `:commit` - Inserts git commit command, with the cursor ready in the message flag
  - `:wtc` - Fetches and inserts a random, funny git commit message from `whatthecommit.com`
  - _Note that there are much better methods for managing terminal commands, such as alliases_
- Quick Search - Inserts the URL with search parameters, , use Ctrl + L to focus address bar
  - `:srch-ddg` - Searches DuckDuck Go --> `https://duckduckgo.com/?q=`
  - `:srch-wiki` - Searches Wikipedia --> `https://en.wikipedia.org/w/?search=`
  - `:srch-gh` - Searches GitHub --> `https://github.com/search?q=`
  - `:srch-so` - Searches StackOverflow --> `https://stackoverflow.com/search?q=`
  - `:srch-dh` - Searches Docker Hub --> `https://hub.docker.com/search?q=`
  - `:srch-wa` - Searches Wolframalpha --> `https://www.wolframalpha.com/input/?i=`
  - `:srch-red` - Searches Reddit --> `https://www.reddit.com/search/?q=`
  - `:srch-bbc` - Searches BBC --> `https://www.bbc.co.uk/search?q=`
  - `:srch-vt` - Searches VirusTotal --> `https://www.virustotal.com/gui/search/`
  - `:srch-amz` - Searches Amzon --> `https://amazon.co.uk/s?k=`
  - `:srch-yt` - Searches YouTube --> `https://youtube.com/results?q=`
  - `:srch-maps` - Searches Google Maps --> `https://www.google.com/maps/search/`
  - `:srch-goo` - Searches The Google --> `https://google.com/search?q=`

### Spelling Auto-Correct [`[alicia-auto-correct.yml]`](https://github.com/Lissy93/espanso-config/blob/master/alicia-auto-correct.yml)

This script simply replaces misspelled words with their correct spelling. The word list is based on the [words that I personally most commonly mistype](https://listed.to/p/0zNFIsk6mk), but I have also comppiled a more generic list of [4,200 commonly mispelled English words](https://listed.to/p/nWcfB31ZTD).

E.g. ttyping `lentgh` will result in `length` 

The word will not update until a terminator character (such as space or enter) is pressed (defined by `word: true`). The case will be propogated, (because `propagate_case` is set to `true`), so the output will match the case of the original word (either lower-case, upper-case or capitalized)

For more info on using Espanso for spelling corrections, see: https://listed.to/@lissy93/22944/spelling-auto-correct-system



