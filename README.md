# NAME

Digest::QuickXor - The QuickXorHash

# SYNOPSIS

    use Digest::QuickXor;

    my $qx = Digest::QuickXor->new;

    $qx->add(@data);
    $qx->b64digest;

    $qx->addfile($file);
    $qx->b64digest;

    $qx->add($wrong_data);
    $qx->reset;
    $qx->add($correct_data);

# DESCRIPTION

[Digest::QuickXor](https://metacpan.org/pod/Digest%3A%3AQuickXor) implements the QuickXorHash.

The QuickXorHash is the digest used by Microsoft on Office 365 OneDrive for Business and Sharepoint.
It was published by Microsoft in 2016 in form of a C# script. The explanation describes it as a
"quick, simple non-cryptographic hash algorithm that works by XORing the bytes in a circular-shifting fashion".

# CONSTRUCTOR

## new

    $qx = Digest::QuickXor->new;

# METHODS

## add

    $qx = $qx->add($data);
    $qx = $qx->add(@data);

Adds new blocks of data.

## addfile

    $qx = $qx->addfile($path);
    $qx = $qx->addfile($filehandle);

Adds data from a file path or from a file handle.

## b64digest

    $string = $qx->b64digest;

Returns the digest and resets the object.

## reset

    $qx = $qx->reset;

Resets the object so it is ready to accept new data.

# AUTHOR & COPYRIGHT

© 2019 by Tekki (Rolf Stöckli).

© for the original algorithm 2016 by Microsoft.

This program is free software, you can redistribute it and/or modify it under the terms of the Artistic License version 2.0.

# SEE ALSO

Explanation of the
[QuickXorHash Algorithm](https://docs.microsoft.com/en-us/onedrive/developer/code-snippets/quickxorhash?view=odsp-graph-online)
in the OneDrive Dev Center.

[QuickXorHash.cs](https://gist.github.com/rgregg/c07a91964300315c6c3e77f7b5b861e4)
by Ryan Gregg.

[quickxor-c](https://github.com/Tekki/quickxor-c), C implementation of the hash, base code for this module.
