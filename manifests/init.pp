class puppetpowershell (
  $environment    = $puppetpowershell::params::environment,
  $psscriptfile   = $puppetpowershell::params::psscriptfile,
  $powershellexe  = $puppetpowershell::params::powershellexe,
  $psscriptpath   = $puppetpowershell::params::psscriptpath,
  $psargs         = $puppetpowershell::params::psargs,
  $source         = $puppetpowershell::params::source,
  ) inherits puppetpowershell::params {
  
      if $osfamily == 'windows' {
            file { $psscriptfile:
                  path => $psscriptpath,
                  ensure => "file",
                  source => $source,
                  notify => Exec['psscript']
            }
            
            exec { 'psscript':
                  refreshonly => true,
                  command     => "start-process -verb runas $powershellexe -argumentlist '-file ${psscriptpath}/${psscriptfile} ${psargs}'",
                  provider    => "powershell"
            }
      }
}
