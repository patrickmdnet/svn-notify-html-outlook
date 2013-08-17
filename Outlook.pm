package SVN::Notify::HTML::Outlook;
use strict;
use subs;
use HTML::Entities;

use SVN::Notify::HTML::ColorDiff ();

$SVN::Notify::HTML::Outlook::VERSION = '0.01';
@SVN::Notify::HTML::Outlook::ISA = qw(SVN::Notify::HTML::ColorDiff);

=head1 Name

SVN::Notify::HTML::Outlook

=head1 Synopsis

Use F<svnnotify> in F<post-commit>:

    svnnotify --repos-path "$1" --revision "$2" -H HTML::Outlook

=head1 Description

Outlook 2007 and 2010 can't handle the way that SVN::Notify::HTML formats the metadata block with definition list tags.

See https://rt.cpan.org/Public/Bug/Display.html?id=30014 for background

=head1 Support

This module is stored in an open L<GitHub repository|http://github.com/patrickmdnet/svn-notify-html-outlook/>.

=head1 Author

Patrick McCormick <patrick@patrickmd.net>

With appreciation to David E. Wheeler <david@justatheory.com>

=head1 Copyright and License

Copyright (c) 2013 Patrick McCormick

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

# Following routine was cloned from SVN::Notify::HTML, and <table> used instead of <dd> and <dt>
sub output_metadata {
    my ($self, $out) = @_;

    print $out <<EOM;
<table style="border: 1px #006 solid; background: #369; padding: 6px; color: #fff; font-family: verdana,arial,helvetica,sans-serif; font-size: 10pt;">
<tr><th>Revision</th> <td>
EOM

    my $rev = $self->revision;
    if (my $url = $self->revision_url) {
        $url = encode_entities($url, '<>&"');
        # Make the revision number a URL.
        printf $out qq{<a href="$url">$rev</a>}, $rev;
    } else {
        # Just output the revision number.
        print $out $rev;
    }

    # Output the committer and a URL, if there is one.
    print $out "</td></tr>\n<tr><th>Author</th> <td>";
    my $user = encode_entities($self->user, '<>&"');
    if (my $url = $self->author_url) {
        $url = encode_entities($url, '<>&"');
        printf $out qq{<a href="$url">$user</a>}, $user;
    } else {
        # Just output the username
        print $out $user;
    }

    print $out (
        "</td></tr>\n",
        '<tr><th>Date</th> <td>',
        encode_entities($self->date, '<>&"'), "</td>\n",
        "</tr></table>\n\n"
    );

    return $self;
}

1;

