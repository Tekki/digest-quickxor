use strict;
use warnings;
use utf8;
use v5.24;
use feature 'signatures';
no warnings 'experimental::signatures';

use FindBin;
use Test::More;

my $package;

BEGIN {
  $package = 'Digest::QuickXor';
  use_ok $package or exit;
}

note 'Object';
ok my $object = $package->new, 'Create object';

my %hashes = (
  'longer_text.txt' => 'MyNPbFMLAm5Ol0JF4iqBwtfLtf8=',
  'perl_camel.png'  => 'btGJtuvrt57YpSgEUpMJKkNQywA=',
  'perl_logo.svg'   => 't+ivKo9P9+OBdXUVle2LDwOmIzI=',
  'short_text.txt'  => 'QQDBHNDwBjnQAQR0JAMe6AAAAAA=',
);

for my $file (sort keys %hashes) {
  note $file;
  my $fh;
  my $path = "$FindBin::Bin/resources/$file";

  is $object->addfile($path)->b64digest, $hashes{$file}, "Hash for $file (path)";

  ok open($fh, '<', $path), "Handle for $file";
  is $object->addfile($fh)->b64digest, $hashes{$file}, "Hash for $file (handle)";
  close $fh;
}

done_testing();
