#!/usr/bin/perl -w

# genkeysyms.pl - adapted from the script in the Gtk2 perl bindings.

@dirs = map { s/-I//; $_} grep /-I/, split /\s+/, `pkg-config clutter-0.8 --cflags`;
#print join("\n", @dirs, "\n");
foreach (@dirs) {
	if (-f "$_/clutter/clutter-keysyms.h") {
		print "# generated "
		    . scalar(localtime)
		    . " from $_/clutter/clutter-keysyms.h\n";
		open IN, "$_/clutter/clutter-keysyms.h" 
			or die "can't read $_/clutter/clutter-keysyms.h: $!\n";
		print "package Clutter::Keysyms;\n";
		print "\%Clutter::Keysyms = (\n";
		while (<IN>) {
			/^#define\sCLUTTER_([^ \t]*)\s+(0x[0-9A-Fa-f]+)/ and
				print "   '$1' => $2,\n";
		}
		print ");\n";
		print "1;\n";
		$/=undef;
		print <DATA>;
		close IN;
		last;
	}
}

# below is the pod that goes in the generated file, not the pod for
# this program!
__DATA__

=head1 NAME

Clutter::Keysyms - key codes for Clutter programs

=head1 SYNOPSIS

 use Clutter;
 use Clutter::Keysyms;

 #
 # the most common use is for deciphering keycodes in key events,
 # like this:
 #
 sub key_press_handler {
         my ($widget, $event) = @_;
         if ($event->keyval == $Clutter::Keysyms{Escape}) {
                 abort_whatever ();
                 return 1;
         elsif ($event->keyval == $Clutter::Keysyms{F1}) {
                 do_help_thing ();
                 return 1;
         elsif ($event->keyval == $Clutter::Keysyms{KP_Enter}) {
                 execute_selected_text_as_command ();
                 return 1;
         }
         # we didn't handle it, pass it on...
	 return 0;
 }

=head1 DESCRIPTION

Clutter defines symbolic names for the codes associated with each key on a
keyboard, so that you don't go nuts with numeric values in your programs.
The hash C<%Clutter::Keysyms> holds all those keycodes, indexed by the
name, for use in your perl programs when you need to do custom key handling.
This commonly occurs when you want to bind an action to a key that isn't 
usable as an accelerator, or when you don't have accelerators, or if you're
trying to write an easter egg, or whatever.

As the list of keycodes is quite large and rather rarely used in application
code, we've put it in a separately-loaded module to save space.

To get a list of all available keys, either dump C<%Clutter::Keysyms>, or
look at the source of this module with C<perldoc -m Clutter::Keysyms>.

=head1 AUTHOR

This module was automatically generated by a very simple perl script
from gdk/gdkkeysyms.h.  Programs that write programs are the happiest
programs of all.

=head1 COPYRIGHT

Copyright (C) 2003 by the gtk2-perl team

Modified for the Clutter Perl bindings by Emmanuele Bassi

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Library General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Library General Public License for more
details.

You should have received a copy of the GNU Library General Public License along
with this library; if not, write to the Free Software Foundation, Inc., 59
Temple Place - Suite 330, Boston, MA  02111-1307  USA.

=head1 SEE ALSO

perl(1), Clutter(3pm)
