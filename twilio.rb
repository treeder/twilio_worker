require 'twilio-ruby'

sid = params['sid']
token = params['token']
from = params['from']
to = params['to']
body = params['body']
type = params['type'] || "sms" # pass in "call" to make a call
url = params['url'] # required for "call" type, Twilio will callback to this URL
# Info on Twilio API params: https://www.twilio.com/docs/api/rest/making-calls

# LOOK HERE!
# This is where we can generate a custom message for the user!
# Pull in data from your database, from API's, etc. Maybe crunch it into something interesting...
# But for now, we'll just send what's passed in.

body ||= "Hello from IronWorker!"

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new sid, token

if params['type'] == "call"
  r = @call = @client.account.calls.create(
      :from => from,
      :to => to,
      :url => url
  )
else
  puts "Sending sms..."
# And finally, send the message
  r = @client.account.sms.messages.create(
      :from => from,
      :to => to,
      :body => body
  )
end
puts "Twilio response:"
p r

