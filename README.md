# IceT

[![Gem Version](https://badge.fury.io/rb/ice_t.png)](http://badge.fury.io/rb/ice_t)
[![Code Climate](https://codeclimate.com/github/XORwell/ice_t.png)](https://codeclimate.com/github/XORwell/ice_t)
[![Build Status](https://travis-ci.org/XORwell/ice_t.png)](https://travis-ci.org/XORwell/ice_t)
[![Dependency Status](https://gemnasium.com/XORwell/ice_t.png)](https://gemnasium.com/XORwell/ice_t)

IceT is a ruby library for handling repeated events.

## Installation

Add this line to your application's Gemfile:

    gem 'ice_t'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ice_t

## Usage

### Creating rules

```ruby
rule = IceT::Rule::Secondly.new(42)  # => step by 42 seconds
rule = IceT::Rule::Minutely.new(42)  # => step by 42 minutes
rule = IceT::Rule::Hourly.new(42)    # => step by 42 hours
rule = IceT::Rule::Daily.new(42)     # => step by 42 days
rule = IceT::Rule::Weekly.new(42)    # => step by 42 weeks
rule = IceT::Rule::Monthly.new(42)   # => step by 42 months
rule = IceT::Rule::Yearly.new(42)    # => step by 42 years
```

### Get time occurrences

```ruby
rule.occurrences(2.months.ago, Time.now) # => Array of times
```

### Schedule
The Schedule helps on dealing with multiple rules.

```ruby
schedule = IceT::Schedule.new
schedule.add_rule my_daily_rule
schedule.add_rule my_monthly_rule

schedule.rules              # => Array of rules
schedule.occurrences        # => Merged occurrences
```

### Serialization

Lets say you want to your Schedule in your database
and use it later again. You can do this:

```ruby
json = schedule.to_json
schedule = IceT::Schedule.from_json(json)
```

## Tipps - doc in development

### Sorting rules:

[r2,r1,r3].sort.collect(&:interval) 

### Comparing rules:
	
```ruby
IceT::Rule::Daily.new(1) < IceT::Rule::Monthly.new(1) # => true
```
	r2.between?(r1, r3)
