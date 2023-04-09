use File::Temp qw(tempfile);
use Test::Most;
use YAML;

my @tests =
  ( { name => 'Defaults',
      expected =>
      { storage_class => 'FlatFile',
        csv_filename => '/Users/chardin/estee/FoodTruck/db/Mobile_Food_Facility_Permit.csv', },
    },
    { name => 'Config file',
      file_to_create =>
      { storage_class => 'b',
        csv_filename => 'a', },
    },
 );

foreach my $test (@tests) {
  subtest $test->{name} => sub {
    use aliased 'FoodTruck::Config';

    my $cdata = $test->{file_to_create};
    if ($cdata) {
      $ENV{FOODTRUCK_CONFIG_FILE} = create_file($cdata);
    }
    else {
      undef $ENV{FOODTRUCK_CONFIG_FILE};
      $cdata = $test->{expected};
    }

    Config->_init;

    foreach my $key (keys %$cdata) {
      is(Config->value($key), $cdata->{$key}, "$key value is correct");
    }
  };
}

sub create_file {
  my ($cdata) = @_;

  my ($fh, $filename) = tempfile();

  print $fh Dump($cdata);
  close $fh;
  return $filename;
}

done_testing;
