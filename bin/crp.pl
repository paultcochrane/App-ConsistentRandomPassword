#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;
use App::ConsistentRandomPassword;
use Term::ReadKey;
use Clipboard;

# try to get site from commandline
my $site = shift @ARGV;

# try to get site from firefox
unless ($site) {
    $site = App::ConsistentRandomPassword::site_from_firefox;
    if ($site) {
        say "Got site from firefox: $site";
    }
}

# ask for site
unless ($site) {
    print "site: ";
    $site = <STDIN>;
    chomp($site);
}

# get the user key
print "key: ";
ReadMode 2;
my $key = <STDIN>;
ReadMode 0;

# calc the password
my $pwd = App::ConsistentRandomPassword->new({site=>$site})->password($key);

# put it in clipboard
Clipboard->copy($pwd);
say "\nYour password for '$site' is ready to paste";

