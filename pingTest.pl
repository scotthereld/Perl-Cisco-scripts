#!/usr/bin/perl

#####################################################
#
# Ping a list of devices - output the devices that reply,
# ignore devices that don't. Useful if you only want to work 
# on remote devices that are pingable. This allows the output to be
# copied into a text file for use with other scripts.
#
# Usage is: Net::Ping->new('tcp') or Net::Ping->new('icmp')
# icmp may require sudo privilege.
# 
# Copyright 2012 Rowan Wilson
# http://www.rownet.co.uk
#
# Requires Net::Ping
#
# Output is: STDOUT
#
#####################################################

use strict;
use warnings;

use Net::Ping;

	my $host_file = '<filename.here>';


	open DEVICEFILE, "<", "$host_file" or die $!;

	while(my $host=<DEVICEFILE>){
		chomp $host;
		my $p = Net::Ping->new('tcp');
		
		if ($p->ping($host)) {
		print "$host\n";
		$p->close();
		} else {}
	}

	close (DEVICEFILE);

	

	