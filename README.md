# matrix-easy

An Automated Setup system for Matrix and Common Bridges in docker. Intended as a self-hosted alternative to [Beeper](https://www.beeperhq.com/).

## Features

- Automated setup for Matrix Synapse Server
- Automated setup for Matrix Bridges
  - [Discord](https://github.com/mautrix/discord)
  - [Facebook Messenger](https://github.com/mautrix/meta)
  - [Google Chat](https://github.com/mautrix/googlechat)
  - [iMessage (requires a mac to act as the actual bridge)](https://github.com/mautrix/imessage)
  - [Instagram](https://github.com/mautrix/meta)
  - [IRC](https://github.com/hifi/heisenbridge)
  - [Linkedin](https://github.com/beeper/linkedin)
  - [Signal](https://github.com/mautrix/signal)
  - [Slack](https://github.com/mautrix/slack)
  - [SMS/RCS](https://github.com/mautrix/gmessages)
  - [Telegram](https://github.com/mautrix/telegram)
  - [Twitter](https://github.com/mautrix/twitter)
  - [WhatsApp](https://github.com/mautrix/whatsapp)
- Modified versions of the telegram and linkedin bridges that support spaces for easy service filtering

## Installation

1. Install Docker and Docker Compose
2. Clone the repository or [download the zip](https://github.com/michaelphagen/matrix-easy)
3. Run the ./start.sh script and follow the prompts
4. Sign in to your matrix server and message the bridge bots using the names below to link your accounts. Instructions for authentication can be found on the page for each bridge, linked above

## Bot Names

- Discord: @discordbot:your_domain_name
- Facebook Messenger: @fbmessengerbot:your_domain_name
- Google Chat: @googlechatbot:your_domain_name
- iMessage: @imessagebot:your_domain_name
- Instagram: @instagrambot:your_domain_name
- IRC: @heisenbridge:your_domain_name
- Linkedin: @linkedinbot:your_domain_name
- Signal: @signalbot:your_domain_name
- Slack: @slackbot:your_domain_name
- SMS/RCS: @gmessagesbot:your_domain_name
- Telegram: @telegrambot:your_domain_name
- Twitter: @twitterbot:your_domain_name
- WhatsApp: @whatsappbot:your_domain_name

## Donate

If you find this project useful and you would like to donate toward on-going development you can use the link below. Any and all donations are much appreciated!

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/michaelphagen)

## Disclaimer

I have created this as a quick-start to a process that is otherwise somewhat complicated to complete. I have made opinionated decisions on settings, including setting permissions on some files and folders, that may not be what you would have done. Feel free to use this as a starting place if you don't like my choices, but I am not responsible for the security or maintennce of your system whether you use my settings or not.
