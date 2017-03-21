# Eyeson
Internal eyeson api rails sdk for service app implementation

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'eyeson'
```

And then execute:
```bash
$ bundle
```

## Configuration
```ruby
Eyeson.configure do |config|
  config.api_key           = 'YOUR_API_KEY'
  config.api_endpoint      = 'https://api.eyeson.team'
  config.account_endpoint  = 'https://accounts.eyeson.team/api'
  config.account_api_key   = ''
  config.internal_username = ''
  config.internal_password = ''
end
```

## Usage

### Join a meeting room

Puts a user to a (specific) meeting room.

If no arbitrary ids are given, random ids will be generated.

```ruby
room = Eyeson::Room.new(id:   'ARBITRARY_ID',     # optional, e.g. to join a specific room
                        name: 'DISPLAY_NAME',     # required!
                        user: {
                        	id:     'ARBITRARY_ID', # optional, e.g. your internal user_id
                        	name:   'DISPLAY_NAME', # required!
                        	avatar: 'IMAGE_URL'     # optional
                        })
```

The meeting room will be available immediately:

```ruby
redirect_to room.url
```

### Intercom

## Info requested by marketing team:

# Fields

- First seen date
- Last seen date
- First seen platform (integration system, tryout, account portal, ...)
- First seen Source (videomeeting, newsletter, guest join, ...)
- Account registration date (signup, onboarding)
- Tryout start date
- Tryout end date
- Number of videomeetings total (obtained by count of events for videomeetings)
- Number of videomeetings for each integration (obtained by count of events for specific integration)
- Number of presentations
- Number of screencastings

# Events

- User registered account
- User made a videomeeting (+ system info)

# Accounts/Intercom API:


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
