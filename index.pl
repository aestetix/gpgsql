#!/usr/bin/perl

use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use DBI;


my $q = new CGI;

print $q->header();

if ($q->param()) {
    my $keyid =  $q->param('pgpid');
    my $dbh = DBI->connect("DBI:mysql:database=sks;host=sql.aestetix.com","sks", "sks", {'RaiseError' => 1});
    my $query = "select t2.key_id, t1.date_creation, t1.signature_class, t2.user_id from key_store as t1, key_store as t2 where t1.parent = t2.key_id and t1.key_id = '$keyid' and t2.record_type = 'pub';";
    my $sth = $dbh->prepare($query) or die $dbh->errstr;
    $sth->execute();
    print "<table cellspacing='10'><tr><td>Key ID</td><td>Date Created</td><td>Trust Level</td><td>Name</td></tr>";
    while ((my $key_id, my $date_creation, my $signature_class, my $user_id) = $sth->fetchrow_array ) {
        print "<tr><td><a href='index.pl?pgpid=$key_id'>$key_id</a></td><td>$date_creation</td><td>$signature_class</td><td>$user_id</td></tr>";
    }
    print "</table>";
    $dbh->disconnect();
}
else {

print <<EndOfHTML;
<html><head><title>See who your friends trust</title></head>
<body>
<h1>See who your friends trust:</h1>
<form method="GET" action="index.pl" name="form1">
Public Key ID:<input type="text" name="pgpid">
<input type="submit" name="Submit" value="Submit">
</form>

<a href="https://www.dropbox.com/s/lkjng7z9yji1clm/pgp_keystore.tar.gz?dl=0">Download the Keystore</a><br />
<a href="https://www.dropbox.com/s/n7om60jurd3wwln/sks.sql.tar.gz?dl=0">Download the sqldump</a>

EndOfHTML
print "</body></html>";
}
