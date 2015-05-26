#!/bin/perl -w
use strict;
use DBI;

open FILE, "../pgp_keystore", or die $!;
open LOG, ">>import2.log" or die $!;

#my $dbh = DBI->connect("DBI:mysql:database=sks;host=localhost",
#		"root", "", {'RaiseError' => 1});

my $pubkey = "";
my $query = "";

while (<FILE>) {
	my @key = split(':', $_);

        # Get rid of quotes
        for (@key) {
           s/'//g;
           s/\///g;
           s/\\//g;
        }
        # Guide to key format
	# 0 - record type
	# 1 - validity
	# 2 - key length
	# 3 - algorithm
	# 4 - key id
	# 5 - date created
	# 6 - expiration date
	# 7 - certificate serial number
	# 8 - owner trust
	# 9 - name/email (user id)
       	# 10 - signature class
        # 11 - parent (if subkey)
        if ($key[0] eq "pub") {
            $pubkey = $key[4];
            $query = "INSERT INTO key_store (record_type, validity, key_length, algorithm, key_id, date_creation,
               date_expire, serial_number, owner_trust, user_id, signature_class, parent) VALUES
               ( '$key[0]', '$key[1]', '$key[2]', '$key[3]', '$key[4]', '$key[5]',
                 '$key[6]', '$key[7]', '$key[8]', '$key[9]', '$key[10]', '');";
        }
        else {
            $query = "INSERT INTO key_store (record_type, validity, key_length, algorithm, key_id, date_creation,
               date_expire, serial_number, owner_trust, user_id, signature_class, parent) VALUES
               ( '$key[0]', '$key[1]', '$key[2]', '$key[3]', '$key[4]', '$key[5]',
                 '$key[6]', '$key[7]', '$key[8]', '$key[9]', '$key[10]', '$pubkey');";
        }
        print LOG $query;
#        $dbh->do($query);
}

#$dbh->disconnect();
