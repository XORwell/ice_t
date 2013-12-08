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
rule = IceT::Rule::Secondly.new(42)  # => every 42 seconds
rule = IceT::Rule::Minutely.new(42)  # => every 42 minutes
rule = IceT::Rule::Hourly.new(42)    # => every 42 hours
rule = IceT::Rule::Daily.new(42)     # => every 42 days
rule = IceT::Rule::Weekly.new(42)    # => every 42 weeks
rule = IceT::Rule::Monthly.new(42)   # => every 42 months
rule = IceT::Rule::Yearly.new(42)    # => every 42 years
```

```ruby
rule = IceT::Rule::Secondly.new      # => every second
```


### Get time occurrences

```ruby
rule.occurrences # => Array of times
```

### Schedule

The Schedule helps on dealing with multiple rules.

```ruby
schedule = IceT::Schedule.new(start_time: Time.now, end_time: Time.now + 4.months)
schedule.add_rule my_daily_rule
schedule.add_rule my_monthly_rule

schedule.rules              # => Array of rules
schedule.occurrences        # => Merged occurrences
```

### Persistence

Lets say you want to store and restore your Schedule. Do this:

```ruby
json = schedule.to_json
schedule = IceT::Schedule.from_json(json)
```

## Tipps - section is under construction

### Sorting rules:

[r2,r1,r3].sort.collect(&:interval) 

### Comparing rules:
	
```ruby
IceT::Rule::Daily.new(1) < IceT::Rule::Monthly.new(1) # => true
```

```ruby
r2.between?(r1, r3)
```
IceT::Rule::Daily.new(14).occurrences(1.year.ago, Time.now).first(5)


## License
This software is released under the [MIT License](http://opensource.org/licenses/MIT).

Copyright © 2013 Christian Nennemann _(christian.nennemann[at]gmail[dot]com)_

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.