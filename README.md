# slackbot-martin

slackbot-martin is a chat bot built for use in the team's private Slack channel, and runs on a Raspberry Pi web server.

The team's intention is to provide greater interaction inside the Slack channel by providing additional functionality, as well as to gain additional use from the Pi.

Below is a list of current methods we've implemented thus far:

## <b>"Alive"</b>
- Our robot is persistent, and can restart itself whenever it detects a change to its script.
- When it finishes restarting, it sends a message to the project chat room, saying:
- <i>I'm Alive!</i>
- Alerting us when he's able to receive commands again.

## <b>"Animate"</b>
- Get a random animated gif from the internet based off of a query.
- <i>ricky animate &lt;user's choice of query words&gt;</i>
- API powered by: ![](https://media.giphy.com/media/3o6gbbuLW76jkt8vIc/giphy.gif width="100")
