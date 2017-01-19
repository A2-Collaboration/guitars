#!/usr/bin/perl
use strict;
use warnings;
use Digest::MD5 'md5_hex';

my $TAG = shift @ARGV || 'TheDarkness';

my %data;
while(my $line = <DATA>) {
  chomp $line;
  next if $line =~ /^\s*$/;
  my($tag, $ythash, $start, $length) = split(/\s+/,$line);
  my $wavfile = md5_hex($line).'.wav';
  $data{$tag} = [$wavfile,
                 sprintf("mpv --no-video ytdl://%s --start %s --length %s --ao=pcm --ao-pcm-file=$wavfile",
                         $ythash, $start, $length)];
}
if($TAG eq "list") {
	print "$_\n" for keys %data;
} else {
  my $wavfile = $data{$TAG}->[0];
  unless(-f $wavfile) {
    system($data{$TAG}->[1]);
  }
  system("mpv $wavfile");
}


__DATA__
DuHast 	W3q8Od5qJio	17  10
Engel 	P1p78dva8uA 20 40
TeenSpirit	hTWKbfoikeg    9  5
ChopSuey	CSvFpBOe8eY   30  5
TheDarkness tKjZuykKY1I   2:02.8 9.5
SmoothCriminal CDl9ZMfj6aE 0 8
WhiteStripes 6j7huh5Egew 0 8
DoIWannaKnow bpOSxM0rNPM 5.5 13
OpenYourEyes Gm809_rRJCo 8.5 10

