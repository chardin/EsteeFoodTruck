package FoodTruck::Storage::FlatFile;

use Class::Load;
use Moose;
use MooseX::ClassAttribute;
use Text::CSV_XS qw(csv);

class_has config_class => (is => 'ro', isa => 'Str', default => sub {'FoodTruck::Config'},);
has _data => (is => 'rw', isa => 'HashRef[HashRef]', lazy_build => 1,);

sub _build__data {
  my( $self ) = @_;

  my $config_class = $self->config_class;
  Class::Load::load_class( $config_class );

  my $csv_filename = $config_class->value('csv_filename')
      or die 'No CSV filename in config';

  my $ft_aoh = csv(in => $csv_filename, headers => "auto")
      or die "$csv_filename does not contain usable data";

  my %ft_data;
  foreach my $datum (@$ft_aoh) {
      die "$datum->{locationid} has a duplicate key"
          if $ft_data{$datum->{locationid}};
      foreach my $key (keys %$datum) {
          my $orig_key = $key;
          $key =~ s/ //g;
          $key =~ s/\(.*$//;
          if ($key ne $orig_key) {
              $datum->{$key} = delete $datum->{$orig_key};
          }
      }
      $ft_data{$datum->{locationid}} = $datum;
  }
  
  return {FoodTruck => \%ft_data};
}

sub search {
    my ($self, $tqble, $params) = @_;

    my %results;

  LOCATION:
    foreach my $locationid (keys %{$self->_data->{FoodTruck}}) {
        my $datum = $self->_data->{FoodTruck}{$locationid};

        foreach my $key (keys %$params) {
            next LOCATION unless $datum->{$key} eq $params->{$key};
        }

        $results{$locationid} = $datum;
    }

    return \%results;
}

sub find {
    my ($self, $table, $id_field_values) = @_;

    my $value = $self->_data->{$table};
    foreach my $field_value (@$id_field_values) {
        $value = $value->{$field_value};
    }
    
    return $value;
}

1;

=pod

=head1 NAME

FoodTruck::Storage::FlatFile - Supplies a flatfile database storage
engine

=head1 SYNOPSIS

   $self->load_class('FoodTruck::Storage::FlatFile');
   my $ft_data = FoodTruck::Storage::FlatFile->new->_data;

=head1 DESCRIPTION

This object implements methods to load data from a flatfile.  For this
implementation, the flatfile is fetched when the object instantiated
and C<_data()> is called on it.  The data are stored in memory.

=head1 PUBLIC CLASS METHODS

=head2 search

    public class
    (HashRef[FoodTruck]) search(HashRef params)

Returns a hashref of B<FoodTruck> objects whose values match those
supplied in C<params>.  Future implementations might allow more
complex searched along the lines of B<SQL::Abstract<.

=head2 find

    public class
    (Maybe[FoodTruck]) find(int locationid)

Returns either a B<FoodTruck> object with the given C<locationid> or a
null value.

=cut
