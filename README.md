# JpgOrWebp

Sniffs the useragent to choose the more appropriate image format between JPEG
and WebP.

## What is it good for?

While we may want to serve WebP images to every browser that supports it (and
also make Google Lighthouse and PageSpeed Insights scores higher), some browser
do not support the format yet.

JPEG support can be assumed to be enabled by default while some browsers and
many legacy versions of the same browsers may or may not support modern image
formats like WebP.

While we can use something like the `<picture>` and `<source>` elements with the
appropriate `type` attribute, in some cases such as legacy applications, we may
prefer to stick with the good-old `<img>` element and use its `srcset` and
`sizes` attributes to serve responsive images.

In a Rails application that uses Active Storage or anything similar to keep
record of and serve each image and their various variants, this gem may be used
as an optimisation tool.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add jpg_or_webp --github=aldavigdis/jpg_or_webp --branch 'main'

If bundler is not being used to manage dependencies, install the gem by
installing the `specific_install` gem and then executing `gem specific_install`
like so:

    $ gem install specific_install
    $ gem specific_install https://github.com/aldavigdis/jpg_or_webp

## Usage

### In a Rack (Rails or Sinatra) app

In Rails and Sinatra, we can use `request.user_agent` to feed the current
request's useragent string into `JpgOrWebp`.

```ruby
jpg_or_webp = JpgOrWebp.new(request.user_agent)
jpg_or_webp.image_format
=> "jpg"
```

### Use with Active Storage

Let's say you want to pull an image variant from Active Storage based on the
current useragent's image format support. Then you can do it like this:

```ruby
book        = Book.find('666')
jpg_or_webp = JpgOrWebp.new(request.user_agent)

book_cover = book.cover_image.variant(
    resize_to_limit: [1600, nil],
    format: jpg_or_webp.image_format,
    saver: { quality: 80 }
)
=>
#<ActiveStorage::VariantWithRecord:0x00007f1b770207a8
 @blob=
  #<ActiveStorage::Blob:0x00007f1b7706dd50
   id: 12636,
   key: "7oei4398h63ry3yfsnwwbc6t9xtp",
   filename: "666.jpg",
   content_type: "image/jpeg",
   metadata: {"identified"=>true, "width"=>1500, "height"=>2100, "analyzed"=>true},
   service_name: "google",
   byte_size: 3385916,
   checksum: "lkTrv2es/VwXH7MmGJg9/w==",
   created_at: Thu, 06 Jan 2022 19:41:22.104881000 UTC +00:00>,
 @variation=#<ActiveStorage::Variation:0x00007f1b77020960 @transformations={:format=>"jpg", :resize_to_limit=>[1600, nil], :saver=>{:quality=>80}}>>
```

### Other uses

If you are not using `JpgOrWebp` in the context of a Rack application but are
able to get a useragent string from somewhere else, you can feed it manually
into JpgOrWebp like so:

```ruby
useragent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
jpg_or_webp = JpgOrWebp.new(useragent)
jpg_or_webp.image_format
=> "webp"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/aldvigdis/jpg_or_webp. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/aldvigdis/jpg_or_webp/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JpgOrWebp project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/aldavigdis/jpg_or_webp/blob/master/CODE_OF_CONDUCT.md).
