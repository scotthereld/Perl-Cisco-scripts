#!/usr/bin/perl

#####################################################
#
# Extract IP addresses from device list e.g. /etc/hosts
# 
# Copyright 2012 Rowan Wilson
# http://www.rownet.co.uk
#
# Requires Regexp::Common qw/net/
#
# Output is STDOUT
#
#####################################################

use strict;
use warnings;
use Regexp::Common qw/net/;

if (@ARGV != 1 ) {
	print "usage: IP_Extract.pl /path/to/filename\n";
	} else {
		while (<>) {
		  print $1, "\n" if /($RE{net}{IPv4})/;
		}
	}