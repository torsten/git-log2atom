# git-log2atom

git-log2atom transforms (some variants of) the output of
[git-log(1)](http://www.kernel.org/pub/software/scm/git/docs/git-log.html)
into an [Atom feed](http://www.atomenabled.org/).

This might be useful when you want to create a news feed of the commits of
your Git repository.  The script is easily installable as Git hook.

Requires rubygems, the builder gem and is tested with ruby 1.8.6 and 1.8.7.


## Installation

In your Git repository, create <code>.git/hooks/post-receive</code>
([more on hooks](http://book.git-scm.com/5_git_hooks.html)) and make
sure it is executable, it could look something like that (adjust paths):

<pre>
#!/bin/sh

SECRECT_DIR=/var/www/public_dir/a-super-secret-token-to-protect-private-feeds
PROJECT_NAME=ProjectName

mkdir -p $SECRECT_DIR
git log --stat -n 30 | \
  ruby /var/git/scripts/git-log2atom.rb "$PROJECT_NAME" > \
  $SECRECT_DIR/$PROJECT_NAME.atom
</pre>


## License

[MIT license](http://www.opensource.org/licenses/mit-license.php),
copyright &copy; 2010 Torsten Becker <torsten.becker@gmail.com>.
