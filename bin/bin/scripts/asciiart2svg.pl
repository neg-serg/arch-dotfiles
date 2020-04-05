use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;

=head1
amiga ascii 2 svg

by venam
https://venam.nixers.net
https://github.com/venam
=cut

=head2
perl $0 -i <ascii> -f <fontname> -c <colors> -o <output>
-h print help
ascii: file or -
fn: name or sauce
colors: default or Xresources or custom file
=cut
=head3
A bit inspired by:
https://github.com/haliphax/ascii.js
https://ivanceras.github.io/elm-examples/elm-bot-lines/
=cut
=head3
Welcome to a horribly put together script.

TODO:  
* Add ability to change font configurations (use from SAUCE line?)
* Add ability to change the colorscheme
* Polish script
=cut

my $input_file = "-";
my $data   = "file.dat";
my $font_name = 'Topaz a600a1200a400';
my $colors = 'default';
my $output_file = 'stdout';
my $help = 0;

my %colorscheme = (
    'default_background' => '#1c1c1a',
    'black'     => '#342f28',
    'red'       => '#a36f48',
    'green'     => '#9b9630',
    'yellow'    => '#b68740',
    'cyan'      => '#8e8e72',
    'magenta'   => '#b68c7c',
    'blue'      => '#7c7b6f',
    'white'     => '#dac78b',
    'l_black'   => '#606747',
    'l_red'     => '#c8623e',
    'l_green'   => '#a0bc30',
    'l_yellow'  => '#be8136',
    'l_cyan'    => '#7e9f86',
    'l_magenta' => '#a06f6a',
    'l_blue'    => '#595D64',
    'l_white'   => '#eaddc5'
);
my %COLORS_INDEXES = (
	background => 'default_background',
	color0 => 'black',
	color1 => 'red',
	color2 => 'green',
	color3 => 'yellow',
	color4 => 'cyan',
	color5 => 'magenta',
	color6 => 'blue',
	color7 => 'white',
	color8 => 'l_black',
	color9 => 'l_red',
	color10 => 'l_green',
	color11 => 'l_yellow',
	color12 => 'l_cyan',
	color13 => 'l_magenta',
	color14 => 'l_blue',
	color15 => 'l_white'
);


GetOptions (
        "input=s"  => \$input_file,
        "font=s"   => \$font_name,
        "colors=s" => \$colors,
        "output=s" => \$output_file,
        "help" => \$help
) or die("Error in command line arguments\n");

if ($help) {
        print "perl $0 -i <ascii> -f <fontname> -c <colors> -o <output>
        ascii: file or -
        fn: name or sauce
        colors: default or Xresources or custom file (formated like Xresources)
        -h print this help
";
        exit;
}

sub extract_hex {
        my ($source) = @_;
        my $fh;
        if ($source eq '-s') {
                $fh = \*stdin;
        }
        else {
                open($fh, "<", $source) or die "$!";
        }
        while (<$fh>) {
                for my $i (keys %COLORS_INDEXES) {
                        if (/^[^\!]*$i\s*:/) {
                                chomp;
                                $_ =~ /#([\da-f]{6})/i;
                                $colorscheme{$COLORS_INDEXES{$i}} = '#'.lc($1);
                        }
                }
        }
}

if (lc($colors) eq 'xresources') {
        my $resources = "$ENV{HOME}/.Xresources";
        extract_hex($resources);
} elsif (lc($colors) ne 'default') {
        # in case we get something that isn't default => load from file
        extract_hex($colors);
}

my $fh;
if ($input_file eq '-') {
    $fh = \*STDIN;
}
else {
    open ($fh, $input_file) or die $!;
}

my $pixel_size = 12;
my @colors_index = ('black','red','green','yellow','cyan','magenta','blue','white');
my $pixel_hor_size = $pixel_size/2.3+1;
my $b_hor_size = $pixel_size/2.1+1.5;
my $pixel_ver_size = $pixel_size+1.2;
my $b_ver_size = $pixel_size+1.59;
my $start_x = $pixel_size/2.0;
my $start_y = $pixel_size+2;
my ($x,$y) = ($start_x,$start_y);
my $output = "";
my $back_output = "";
my $max_width = 0;
my $max_height = 0;
#default to black colorscheme
my $fg_color = $colorscheme{'white'};
my $bg_color = 'none';
# Possible states are:
# escape -> found the start of escape \x1b
# enter_escape -> \[
# in_escape -> anything in between
# end_escape -> character that ends the escape, anything that isn't ;
# or digit usually C or m for forwarding cursor and color respectively
my $state = "normal";
# stores everything that has been captured so far in an escape
my $state_value = "";
my $bold = 0;


for (<$fh>) {
    last if (/\x1aSAUCE/);
    $max_height++;

    my $char = $_;
    $char =~ s/\r//g;
    $char =~ s/\x1b\[\d+D//g;
    $char =~ s/\x1b\[\d+D//g;
    $char =~ s/\x1b\[A\n\x1b\[\d+C//g;
    $char =~ s/\x1a(?:.|\n)+$//g;
    $char =~ s/\x19\x00\x00.*$//g;

    my @line = split //, $char;
    my $width = 0;
    for (@line) {
        my $c = $_;
        $c =~ s/&/&amp;/g;
        $c =~ s/</&lt;/g;
        $c =~ s/>/&gt;/g;

        # change state
        if ($state eq 'enter_escape') {
            # it's the end of the parsing
            if ($c eq 'm' or $c eq 'C') {
                # reset the state to normal
                if ($c eq 'C') {
                    for (1..$state_value) {
                        $width++;
                        if ($bg_color ne 'none') {
                            $back_output .= "<rect x='$x' fill='$bg_color' y='$y' width='$b_hor_size' height='$b_ver_size'/>";
                        }
                        $x += $pixel_hor_size;
                    }
                }
                else {
                    my @cols = split /;/, $state_value;
                    my $fg_col = 'nil';
                    my $bg_col = 'nil';
                    for my $code (@cols) {
                        if ($code == 0) {
                            $fg_col = 7;
                            $bg_col = 0;
                            #$bold = 0;
                        }
                        elsif ($code == 1) {
                            $bold = 1;
                        }
                        elsif ($code == 22) {
                            $bold = 0;
                        }
                        elsif ($code >= 30 and $code <= 37) {
                            $fg_col = $code - 30;
                        }
                        elsif ($code == 39) {
                            $fg_col = 7;
                        }
                        elsif ( $code >= 40 and $code <= 47) {
                            $bg_col = $code - 40;
                        }
                        elsif ( $code == 49) {
                            $bg_col = 0;
                        }
                    }
                    unless ($fg_col eq 'nil') {
                        my $chosen_col = $colors_index[$fg_col];
                        $chosen_col = 'l_'.$chosen_col if ($bold == 1);
                        $fg_color = $colorscheme{$chosen_col};
                    }
                    unless ($bg_col eq 'nil') {
                        if ($bg_col == 0) {
                            $bg_color = 'none';
                        }
                        else {
                            my $chosen_col = $colors_index[$bg_col];
                            $chosen_col = 'l_'.$chosen_col if ($bold == 1);
                            $bg_color = $colorscheme{$chosen_col};
                        }
                    }
                }
                $state = 'normal';
                $state_value = '';
                next;
            }
            else {
                $state_value .= $c;
                next;
            }
        }
        if ($state eq 'escape') {
            if (my $a = ($c =~ /(\[)/)) {
                $state = "enter_escape";
                next;
            }
        }
        # we encounter an escape character
        if (my $a = ($c =~ /(\x1b)/)) {
            $state = "escape";
            next;
        }

        $width++;
        if ($bg_color ne 'none') {
            $back_output .= "<rect x='$x' fill='$bg_color' y='$y' width='$b_hor_size' height='$b_ver_size'/>";
        }

        $output .= "<text fill='$fg_color' x='$x' y='$y' style='font-family:$font_name;'>
    ";
        $output .= "$c";
        $output .= "</text>";
        $x += $pixel_hor_size;
    }
    $max_width = $width if ($width > $max_width);
    $output .= "\n";
    $x = $start_x;
    $y += $pixel_ver_size;
}
$max_height++;
$max_width++;

$max_height *= $pixel_ver_size;
$max_width  *= $pixel_hor_size;

$output = "<?xml version='1.0' encoding='utf-8' standalone='no'?>
<!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>

<svg
    version='1.1'
    width='$max_width'
    height='$max_height'
    style='background-color: ".$colorscheme{"default_background"}.";'
    xmlns='http://www.w3.org/2000/svg'>

<g style='font-size: ${pixel_size}px'>".$back_output ."\n".$output;


$output .=  "</g>\n"."</svg>";

if ($output_file eq 'stdout') {
        print $output;
} else {
        open(OUT, '>', $output_file) or die("couldn't write output svg");
        print OUT $output;
        close(OUT);
}

1;
