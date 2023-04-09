use Test::Most;

use_ok('FoodTruck::Model::FoodTruck');
my $fts = FoodTruck::Model::FoodTruck->search({});

foreach my $locationid (keys %$fts) {
    ok(FoodTruck::Model::FoodTruck->new(%{$fts->{$locationid}}), "FoodTruck $locationid instantiated");
}

done_testing;
