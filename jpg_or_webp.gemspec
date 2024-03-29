# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'jpg_or_webp'
  spec.version = '0.1.1'
  spec.authors = ['Alda Vigdís Skarphéðinsdóttir']
  spec.email = ['aldavigdis@aldavigdis.is']

  spec.summary = 'Find out if we should serve JPEG or WebP images in Ruby.'
  spec.description = 'Useragent sniffing tool to choose the more appropriate image format between JPEG and WebP.'
  spec.homepage = 'https://github.com/aldavigdis/jpg_or_webp/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency  'steep', '~> 1.3'

  spec.add_development_dependency  'rake', '~> 13.0'

  spec.add_development_dependency  'rspec', '~> 3.0'

  spec.add_development_dependency  'rubocop', '~> 1.21'

  spec.add_dependency 'browser', '~> 5.3'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
