# Read gemlogs on the Kindle
I have been toying around with the idea of reading content from "offline" sources. This is so that I can be focused on the content instead of being distracted. One possible solution is to download content from RSS feeds to my computer's filesystem and turning off the internet. This can be easily achieved by using a RSS feed reader such as newsboat. 
 
But I want to go a step further - I would like to read content on my Kindle. Being a gemini protocol fan (and enjoying reading things on the gemini space) I decided to write a quick and dirty script that takes a gemini page as a parameter, fetches all the .gmi links and dumps the result to an EPUB so that it can be read on the Kindle. 
It seems to work fine. 

```
$ gemdir-to-epub gemini://drewdevault.com/ drewdevault
```

This will generate a file 'drewdevault.epub' containing one chapter per article.   
The script uses gemget for fetching the pages and pandoc for generating the epub from the markdown format. Some formatting may be off due to gemtext not being exactly like markdown.
Another toy project would be to store the rss feeds in a format readable by the Kindle - though I haven't done much research on how to achieve that.

Here's the script - suggestions for improvements are always welcome.

```
#!/bin/sh
# gemdir-to-epub - generate epub from a gemini directory
# dependencies: gemget, pandoc

if [ $# -ne 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	printf "Usage: gemdir-to-epub gemini://[url]/ [title]\n"
  exit 0
fi

DIR=$(printf "%s" "$1" | sed 's,gemini:\/\/,,')
TITLE="$2"

# download the initial .gmi file , extract links,  and for each link download respective .gmi file
gemget "$DIR" -o -\
	| awk '/=> /{print $2}' | awk '/.gmi/' \
	| while IFS= read -r GMI_LINK; \
do COUNTER=$((COUNTER+1)); \
	STRIPPED_LINK=$(printf "%s" "$GMI_LINK" | sed "s,gemini:\/\/,,; s,.gmi,,; s,$DIR,,");\
	gemget "gemini://$DIR/$STRIPPED_LINK.gmi" -o "$COUNTER.gmi"
done;

# generate epub based on the .gmi files
pandoc --metadata title="$TITLE" -o "$TITLE".epub -f markdown -t epub $(find -- *.gmi | sort --numeric-sort)

# remove .gmi files
rm -f -- *.gmi
```
