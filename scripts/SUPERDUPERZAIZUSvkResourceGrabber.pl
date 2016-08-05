#!/usr/bin/env perl

use strict;
use warnings;

use autodie;

#my $dir = dir(".");

#my @links = ('a','list','of','lines');
my @links;
my @titles;


my $sourceFileName = 'datasource';
open(my $sfh, '<:encoding(UTF-8)', $sourceFileName)
    or die "$!";

#---=[take titles and links from souce file]=--# 
while (my $row = <$sfh>)
{
    #if ($row =~ m%(div)(.*?)(")%gi)
    if ($row =~ m%<((input)(.*)(type)(.*)(id).*(audio)(.*)(value=\"))(.*)((,)(.*)(>))%gi)
    {
    #    my $outLine = "$2";
        push @links, $10;
    }
    if ($row =~ m%(div class)(.*)(id=\")(.*)(\"\>\s*)(.*)(\s+)(\<\/span)(.*)(span class=\"user\")(.*)(div)%gi)
    {
#        push @titles, qq("$6");
        push @titles, $6;
    }
}
close $sfh;



#---=[make download commands]=--# 
my $filename = 'downloadContent';
open(my $fh, '>:encoding(UTF-8)', $filename) or die "$!";

#foreach my $link(@links)
#{
#print $fh "wget -O name $link\n";
#}

my $max = $#titles;
if ($max < $#links)
{    $max = $#links;}
for (my $i = 0;$i <= $max; $i++)
{
    my $currentNum = $i + 1;
    if ($currentNum < 10){$currentNum = "0$currentNum";}
    if (exists $titles[$i] and defined($links[$i]))
    {    print $fh "wget -O '$currentNum $titles[$i].mp3' $links[$i]\n";}
#    {    print $fh "touch '$i - $titles[$i]'\n";}
    else
    {print "error in title='$titles[$i]' link='$links[$i]'\n";}
}


close $fh;


print "DONE\n";