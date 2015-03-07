use strict;
use warnings;
require 'common.pl';

my $version = get_version();

use Module::Build 0.28;
use lib qw{inc}; use Alien::Base::ModuleBuild;

my %module_build_args = (
  "alien_build_commands" => [
    "%c --prefix=%s",
    "make"
  ],
  "alien_inline_auto_include" => [],
  "alien_name" => "HDF4",
  "alien_repository" => {
    "host" => "www.hdfgroup.org",
    "location" => "/ftp/HDF/HDF_Current/src/",
    "pattern" => "^hdf-([\\d\\.]+)\\.tar\\.gz\$",
    "protocol" => "http"
  },
  "build_requires" => {},
  "configure_requires" => {
    "Alien::Base" => "0.005",
    "File::ShareDir" => "1.03",
  },
  "dist_abstract" => "Alien package for the HDF4 library",
  "dist_author" => [
    "Ed J <etj\@cpan.org>"
  ],
  "dist_name" => "Alien-HDF4",
  "dist_version" => $version,
  "license" => "perl",
  "module_name" => "Alien::HDF4",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Alien::Base" => "0.005",
    "File::ShareDir" => "1.03",
    "parent" => 0,
    "perl" => "5.006",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Module::Load" => 0,
    "Test::More" => 0,
    "perl" => "5.006"
  },
  meta_merge => {
    resources => {
      repository => {
        type => 'git',
        url => 'git://github.com/PDLPorters/Alien-HDF4',
        web => 'https://github.com/PDLPorters/Alien-HDF4',
      },
    },
  },
);


my %fallback_build_requires = (
  "Module::Load" => 0,
  "Test::More" => 0,
  "perl" => "5.006"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

if ( $^O eq 'MSWin32' ) {
	$module_build_args{requires}{'Alien::MSYS'} = '0';
}

my $build = Alien::Base::ModuleBuild->new(%module_build_args);

$build->create_build_script;
