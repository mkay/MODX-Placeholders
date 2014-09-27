#!/bin/bash
# ####################################
# MODX Placeholders for Sublime Text
# ##################################
# Author: mk@s1.gl
# Tool: Sublime Text Editor | sublimetext.com
# Target: MODX Web Content Management System | modx.com
# 
# Installation: 
# Copy the directory "MODX Placeholders" to your "Packages" directory. ( Preferences > Browse Packages... )
#  
# Usage:
# * and TAB for a list of [[*resource_fields]]
# + and TAB for a list of [[+resource_field_placeholders]]
# - and TAB for a list of [[++system_settings]]
# % and TAB for a list of [[%lexicon_strings]]
# 
# Generate your own: (OSX / Linux)
# you can add you own placeholders by simply adding them to /src/placeholder_list.txt
# and running create.sh in /src. This will generate a new set of snippets. 
# ####################################
MKDIR=$(command -v mkdir)								# check for/locate mkdir

while read -u 10 line; do
	[[ $line = \#* ]] && continue 						# ignore lines with #comments

	basename=$( echo $line | sed 's/[^a-zA-Z0-9]//g' )

	if [[ $line == *[[++* ]] 							# System Settings
		then
		trigger="-"
		dir="system_settings"

	elif [[ $line == *[[\** ]]							# Resource Fields
		then
		trigger="*"
		dir="resource_fields"

	elif [[ $line == *[[+* ]]							# Resource Field Placeholders
		then
		trigger="+"
		dir="placeholders"

	elif [[ $line == *[[%* ]]							# Lexicon Strings
		then
		trigger="%"
		dir="lexicon_strings"

	else
		exit 1
	fi

	$MKDIR -p ../${dir}									# Create directory if it doesn't exist

	echo -e "<snippet>
	<content>
		<![CDATA[$line]]>
	</content>
	<tabTrigger>$trigger</tabTrigger>
	<description>$line</description>
</snippet>" > ../${dir}/${basename}.sublime-snippet

	unset dir

done 10<placeholder_list.txt
