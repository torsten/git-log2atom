# git-log2atom

git-log2atom.rb transforms the output of git-log(1) into an atom feed.  This might
be useful when you want to created a news-feed of the commits of your git
repository.

Requires rubygems, the builder gem and is tested with ruby 1.8.6


## Installation

Git user need write access to PUB_DIR.

Create .git/hooks/post-receive:

<pre>
#!/bin/sh

PUB_DIR=/var/www/public_dir
PROJECT_NAME=ProjectName

mkdir -p $SECRECT_DIR
git log --stat -n 30 | \
  ruby /var/git/scripts/git-log2atom.rb "$PROJECT_NAME" > \
  $PUB_DIR/$PROJECT_NAME.atom
</pre>
