#!/bin/sed -f
#
# Syntax Coloring (common, applied after theme-specific script)
#

# Disabled
/<style name="\(bracebad\|uuid\)"/ s,[a-z][-_a-z0-9]*={[^}]*},,g

# Editor
s,{caret-fore},{base2},g
s,{caretline-back},{base02},g
s,{selection-fore},{base2},g
s,{selection-back},{base01},g
s,{margin-fore},{base03},g
s,{margin-back},{base03},g
s,{marker-fore},{base03},g
s,{marker-back},{base01},g
s,{highlight-back},{green-high},g
s,{highlightword-back},{cyan-high},g
s,{modifiedline-back},{yellow},g
#s,{bookmarkline-back},{yellow-min},g

# General
s,{font-size},"10",g
s,{font-face},"DejaVu Sans Mono",g
s,{default-fore},{base1},g
s,{default-back},{base03},g
s,{gdefault-fore},{base02},g
s,{linenumber-fore},{line},g
s,{bracelight-fore},{red},g
s,{bracelight-back},{base02},g
#s,{bracebad-fore},{base02},g
#s,{bracebad-back},{red},g
s,{indentguide-fore},{indent},g

# Lang-C
s,{number-fore},{cyan},g
s,{character-fore},{green},g
s,{string-fore},{green},g
s,{verbatim-fore},{green},g
s,{stringeol-fore},{green},g
s,{regex-fore},{magenta},g
s,{preprocessor-fore},{b},g
#s,{uuid-fore},{violet},g
s,{operator-fore},{yellow},g
s,{identifier-fore},{base1},g
s,{globalclass-fore},{orange},g
s,{word-fore},{violet},g
s,{word2-fore},{blue},g
# Lang-C extra
s,{word3-fore},{orange},g
s,{word4-fore},{orange},g
s,{word5-fore},{red2},g

# Comments
s,{comment-fore},{comment},g
s,{commentdoc-fore},{comment},g
s,{commentdockeyword-fore},{comment},g
s,{commentdockeyworderror-back},{red},g

# Language-specific
s,{xml-number-fore},{blue},g
s,{python-word-fore},{yellow},g

# Replace multiple consecutive spaces with a single space.
s/  \+/ /g
