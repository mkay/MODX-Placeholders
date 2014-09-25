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
# 
# Generate your own: (OSX / Linux)
# you can add you own placeholders by simply adding them to /src/placeholder_list.txt
# and running create.sh. This will generate a new set of snippets. 
#
# ####################################

while read -u 10 line; do
	[[ $line = \#* ]] && continue # ignore lines with #comments

	basename=$( echo $line | sed 's/[^a-zA-Z0-9]//g' )

	if [[ $line == *[[++* ]] 	# System Settings
		then
		prefix="sys"
		trigger="-"

	elif [[ $line == *[[\** ]]	# Resource Fields
		then
		prefix="res"
		trigger="*"

	elif [[ $line == *[[+* ]]	# Resource Field Placeholders
		then
		prefix="plh"
		trigger="+"

	else
		exit 1
	fi

	echo -e "<snippet>
	<content>
		<![CDATA[$line]]>
	</content>
	<tabTrigger>$trigger</tabTrigger>
	<description>$line</description>
</snippet>
" > ../MODX\ Placeholders/${prefix}_${basename}.sublime-snippet

	unset $prefix

done 10<placeholder_list.txt
