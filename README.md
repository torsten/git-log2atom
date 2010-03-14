# git-log2atom

git-log2atom transforms the output of git-log(1) into a atom feed.  This might
be useful when you want to created a news-feed of the commits of your git
repository.

Requires rubygems, the builder gem and is tested with ruby 1.8.7


## Installation
<pre>
# !/bin/sh
git log --stat -n 10 | \
ruby /path/to/gen-script.rb "Project Title" > \
/var/web/.../token/project.atom
</pre>
