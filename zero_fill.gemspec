# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name         = 'zero_fill'
  spec.version      = '0.2.0'
  spec.authors      = ['MOBI Wireless Management', 'Steve Hodges']
  spec.email        = 'gems@mobiwm.com'
  spec.homepage     = 'https://github.com/mobi/zerofill'
  spec.summary      = 'Adds missing dates in a series of dates'
  spec.description  = 'Add missing dates from a date series, such as days in a month.'
  spec.license      = 'MIT'
  spec.required_ruby_version = '>= 1.9.3'

  spec.files        = `git ls-files`.split("\n")
  spec.test_files   = `git ls-files -- {spec}/*`.split("\n")

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~>2.14.1'
  spec.require_paths = ['lib']
end
