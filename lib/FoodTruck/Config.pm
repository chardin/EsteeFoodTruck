package FoodTruck::Config;

use Moose;
use POSIX;
use YAML qw(LoadFile Load);

use MooseX::ClassAttribute;

class_has config         => ( is => 'rw', isa => 'HashRef', lazy_build => 1, );
class_has env_base       => ( is => 'ro', isa => 'Str', default => sub { 'FoodTruck' }, );
class_has config_yaml    => ( is => 'rw', isa => 'Str', default => sub { return <<END_OF_YAML;
storage_class: FlatFile
csv_filename: /Users/chardin/estee/FoodTruck/db/Mobile_Food_Facility_Permit.csv
END_OF_YAML
								       }, );
sub value {
    my( $class, $key ) = @_;
    my $env_prepend = uc($class->env_base // 'FoodTruck');
    return $ENV{$env_prepend . '_' . uc($key)} // $class->config->{$key};
}

sub _build_config {
    my ($class) = @_;

    my $user = POSIX::getlogin();
    my $env_prepend = uc $class->env_base;
    my $config_prepend = lc $env_prepend;
    my $file = $ENV{"${env_prepend}_CONFIG_FILE"};
    $file //= "$ENV{HOME}/${config_prepend}.config";

    my $config;
    if( $file && -f( $file ) ){
        $config = LoadFile( $file );
    }
    else {
        $config = Load( $class->config_yaml );
    }

    return $config;
}

sub _init {
    my ($class) = @_;
    $class->config($class->_build_config);
}

__PACKAGE__->meta->make_immutable;
1;

=pod

=head1 NAME

FoodTruck::Config - Central config file for a FoodTruck application
back end

=head1 SYNOPSIS

   use FoodTruck::Config;

   ...

   my $dsn = FoodTruck::Config->value('dsn');

=head1 DESCRIPTION

This module provides configuration values for a B<FoodTruck> backend.
It can get these values from a global list of defaults, from a
user-specific configuration file, or from the shell environment from
which it is invoked.

=head1 PUBLIC CLASS METHOD

=head2 value

   (string) value(string key)

For a given I<key>, the method will return a value in the following
order of precedence:

=over

=item From the environment

If an uppercased version of the key is set as an environment variable,
prepended with C<FOODTRUCK_>, it will return the value of that
variable.

=item From a user-specific configuration file

Failing that, if a value is set for the given key in
C<$ENV{HOME}/foodtruck.config>, it will return the value specified in that
file.  The file format is YAML.

=item From a global configuration within the module

Failing that, it will return the value specified within this module.

=back

=cut
