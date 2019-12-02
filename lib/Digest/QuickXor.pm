package Digest::QuickXor;
use parent qw|DynaLoader|;

use strict;
use warnings;
use utf8;
use v5.24;
use feature 'signatures';
no warnings 'experimental::signatures';

use Carp 'croak';

our $VERSION = '0.01';

__PACKAGE__->bootstrap($VERSION);

sub new ($class) {

  my $qx   = Digest::QuickXor::HashPtr->new();
  my $self = {_qx => $qx};

  return bless $self, $class;
}

sub add ($self, @data) {
  for (@data) {
    $self->{_qx}->add($_, length $_);
  }

  return $self;
}

sub addfile ($self, $file) {
  my $fh;
  if (ref($file) eq 'GLOB') {
    $fh = $file;
  } else {
    CORE::open $fh, '<', $file or croak qq|Can't open file "$file": $!|;
  }

  my $ret = '';
  while ($ret = $fh->sysread(my $buffer, 131072, 0)) {
    $self->add($buffer);
  }
  croak qq|Can't read from file: $!| unless defined $ret;

  return $self;
}

sub b64digest ($self) {
  my $rv = $self->{_qx}->b64digest;
  $self->reset;

  return $rv;
}

sub reset ($self) {
  $self->{_qx}->reset;

  return $self;
}

1;

=encoding utf8

=head1 NAME

Digest::QuickXor - The QuickXorHash

=head1 SYNOPSIS

    use Digest::QuickXor;

    my $qx = Digest::QuickXor->new;

    $qx->add(@data);
    $qx->b64digest;

    $qx->addfile($file);
    $qx->b64digest;

    $qx->add($wrong_data);
    $qx->reset;
    $qx->add($correct_data);

=head1 DESCRIPTION

L<Digest::QuickXor> implements the QuickXorHash.

The QuickXorHash is the digest used by Microsoft on Office 365 OneDrive for Business and Sharepoint.
It was published by Microsoft in 2016 in form of a C# script. The explanation describes it as a
"quick, simple non-cryptographic hash algorithm that works by XORing the bytes in a circular-shifting fashion".

=head1 CONSTRUCTOR

=head2 new

    $qx = Digest::QuickXor->new;

=head1 METHODS

=head2 add

    $qx = $qx->add($data);
    $qx = $qx->add(@data);

Adds new blocks of data.

=head2 addfile

    $qx = $qx->addfile($path);
    $qx = $qx->addfile($filehandle);

Adds data from a file path or from a file handle.

=head2 b64digest

    $string = $qx->b64digest;

Returns the digest and resets the object.

=head2 reset

    $qx = $qx->reset;

Resets the object so it is ready to accept new data.

=head1 AUTHOR & COPYRIGHT

© 2019 by Tekki (Rolf Stöckli).

© for the original algorithm 2016 by Microsoft.

This program is free software, you can redistribute it and/or modify it under the terms of the Artistic License version 2.0.

=head1 SEE ALSO

Explanation of the
L<QuickXorHash Algorithm|https://docs.microsoft.com/en-us/onedrive/developer/code-snippets/quickxorhash?view=odsp-graph-online>
in the OneDrive Dev Center.

L<QuickXorHash.cs|https://gist.github.com/rgregg/c07a91964300315c6c3e77f7b5b861e4>
by Ryan Gregg.

L<quickxor-c|https://github.com/Tekki/quickxor-c>, C implementation of the hash, base code for this module.

=cut
