#!/usr/local/bin/ruby
#!/usr/bin/env ruby
# Written by Torsten Becker <torsten.becker@gmail.com> in 2010


%w*rubygems date time builder*.map{|_|require _}

def make_atom_from_git_commits input_string
  project = ($*[0] or 'UnknownProject')
  
  atom = Builder::XmlMarkup.new(:indent => 2)
  atom.instruct!

  atom.feed :xmlns => 'http://www.w3.org/2005/Atom' do
    atom.title "Commit Feed#{$*[0] ? " for Project #{project}" : ''}"
    atom.id "tag:pixelshed.net,2010-03-14:git-log2atom/p/#{project}"
    atom.updated Time.now.utc.xmlschema
    
    # Split by commit
    input_string.split(/^commit\s+([a-f0-9]+)$/).
    
    # split creates to matches for each commit, the first contains the id
    # and the second the body, the inject creates for each commit a tuple
    inject([[]]) do |accu, i|
      next accu  if i.empty?

      if accu.last.empty? or accu.last.size == 1
        accu.last << i
      else
        accu << [i]
      end

      accu
    end.
    
    # For each commit tuple create a nice hash
    map do |tuple|
      result = {:commit => tuple[0]}
      
      # Try to parse the commit
      if tuple[1] =~ /Author:\s*(.+?)\s*(?:<(.+?)>)?\n^Date:\s(.+?)\n(.+)$/m
        result[:name] = $1
        result[:email] = $2
        result[:date] = $3.strip
        result[:message] = $4.strip.gsub('<', '&lt;').gsub(/\n/, "\n<br/>")
        
        # extract first line as the title
        result[:title] = $1  if result[:message] =~ /^(.+?)(?:\.|$)/
      
      # Fall back to whole message as content
      else
        result[:message] = tuple[1]
      end
      
      result
    end.
    
    # For each hash create a nice atom post
    each do |entry|
      atom.entry do
        atom.id("tag:pixelshed.net,2010-03-14:git-log2atom/p/#{project}/c/" +
            entry[:commit])
        atom.updated Time.parse(entry[:date]).utc.xmlschema  if entry[:date]
        atom.author do
          atom.name entry[:name]
          atom.email entry[:email]
        end
        atom.title entry[:title]
        atom.content entry[:message], :type => 'html'
      end
    end
  end
  
  atom.target!
    
end

if $0 == __FILE__
  puts make_atom_from_git_commits($stdin.read)
end
