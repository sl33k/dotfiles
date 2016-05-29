#!/usr/bin/env perl
## XXX add network capabiltys
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
use IO::Handle;

# my %colors = (
#     dzen_fg   => "#AAAAAA",
#     dzen_bg   => "#000000",
#     empty_fg  => "#AAAAAA",
#     empty_bg  => "#000000",
#     unused_fg => "#AAAAAA",
#     unused_bg => "#000000",
#     viewed_fg => "#B40000",
#     viewed_bg => "#000000",
#     active_fg => "#FF0000",
#     active_bg => "#000000",
#     urgent_fg => "FF0000",
#     urgent_bg => "#FFFFFF",
#     used_fg   => "#FFFFFF",
#     used_bg   => "#000000",
# );

my %solarized = (
    base03  => "#002b36",
    base02  => "#073642",
    base01  => "#586e75",
    base00  => "#657b83",
    base0   => "#839496",
    base1   => "#93a1a1",
    base2   => "#eee8d5",
    base3   => "#fdf6e3",
    yellow  => "#b58900",
    orange  => "#cb4b16",
    red     => "#dc322f",
    magenta => "#d33682",
    violet  => "#6c71c4",
    blue    => "#268bd2",
    cyan    => "#2aa198",
    green   => "#859900",
);

my %colors = (
    dzen_fg => $solarized{base00},
    dzen_bg => $solarized{base03},

    # . the tag is empty
    empty_fg  => $solarized{base00},
    empty_bg  => $solarized{base03},
    unused_fg => $solarized{cyan},
    unused_bg => $solarized{base03},

# + the tag is viewed on the specified MONITOR, but this monitor is not focused.
# - the tag is viewed on a different MONITOR, but this monitor is not focused.
    viewed_fg => $solarized{green},
    viewed_bg => $solarized{base03},

    # # the tag is viewed on the specified MONITOR and it is focused.
    # % the tag is viewed on a different MONITOR and it is focused.
    active_fg => $solarized{red},
    active_bg => $solarized{base03},

    # ! the tag contains an urgent window
    urgent_fg => $solarized{red},
    urgent_bg => $solarized{yellow},

    # : the tag is not empty
    used_fg => $solarized{base1},
    used_bg => $solarized{base03},

    # not used
);

sub dzen_gen {
    my ($monitor) = @_;
    my $dzenstring = "";
    my $tag_status;

    # get tags from hlwm
    $tag_status = `herbstclient tag_status $monitor`;

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
        my $fg_color;
        my $bg_color;

        if ( $tag =~ /^\./ ) {
            $fg_color = $colors{empty_fg};
            $bg_color = $colors{empty_bg};
        }
        elsif ( $tag =~ /^:/ ) {
            $fg_color = $colors{used_fg};
            $bg_color = $colors{used_bg};
        }
        elsif ( $tag =~ /^\+/ || $tag =~ /^-/ ) {
            $fg_color = $colors{viewed_fg};
            $bg_color = $colors{viewed_bg};
        }
        elsif ( $tag =~ /^#/ || $tag =~ /^\%/ ) {
            $fg_color = $colors{active_fg};
            $bg_color = $colors{active_bg};
        }
        elsif ( $tag =~ /^!/ ) {
            $fg_color = $colors{urgent_fg};
            $bg_color = $colors{urgent_bg};
        }

        $color = "%{F$fg_color}%{B$bg_color}";
        my $reset_color = "%{F-}%{B-}";

        #clickable action
        $baretag = substr $tag, 1;

        my $action = "%{A:"
        . "herbstclient chain , focus_monitor $monitor , use $baretag" . ":}"
        . " " . $tag . " " . "%{A}";
        $dzenstring = $dzenstring . $color . $action . $reset_color;
    }
    return $dzenstring;
}
sub conky_gen {
    my ($in) = @_;
    my $colors = "%{F$solarized{orange}}%{B$solarized{base03}}"; 
    my $combined = $colors . $in;
    return $combined; 
}


sub run {
    my ($monitor) = @_;
    $monitor = $monitor // 0;
    my $hc_handle = new IO::Handle;
    my $conky_handle = new IO::Handle;
    open hc_bare, "-|","herbstclient --idle";
    open conky_bare, '-|', "conky -c ~/.config/herbstluftwm/conky_lemonbar";
    $hc_handle->fdopen(\*hc_bare,"r") or die "handle hlwm failed" . $!;
    $conky_handle->fdopen(\*conky_bare,"r") or die "handle conky failed";
    $hc_handle->blocking(0);
    $conky_handle->blocking(0);

    #open( my $hc, '-|', "herbstclient --idle 2>/dev/null" )
    #    or die "can't open hlwm";
    #open( my $conky, '-|', "conky -c ~/.config/herbstluftwm/conky_lemonbar 2>/dev/null" )
    #    or die "can't open conky";
    
    #this is weird. the monitors fo dzen are somehow swapped. works this way.
    my $dzen_mon = $monitor + 1;

    #
    #my $dzencmd = "lemonbar -p  -f '-*-DejaVu Sans Mono-medium-r-normal-*-24-*-*-*-*-*-*-*' | while read -r line; do eval '\$line' ;done";
    my $dzencmd = "lemonbar -p -f  'xft:DejaVu\ Sans\ Mono\ for\ Powerline:size=8' | while read -r line; do eval '\$line' ;done";

    #
    # XXX dzen command config. obj?
    open( my $dzen, "|-", $dzencmd) or die "can't open dzen $!";

    # select dzen handle and disable output buffering on that.
    my $old_fh =select $dzen;
    $| = 1;
    select $old_fh;

    my $conky_initial=" ";
#    while($conky_initial = <$conky> and not defined $conky_initial){
        # continue
#    }
    my $curr_tags = dzen_gen($monitor);
    my $curr_conky = conky_gen($conky_initial);
    my $has_update = 1;

    while (1) {
        if(!$hc_handle->eof){
            print "updating herbst \n";
            my $herbst = $hc_handle->getline;
            print "herbst_in: " . $herbst . "\n";
            if($herbst =~ /^tag/){
                $curr_tags = dzen_gen($monitor);
                $has_update = 1;
            }
            last if $herbst =~ /^reload|^quit_panel/;
        }
        if (!$conky_handle->eof) {
            print "updating conky \n";
            my $conky_in = $conky_handle->getline;
            print "conky_in: " . $conky_in . "\n";
            $curr_conky = conky_gen($conky_in);
            $has_update = 1;
        }
        if($has_update){
            print $dzen $curr_tags . $curr_conky . "\n";
            $has_update = 0;
        }

    }
    $hc_handle->close;
    $conky_handle->close;
    #close $hc;
    close $dzen;

}
run(@ARGV);

