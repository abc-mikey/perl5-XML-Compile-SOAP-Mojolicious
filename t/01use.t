#!/usr/bin/env perl

use warnings;
use strict;

use lib 'lib', 't';
use Test::More tests => 4;

# The versions of the following packages are reported to help understanding
# the environment in which the tests are run.  This is certainly not a
# full list of all installed modules.
my @show_versions =
 qw/Test::More
    Test::Deep
    XML::Compile
    XML::Compile::SOAP
    XML::Compile::Cache
    XML::Compile::SOAP::Daemon
    XML::LibXML
    Log::Report
    Mojolicious
    MojoX::Log::Report
   /;

foreach my $package (@show_versions)
{   eval "require $package";

    no strict 'refs';
    my $report
      = !$@    ? "version ". (${"$package\::VERSION"} || 'unknown')
      : $@ =~ m/^Can't locate/ ? "not installed"
      : "reports error";

    warn "$package $report\n";
}

warn "libxml2 ".XML::LibXML::LIBXML_DOTTED_VERSION()."\n";

use_ok('XML::Compile::Transport::SOAPHTTP_MojoUA');
use_ok('XML::Compile::SOAP::Mojolicious');
use_ok('XML::Compile::SOAP::Daemon');
use_ok('XML::Compile::SOAP::Daemon::Mojo');
