# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
#  Ricky lets us know when he wakes up.
   ROOM = 'project-martin'
   MESSAGE = 'I\'m Alive!'

   roomOrPerson = { "room": /^#(.*)/ }
   isRoom =  ROOM.match roomOrPerson.room
   if isRoom then return robot.messageRoom isRoom[1], MESSAGE
   robot.messageRoom ROOM, MESSAGE
#  Finds random animated gif based off of entered words.
   robot.hear /ricky animate (.*)/i, (msg) ->
     imagery = msg.match[1]
     msg.http('http://api.giphy.com/v1/gifs/search')
     .query(api_key: "dc6zaTOxFJmzC", q: imagery)
     .get() (err, res, body) ->
       images = JSON.parse(body)
       ran_key = images.data[Math.floor(Math.random() * images.data.length)]
       image = ran_key.images.fixed_height.url
       msg.send image
#  Chooses random response from array when robot enters and/or leaves a chat room.
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies
#  Room specific commands kept for reference. 
   robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
     room   = req.params.room
     data   = JSON.parse req.body.payload
     secret = data.secret
  
     robot.messageRoom room, "I have a secret: #{secret}"
  
     res.send 'OK'
#  Error catching and logging.
   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"
  
     if res?
       res.reply "DOES NOT COMPUTE"
#  Function to give robot a soda for being a good boy.
   robot.respond /have a soda/i, (res) ->
     # Get number of sodas had (coerced to a number).
     sodasHad = robot.brain.get('totalSodas') * 1 or 0
  
     if sodasHad > 3
       res.reply "I'm too fizzy.."
  
     else
       res.reply 'Sure!'
  
       robot.brain.set 'totalSodas', sodasHad+1
#  Function to reset robot's soda count.
   robot.respond /sleep it off/i, (res) ->
     robot.brain.set 'totalSodas', 0
     res.reply 'zzzzz'
