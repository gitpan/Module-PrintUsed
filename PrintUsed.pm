package Module::PrintUsed;

use 5.006;
use strict;
use warnings;

our @ISA = qw();

our $VERSION = '0.01';

sub ModulesList {
    my @modules;
    
    foreach (sort keys %INC) {
        my $name = $_;
        $name =~ s|[\\/]|::|g;
        $name =~ s|\.pm$||;
        my $version = eval " \$$name\::VERSION " || '';
        push @modules, { name => $name, version => $version,
            path => $INC{$_} };
    }
    
    return @modules;
}

END {
    print STDERR "\nModules used by $0:\n";
    my @modules = ModulesList();
    
    foreach (@modules) {
        print STDERR" - $_->{name} ", " " x (25 - length($_->{name})),
            "$_->{version} ", " " x (8 - length($_->{version})),
            "$_->{path}\n";
    }
    print STDERR "\n";
}


1;
__END__
=head1 NAME

Module::PrintUsed - Prints modules used by your script when your script ends

=head1 SYNOPSIS

  use Module::PrintUsed;

=head1 DESCRIPTION

This module helps you to check which modules (and scripts) were C<use>d or
C<require>d during the runtime of your script. It prints the list of modules
to STDERR, including version numbers and paths.

Module::PrintUsed contains an C<END {}> block that will be executed when
your script exits (even if it died).

=head1 FUNCTIONS

You can call C<Module::PrintUsed::ModulesList> directly to get a list of
modules used together with their version numbers and paths.

=head1 SEE ALSO

A more sophisticated way of finding module dependencies without having
to execute the script is performed by L<Module::ScanDeps>.

=head1 AUTHOR

Christian Renz, E<lt>crenz@web42.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Christian Renz E<lt>crenz@web42.com<gt>. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 