# IceT

[![Gem Version](https://badge.fury.io/rb/ice_t.png)](http://badge.fury.io/rb/ice_t)
[![Code Climate](https://codeclimate.com/github/XORwell/ice_t.png)](https://codeclimate.com/github/XORwell/ice_t)
[![Build Status](https://travis-ci.org/XORwell/ice_t.png)](https://travis-ci.org/XORwell/ice_t)
[![Dependency Status](https://gemnasium.com/XORwell/ice_t.png)](https://gemnasium.com/XORwell/ice_t)
[![Coverage Status](https://coveralls.io/repos/XORwell/ice_t/badge.png)](https://coveralls.io/r/XORwell/ice_t)

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
rule.occurrences(2.days.ago, Time.now) # => Array of times

IceT::Rule::Daily.new(14).occurrences(1.year.ago, Time.now).first(5)

```

### Persistence

Store and restore the rule:

```ruby

# JSON
rule = IceT::Rule::Daily.new(42)
json = rule.to_json
restored = IceT::Rule::Base.from_json(json)

# YAML
rule = IceT::Rule::Daily.new(42)
yaml = rule.to_yaml
restored = IceT::Rule::Base.from_yaml(yaml)

# Hash
rule = IceT::Rule::Daily.new(42)
hash = rule.to_hash
restored = IceT::Rule::Base.from_hash(hash)

```


### Comparison and sorting
	
```ruby
IceT::Rule::Daily.new(1) < IceT::Rule::Monthly.new(1) # => true
```

```ruby
# compare different type of rules

minutely = IceT::Rule::Minutely.new(1)
hourly   = IceT::Rule::Hourly.new(1)
daily    = IceT::Rule::Daily.new(1)

hourly.between?(minutely, daily) # => true
minutely.between?(hourly, daily) # => false


# compare same type of rules

r1 = IceT::Rule::Daily.new(1)
r2 = IceT::Rule::Daily.new(2)
r3 = IceT::Rule::Daily.new(3)

r2.between?(r1, r2)	# => true
r1.between?(r2, r3)	# => false

# sort these rules

[r2,r1,r3].sort.collect(&:interval) # => [1, 2, 3]

```


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