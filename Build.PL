use Module::Build;
use Config;
use strict;

my $build = Module::Build->new(
    module_name        => 'SVN::Notify::HTML::Outlook',
    dist_version_from => 'Outlook.pm',
    dist_abstract => 'Outlook-compatible HTML for SVN commit notifications',
    pm_files => { 'Outlook.pm' => 'lib/SVN/Notify/HTML/Outlook.pm' },
    license            => 'perl',
    configure_requires => { 'Module::Build' => '0.2701' },
    requires           => {
        'SVN::Notify' => '2.83',
        'perl'         => 5.006,
    },
    build_requires     => {
        'Module::Build' => '0.2701',
    },
    recommends => {
        'HTML::Entities'      => 0,
    },
    meta_merge => {
        resources => {
            homepage     => 'http://github.com/patrickmdnet/svn-notify-html-outlook/',
            bugtracker   => 'http://github.com/patrickmdnet/svn-notify-html-outlook/',
            repository   => 'http://github.com/patrickmdnet/svn-notify-html-outlook/',
        }
    },
);
$build->create_build_script;

