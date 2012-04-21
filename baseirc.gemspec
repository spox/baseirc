spec = Gem::Specification.new do |s|
  s.name = 'baseirc'
  s.version = '1.0'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc', 'LICENSE']
  s.summary = 'Library for sending to an IRC server'
  s.description = s.summary
  s.author = 'spox'
  s.email = 'spox@modspox.com'
  s.files = %w(LICENSE README.rdoc Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
end
