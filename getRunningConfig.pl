#!/usr/bin/perl

#####################################################
#
# Get running-config from Cisco device list
# 
# Copyright 2012 Rowan Wilson
# http://www.rownet.co.uk
#
# Requires Net::Telnet::Cisco:
# http://sourceforge.net/projects/nettelnetcisco/
#
#####################################################

use strict;
use warnings;
use Net::Telnet::Cisco;


 # Variables for use in script...
 
 # it's assumed your account can enter enable mode
 # create a new $enable variable if not.

my $username = '<your username>';
my $passwd = '<your password>';
my $devicelist = "device_list.txt";

 # I decided to keep the getRunningConfig in a seperate function
 # to allow it to be integrated without too much hassle in other scripts
 # so the following function call opens the input device file, feeds it into
 # an array and loops through the array calling getRunningConfig for each 
 # device.
 #
 # That way, I can use this file as a base and tack on other stuff
 # like config changes etc...
 #
 # Output is $device.running-config.cfg
 
 
 # call function wrapper function...

openDevicesForRunningConfig ($devicelist);



 # Script Functions...

sub getRunningConfig {

	
	
	open RUNNINGCONFIG, ">", "$_[0].running-config.cfg" or die $!;

	my @output;
	my $enable = $_[2]; # use password for enable mode

	my $session = Net::Telnet::Cisco->new(Host => $_[0]);
	
	$session->login($_[1], $_[2]);

  	if ($session->enable($enable) ) {
		$session->cmd('terminal length 0');
		@output = $session->cmd('show running-config');
		print RUNNINGCONFIG "@output\n";
	} else {
		warn "Can't enable: " . $session->errmsg;
	}

	close (RUNNINGCONFIG);

	$session->close;

}

sub openDevicesForRunningConfig {

	open DEVICEFILE, "<", "$_[0]" or die $!;

	while(my $device=<DEVICEFILE>){
		chomp $device;
		getRunningConfig($device, $username, $passwd);
	}

	close (DEVICEFILE);

}




 # EOF
