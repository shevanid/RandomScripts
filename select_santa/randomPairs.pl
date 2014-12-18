#!/usr/local/bin/perl

use Getopt::Long;
use Data::Dumper;
use strict;

my ($fileName);
GetOptions(
        'i:s' => \$fileName,
);
unless($fileName) {
        print"--i file are mandatory arguments !!\n";
        exit;
}

# Read all participant names

my %participantSantaMap = ();
open FILE, $fileName;
binmode FILE, ":utf8";
while (my $line = <FILE>) {
  $line = trim($line);
  $participantSantaMap{$line} = 'unassigned';
}
close FILE;

my @participants = keys %participantSantaMap;
my $possibleSanta;
foreach my $participant( keys %participantSantaMap ) {
  print "Finding Santa for $participant ...\n";
  while (1) {
    $possibleSanta = $participants[int(rand($#participants+1))];
    print "Considering $possibleSanta ...\n";
    if ($possibleSanta ne $participant and $participantSantaMap{$possibleSanta} eq 'unassigned') {
      print "$participant will receive a secret gift from ".$possibleSanta."\n";
      $participantSantaMap{$possibleSanta} = $participant;
      last;
    }
  }
}

print Dumper(\%participantSantaMap);

sub trim {
        my $string = shift;
        $string =~ s/^\s+//;
        $string =~ s/\s+$//;
        return $string;
}
