#!/usr/bin/env perl
# XXX Rewrite whole panel in perl. pipe output to dzen.  # XXX Use Modules from monitoring tool.
# XXX add network capabiltys
#
#TODO: add multi monitor support
#TODO: template
#TODO: dzen
#
# rewrite from Florian Bruhin <me@the-compiler.org> tags.sh
# added some multi monitor candy
use strict;
use warnings;

use lib 'local/lib/perl5/';

#use Mail::IMAPClient;
#use IO::Handle;

my %colors = (
    dzen_fg   => "#AAAAAA",
    dzen_bg   => "#000000",
    empty_fg  => "#AAAAAA",
    empty_bg  => "#000000",
    unused_fg => "#AAAAAA",
    unused_bg => "#000000",
    viewed_fg => "#B40000",
    viewed_bg => "#000000",
    active_fg => "#FF0000",
    active_bg => "#000000",
    urgent_fg => "FF0000",
    urgent_bg => "#FFFFFF",
    used_fg   => "#FFFFFF",
    used_bg   => "#000000",
);

sub dzen_gen {
    my ($monitor) = @_;
    my $dzenstring = "";
    my $tag_status;

    # get tags from hlwm
       $tag_status= `herbstclient tag_status $monitor`;

    my @tags = split ' ', $tag_status;
    my $color;
    my $baretag;

# set the color for each tag accorgind to its state:
# man hlwm
# tag_status [MONITOR]
#
# . the tag is empty
# : the tag is not empty
# + the tag is viewed on the specified MONITOR, but this monitor is not focused.
# # the tag is viewed on the specified MONITOR and it is focused.
# - the tag is viewed on a different MONITOR, but this monitor is not focused.
# % the tag is viewed on a different MONITOR and it is focused.
# ! the tag contains an urgent window
    for my $tag (@tags) {
        $color = "";
        $color = "^fg($colors{empty_fg})^bg($colors{empty_bg})"
          if ( $tag =~ /^\./ );

        $color = "^fg($colors{used_fg})^bg($colors{used_bg})"
          if ( $tag =~ /^:/ );

        $color = "^fg($colors{viewed_fg})^bg($colors{viewed_bg})"
          if ( $tag =~ /^\+/ );

        $color = "^fg($colors{active_fg})^bg($colors{active_bg})"
          if ( $tag =~ /^#/ );

        $color = "^fg($colors{viewed_fg})^bg($colors{viewed_bg})"
          if ( $tag =~ /^-/ );

        $color = "^fg($colors{active_fg})^bg($colors{active_bg})"
          if ( $tag =~ /^\%/ );

        $color = "^fg($colors{urgent_fg})^bg($colors{urgent_bg})"
          if ( $tag =~ /^!/ );

        $baretag = substr $tag, 1;

        $dzenstring =
            $dzenstring
          . $color
          . "^ca(1,herbstclient chain , focus_monitor $monitor , use $baretag) $tag"
          . "^ca()^fg()^bg()";
    }
    return $dzenstring;
}

sub mailinfo {

    #XXX CONFIG FILE FIRST> hashed pws or someshit?
}

sub run {
    my ($monitor) = @_;
    $monitor= $monitor // 0;
    open( my $hc, '-|', "herbstclient --idle 2>/dev/null" )
      or die "can't open hlwm";

    #this is weird. the monitors fo dzen are somehow swapped. works this way.
    my $dzen_mon = $monitor + 1;
    my $dzencmd =
"| dzen2 -h 29 -fn '-*-terminus-*-*-*-*-12-*-*-*-*-*-*-*' -xs $dzen_mon -ta 1  -sa 1 -w 315 -fg '$colors{dzen_fg}' -bg '$colors{dzen_bg}' -title-name foobarbaz$dzen_mon -e 'button3='";

    # XXX dzen command config. obj?
    open( my $dzen, $dzencmd ) or die "can't open dzen";
    print $dzen dzen_gen($monitor) . "\n";

    # select dzen handle and disable output buffering on that.
    select $dzen;
    $| = 1;

    my $hook;
    while (<$hc>) {
        $hook = $_;
        if ( $hook =~ /^tag/ ) {

            print $dzen dzen_gen($monitor) . "\n";
        }
        last if $hook =~ /^reload|^quit_panel/;
    }
    close $hc;
    close $dzen;

}
run(@ARGV);

