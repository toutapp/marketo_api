# Marketo API
[![Build Status](https://travis-ci.org/toutapp/marketo_api.svg?branch=master)](https://travis-ci.org/toutapp/marketo_api)
[![Code Climate](https://codeclimate.com/github/toutapp/marketo_api/badges/gpa.svg)](https://codeclimate.com/github/toutapp/marketo_api)

> IMPORTANT: This is an **alpha** stage gem and is **not** ready for production use

`MarketoApi` is a ruby wrapper for the Marketo RESTful API endpoints

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marketo_api'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install marketo_api
```

## Usage

```ruby
client = MarketoApi::Client.new(...)
```

- TODO

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `marketo_api/version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

- How? TODO
- Coverage: TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/toutapp/marketo_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

(The MIT License)

Copyright (c) 2017 Marketo, Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
