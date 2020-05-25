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
# == Author
# Tommy Muehle
#
define typo3::install::source (
  String               $version,
  Stdlib::Absolutepath $src_path,
  String               $download_url = 'get.typo3.org',
) {
  $source_file = "${version}.tar.gz"

  exec { "Get ${name}":
    command => "curl -Lk ${download_url}/${version} >${source_file}",
    cwd     => $src_path,
    onlyif  => "test ! -d typo3_src-${version}",
  }

  exec { "Untar ${name}":
    command => "tar -xzf ${source_file}",
    cwd     => $src_path,
    require => Exec["Get ${name}"],
    creates => "${src_path}/typo3_src-${version}",
  }

  exec { "Remove ${name}":
    command => "rm -f ${src_path}/${source_file}",
    cwd     => $src_path,
    require => Exec["Untar ${name}"],
    onlyif  => "test ! -f ${src_path}/${source_file}",
  }

}
