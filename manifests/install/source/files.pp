# = Class: typo3::install::source::files
#
# == Parameters
#
# Standard class parameters
#
# [*version*]
#   TYPO3 version for project.
#   Example: '6.1.3'
#
# [*site_path*]
#   Path to project root.
#   Example: '/var/www/my-project'
#
# [*src_path*]
#   Path to TYPO3 sources.
#   Example: '/var/www'
#
# [*use_symlink*]
#   Set a symlink to TYPO3 source. Set to false to copy sources.
#   Default: true
#
# == Author
# Felix Nagel
#
define typo3::install::source::files (

  $version,
  $src_path,
  $site_path,
  $use_symlink = true

) {

  include typo3::params

  if str2bool($use_symlink) {
    $source_typo3 = "${src_path}/typo3_src-${version}"
    $target_typo3 = "${site_path}/typo3_src"

    file { $target_typo3:
      ensure  => link,
      target  => $source_typo3,
      force   => true,
      replace => true
    }

    $source_index_php = "${target_typo3}/index.php"
    $target_index_php = "${site_path}/index.php"
    file { $target_index_php:
      ensure  => link,
      target  => $source_index_php,
    }

    $source_typo3_core = "${target_typo3}/typo3"
    $target_typo3_core = "${site_path}/typo3"

    file { $target_typo3_core:
      ensure  => link,
      target  => $source_typo3_core,
    }

    if versioncmp($version, '6.1.99') <= 0 {
      $source_t3lib = "${target_typo3}/t3lib"
      $target_t3lib = "${site_path}/t3lib"
      file { $target_t3lib:
        ensure  => link,
        target  => $source_t3lib,
      }
    }

  } else {
    $source = "${src_path}/typo3_src-${version}"
    file { "${site_path}/index.php":
      ensure => 'present',
      source => "${source}/index.php"
    }

    file { "${site_path}/typo3":
      ensure  => 'present',
      source  => "${source}/typo3",
      recurse => true
    }

    if versioncmp($version, '6.2') == 0 {
      file { "${site_path}/t3lib":
        ensure  => 'present',
        source  => "${source}/t3lib",
        recurse => true
      }
    }
  }
}
