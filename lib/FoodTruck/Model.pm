package FoodTruck::Model;

use Class::Load qw(load_class); 
use Moose;
use MooseX::ClassAttribute;

class_has storage_engine => (is => 'ro', lazy_build => 1,);

sub _build_storage_engine {
    my ($self) = @_;

    my $engine_basename = $ENV{FOODTRUCK_STORAGE} // 'FlatFile';

    my $storage_class = "FoodTruck::Storage::${engine_basename}";
    Class::Load::load_class($storage_class);
    my $storage = $storage_class->new;
    return $storage;
}

sub id_fields { die 'id_fields must be implemented in a chuld class' }
sub table { die 'table must be implemented in a chuld class' }

sub find {
    my ($self, $locationid) = @_;

    my $id_fields = $self->id_fields;
    return $self->storage_engine->find($self->table, @$id_fields);
}

sub search {
    my ($self, $params) = @_;

    return $self->storage_engine->search($self->table, $params);
}

__PACKAGE__->meta->make_immutable;
1;

=pod

=head1 NAME

FoodTruck::Model - A base class for Model objects

=head1 SYNOPSIS

   package FoodTruck::Model::Foo;

   use Moose;

   extends 'FoodTruck::Model';

=head1 DESCRIPTION

This module is a base class for Model objects in the FoodTruck
backend.

=head1 PUBLIC CLASS METHODS

=head2 table

    public class
    (Str) table()

Returns the table associated with a given model class.  Implemented in
child classes only.

=head2 id_fields

    public class
    (ArrayRef[Str][) id_fields()

Returns the ID fields associated with a given model class.
Implemented in child classes only.

=head2 find

    public class
    (FoodTruck::Model) find(int locationid)

Uses the method in B<FoodTruck::Storage::FlatFile> to fetch the given
object.

=head2 search

    public class
    (HashRef[FoodTruck::Model]) search(HashRef params)

Uses the method in B<FoodTruck::Storage::FlatFile> to fetch matching
objects.

=cut
