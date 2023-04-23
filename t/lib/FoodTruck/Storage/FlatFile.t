use Test::Most;

use_ok( 'FoodTruck::Storage::FlatFile' );

my $ft_data = FoodTruck::Storage::FlatFile->new;

my $results = $ft_data->search('FoodTruck', {FacilityType => 'Push Cart'});
ok(keys %$results, 'Search returns a non-empty resultset');
foreach my $ft (values %$results) {
  is($ft->{FacilityType}, 'Push Cart', 'Returned FoodTruck is a Push Cart');
}

my $ft = $ft_data->find('FoodTruck', [ 1612654 ]);
ok($ft, 'FoodTruck 1612654 exists');

done_testing;

