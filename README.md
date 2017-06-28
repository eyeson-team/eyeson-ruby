# Eyeson
eyeson ruby sdk for service app implementation

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'eyeson'
```

And then execute:
```bash
$ bundle install
```

## Configuration
```ruby
Eyeson.configure do |config|
  config.api_key      = 'YOUR_API_KEY'
  config.api_endpoint = 'https://api.eyeson.team'
end
```

## Receive webhooks for specific events

```ruby
Eyeson::Webhook.create!(
  url,       # Webhooks will be sent to this URL
  types: []  # currently supported: 'room_update', 'team_update', 'user_update', 'presentation_update', 'broadcast_update', 'file_update'
)
```

## Meeting reference

### Join a meeting room

Puts a user to a (specific) meeting room.

If no arbitrary ids are given, random ids will be generated.

```ruby
room = Eyeson::Room.join(id:   'ARBITRARY_ID',     # optional, e.g. to join a specific room
                         name: 'DISPLAY_NAME',     # optional
                         user: {
                        	 id:     'ARBITRARY_ID', # optional, e.g. your internal user_id
                        	 name:   'DISPLAY_NAME', # required!
                        	 avatar: 'IMAGE_URL'     # optional
                         })
```

The meeting room will be available immediately:

```ruby
# Temporary access key - only valid for current session:
# access_key = room.access_key 

redirect_to room.url
```

### Upload a presentation file from remote URL

Uploads and converts any external stored PDF file for presentation.

```ruby
Eyeson::FileUpload.new(access_key).upload_from('FILE_URL')
```

### Start a live broadcast (YouTube only at the moment)

```ruby
Eyeson::Broadcast.new(access_key).create(
  platform:   'youtube',
  stream_url: 'YOUTUBE_STREAM_URL' # see YouTube documentation on how to get a stream url.
)
```

#### Stop specific broadcast

```ruby
Eyeson::Broadcast.new(access_key).destroy(
  platform: 'youtube'
)
```

#### Stop all broadcasts

```ruby
Eyeson::Broadcast.new(access_key).destroy_all
```

### Send a message into meeting chat

```ruby
Eyeson::Message.new(access_key).create(
  type:    'chat',
  content: 'YOUR_MESSAGE'
)
```

### Insert an image into video

```ruby
Eyeson::Layer.new(access_key).create(
  file:   FILE, # either file or url must be provided!
  url:    URL,  # either file or url must be provided!
  index:  1,    # (optional) use 1 (default) to set as foreground image and -1 to set as background image
  layout: nil   # (optional) currently supported: 'auto' (meeting participants will be arranged automatically), 'fixed' (meeting participants will be rendered at the bottom of the video, so your background content can be fully displayed.)
)
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
