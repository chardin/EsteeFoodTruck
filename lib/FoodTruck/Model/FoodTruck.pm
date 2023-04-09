package FoodTruck::Model::FoodTruck;

use Moose;

extends 'FoodTruck::Model';

has locationid => (is => 'ro', isa => 'Str');
has Applicant => (is => 'ro', isa => 'Str');
has FacilityType => (is => 'ro', isa => 'Str');
has cnn => (is => 'ro', isa => 'Str');
has LocationDescription => (is => 'ro', isa => 'Str');
has Address => (is => 'ro', isa => 'Str');
has blocklot => (is => 'ro', isa => 'Str');
has block => (is => 'ro', isa => 'Str');
has lot => (is => 'ro', isa => 'Str');
has permit => (is => 'ro', isa => 'Str');
has Status => (is => 'ro', isa => 'Str');
has FoodItems => (is => 'ro', isa => 'Str');
has X => (is => 'ro', isa => 'Str');
has Y => (is => 'ro', isa => 'Str');
has Latitude => (is => 'ro', isa => 'Str');
has Longitude => (is => 'ro', isa => 'Str');
has Schedule => (is => 'ro', isa => 'Str');
has dayshours => (is => 'ro', isa => 'Str');
has NOISent => (is => 'ro', isa => 'Str');
has Approved => (is => 'ro', isa => 'Str');
has Received => (is => 'ro', isa => 'Str');
has PriorPermit => (is => 'ro', isa => 'Str');
has ExpirationDate => (is => 'ro', isa => 'Str');
has Location => (is => 'ro', isa => 'Str');
has FirePreventionDistricts => (is => 'ro', isa => 'Str');
has PoliceDistricts => (is => 'ro', isa => 'Str');
has SupervisorDistricts => (is => 'ro', isa => 'Str');
has ZipCodes => (is => 'ro', isa => 'Str');
has Neighborhoods => (is => 'ro', isa => 'Str');

__PACKAGE__->meta->make_immutable;
1;

=pod

=head1 NAME

FoodTruck::Model::FoodTruck - A food truck in the database

=head1 SYNOPSIS

    use FoodTrucl::Model::FoodTruck;

    my $ft = FoodTrucl::Model::FoodTruck->find($lid);

=head1 DESCRIPTION

This module represents a food truck in the FoodTruck application.

=cut
