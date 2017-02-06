# = Class: typo3::install::source
#
# == Parameters
#
# Standard class parameters
#
# [*version*]
#   TYPO3 version for project.
#   Example: '6.1.3'
#
# [*src_path*]
#   Path to source directory.
#   Example: '/var/www/typo3'
#
# [*download_url*]
#   Download URL for Typo3-Core
#   Default: 'https://get.typo3.org/'
#
# == Author
# Tommy Muehle
#
define typo3::install::source (
  $version,
  $src_path,
  $download_url = 'https://get.typo3.org',
) {

  $source_file = "${version}.tar.gz"
  $extract_file = "typo3_src-${version}"
  archive { $source_file:
    ensure       => present,
    cleanup      => true,
    extract      => true,
    extract_path => $src_path,
    path         => "${src_path}/${source_file}",
    filename     => $source_file,
    source       => "${download_url}/${version}",
    creates      => "${src_path}/${extract_file}",
  }
}
