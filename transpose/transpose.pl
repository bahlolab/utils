#!/usr/bin/perl 
#===============================================================================
#
#         FILE: transpose.pl
#        USAGE: ./transpose.pl in.txt > out.txt
#  DESCRIPTION: Transposes rows to columns
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: Downloaded from Dave Tang's blog:
# http://davetang.org/muse/2014/07/26/getting-started-picard/
# https://gist.github.com/davetang/a7918eac9b030d09291a#file-transpose-pl
#       AUTHOR: Peter Diakumis, diakumis@wehi.edu.au
# ORGANIZATION: WEHI
#      VERSION: 1.0
#      CREATED: 05/08/2015 12:05:42
#     REVISION: ---
#===============================================================================
use strict;
use warnings;

my $data   = [];
my $t_data = [];

while(<>){
   chomp;
   #skip comments
   next if /^#/;
   #skip lines without anything
   next if /^$/;
   #split lines on tabs
   my @s = split(/\t/);
   #store each line, which has been split on tabs
   #in the array reference as an array reference
   push(@{$data}, \@s);
}

#loop through array reference
for my $row (@{$data}){
   #go through each array reference
   #each array element is each row of the data
   for my $col (0 .. $#{$row}){
      #each row of $t_data is an array reference
      #that is being populated with the $data columns
      push(@{$t_data->[$col]}, $row->[$col]);
   }
}

for my $row (@$t_data){
   my $line_to_print = '';
   for my $col (@{$row}){
      $line_to_print .= "$col\t";
   }
   $line_to_print =~ s/\t$//;
   print "$line_to_print\n";
}

exit(0);

