#!./perl -T

BEGIN {
    unless (-d 'blib') {
	chdir 't' if -d 't';
	@INC = '../lib';
	require Config; import Config;
	keys %Config; # Silence warning
	if ($Config{extensions} !~ /\bList\/Util\b/) {
	    print "1..0 # Skip: List::Util was not built\n";
	    exit 0;
	}
    }
}

use lib qw(blib/lib blib/arch);
use Scalar::Util qw(tainted);
use Config;

exec $Config{'perlpath'},'-T',$0,'no' unless @ARGV;

print "1..5\n";

print "not " if tainted(1);
print "ok 1\n";

my $var = 2;

print "not " if tainted($var);
print "ok 2\n";

my $key = (keys %ENV)[0];

$var = $ENV{$key};

print "not " unless tainted($var);
print "ok 3\n";

print "not " unless tainted($ENV{$key});
print "ok 4\n";

print "not " unless tainted($ARGV[0]);
print "ok 5\n";