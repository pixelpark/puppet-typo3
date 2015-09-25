# = Class: typo3::safe_package
#
define typo3::safe_package ( $ensure = installed ) {

  if !defined(Package[$title]) {
    package { $title: ensure => $ensure }
  }

}
