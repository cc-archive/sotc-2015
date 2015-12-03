# List files to be made by finding all *.md files and appending .html
#REPORTS := $(patsubst %.mdwn,%.md.html,$(wildcard *.mdwn))

# The all rule makes all the HTML files listed
all :
	csplit sotc.md /---/ {*}
	for file in xx*; do mv "$$file" "$$file.mdwn"; done
	REPORTS := $(patsubst %.mdwn,%.md.html,$(wildcard *.mdwn))


# This generic rule accepts HTML targets with corresponding Markdown 
# source, and makes them using pandoc
%.md.html : %.mdwn
	pandoc --smart $< -o $@ -H header.html

# Remove all HTML outputs
clean :
	rm $(REPORTS)

# Remove all HTML outputs then build them again
rebuild : clean all
