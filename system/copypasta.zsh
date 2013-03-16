# https://github.com/janmoesen/tilde/blob/master/.bash/commands
# Clipboard access. I created these aliases to have the same command on
# Cygwin, Linux and OS X.
if command -v pbpaste >/dev/null; then
	alias getclip='pbpaste';
	alias putclip='pbcopy';
elif command -v xclip >/dev/null; then
	alias getclip='xclip --out';
	alias putclip='xclip --in';
fi;
