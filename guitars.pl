#!/usr/bin/perl
use strict;
use warnings;
use Digest::MD5 'md5_hex';

my $TAG = shift @ARGV || 'TheDarkness';

my %data;
while(my $line = <DATA>) {
  chomp $line;
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
Ramstein 	W3q8Od5qJio	16.5  5
TeenSpirit	hTWKbfoikeg    9  5
ChopSuey	CSvFpBOe8eY   30  5
TheDarkness tKjZuykKY1I   2:02.8 9.5
SmoothCriminal CDl9ZMfj6aE 0 8
WhiteStripes 6j7huh5Egew 0 8
DoIWannaKnow bpOSxM0rNPM 5.5 13
