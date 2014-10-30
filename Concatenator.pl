#!/usr/bin/perl

#############################################################################
#This file is part of Concatenator.
#
#    Concatenator is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Concatenator is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Concatenator.  If not, see <http://www.gnu.org/licenses/>.
############################################################################

use Tk;

# Main Window
my $mw = new MainWindow(-title=>"Concatenator V 1.1.0");

#Application Title
$lab = $mw -> Label(-text=> " Welcome to CoBiG^2 Concatenator!\n Please choose a function from the menu. ",
                       -font=> "Arial 10 bold");
$pub1 = $mw ->Label(-text=> "Get the latest version at:", -font=> "Arial 8");
$pub2 = $mw ->Label(-text=> "http://cobig2.fc.ul.pt", -font=> "Arial 8 underline");

#Buttons
$convBUT = $mw -> Button(-text=> "Converter",
                         -command=>[\&F_N_F]);
$concBUT = $mw -> Button(-text=> "Concatenator",
                         -command=>[\&Concatenator]);


#Menu Bar
$menubar = $mw ->Menu();
$mw -> configure (-menu=>$menubar);

#Menu Buttons
$file = $menubar -> cascade(-label=>"File", -tearoff =>0);
$help = $menubar -> cascade(-label=>"Help", -tearoff =>0);

#File#
$file -> command(-label=>"FASTA-NEXUS-FASTA Converter",
               -command=> [\&F_N_F]);
$file -> command(-label=>"Matrix Concatenator",
               -command=> [\&Concatenator]);
$file -> separator;
$file -> command(-label=>"Exit the Program", -underline=>1,
               -command=> [\&Quit]);

#Help#
$help -> command(-label=>"Version History...", -command=> [\&VH]);
$help -> separator;
$help -> command(-label=>"About...", -command=>  [\&About]);

#Geometry
my $hseparator =$mw -> Label(-text=>"   ", -font=>"Arial 10");
my $hseparator2 =$mw -> Label(-text=>"   ", -font=>"Arial 10");
my $hseparator3 =$mw -> Label(-text=>"   ", -font=>"Arial 10");
my $vseparator =$mw -> Label(-text=>"   ", -font=>"Arial 10");
my $vseparator2 =$mw -> Label(-text=>"   ", -font=>"Arial 10");
$convBUT -> grid (-row=> 3, -column=>2);
$concBUT -> grid (-row=>3, -column=>4);
$lab -> grid(-row=>1, -column=>2, -columnspan=>3);
$hseparator -> grid(-row=>0, -column=>1);
$hseparator2 -> grid(-row=>4, -column=>1);
$hseparator3 -> grid(-row=>2, -column=>1);
$vseparator -> grid(-row=>0, -column=>6);
$vseparator2 -> grid(-row=>0, -column=>0);
$pub1 -> grid(-row=>5, -column=>0, -columnspan=>6);
$pub2 -> grid(-row=>6, -column=>0, -columnspan=>6);

#------------------------------------------------------------------------------#
#----------------------------------Helpers-------------------------------------#
#------------------------------------------------------------------------------#
sub Quit {
    my $answer = $mw->messageBox(-type=>yesno,
                                 -message=>"Really Exit?",
                                 -icon=>'warning', -title=>"Quitting...", -font=>"Arial 10");
    if($answer eq "Yes") {
    exit
    }
}
#------------------------------------------------------------------------------#
sub VH {
    my $readme = $mw -> Toplevel(-title=>"Help");

	     my $readmelab = $readme -> Label(-text=>"Changes Logfile",
			                             -font=>"Arial 10 bold") -> pack;
       my $txt = $readme -> Scrolled('Text', -scrollbars=>"oe", -font=>"Arial 10") -> pack;

       open README, "VH.dat" or
          $mw->messageBox(-message=>"Readme file not found. No info will be displayed...",
                          -icon=>'error', -title=>"Read Error!", -font=>"Arial 10");
          for $contents (<README>) {
                  $txt -> insert('end', $contents);
                  }
	        my $but_close = $readme -> Button(-text=>"Close",
		                    -command => sub { destroy $readme; } ) -> pack;
    }
#------------------------------------------------------------------------------#
sub ReadmeFNF {
    my $readme = $mw -> Toplevel(-title=>"Help");

	     my $readmelab = $readme -> Label(-text=>"Fasta-Nexus-Fasta Converter Help file",
			                             -font=>"Arial 10 bold") -> pack;
       my $txt = $readme -> Scrolled('Text', -scrollbars=>"oe", -font=>"Arial 10") -> pack;

       open README, "FNF.dat" or
          $mw->messageBox(-message=>"Help file not found. No info will be displayed...",
                          -icon=>'error', -title=>"Read Error!", -font=>"Arial 10");
          for $contents (<README>) {
                  $txt -> insert('end', $contents);
                  }
	        my $but_close = $readme -> Button(-text=>"Close",
		                    -command => sub { destroy $readme; } ) -> pack;
    }
#------------------------------------------------------------------------------#
sub ReadmeConcatenator {
    my $readme = $mw -> Toplevel(-title=>"Help");

	     my $readmelab = $readme -> Label(-text=>"Matrix Concatenator Help file",
			                             -font=>"Arial 10 bold") -> pack;
       my $txt = $readme -> Scrolled('Text', -scrollbars=>"oe", -font=>"Arial 10") -> pack;

       open README, "Concatenator.dat" or
          $mw->messageBox(-message=>"Help file not found. No info will be displayed...",
                          -icon=>'error', -title=>"Read Error!", -font=>"Arial 10");
          for $contents (<README>) {
                  $txt -> insert('end', $contents);
                  }
	        my $but_close = $readme -> Button(-text=>"Close",
		                    -command => sub { destroy $readme; } ) -> pack;
    }
#------------------------------------------------------------------------------#
sub About {
    $mw->messageBox(-message=>"Concatenator V 1.0.1\n     2006 - 2007\n\nFrancisco Pina Martins\nf.pinamartins\@gmail.com\n\n\                &\n\nOctavio S. Paulo\noctavio.paulo\@fc.ul.pt\n\n\"O Homem sonha e a obra nasce...\"\n-Fernando Pessoa\n",
                    -title=>"About Concatenator...", -font=>"Arial 10");
    }
#------------------------------------------------------------------------------#
#------------------------------Fasta-Nexus-Fasta-------------------------------#
#------------------------------------------------------------------------------#
sub F_N_F {
    #New Window:
    $fnf = $mw -> Toplevel(-title=>"FASTA-Nexus-FASTA Converter");

    #New Menu Entries:
    #Menu Bar
    $convmenubar = $fnf ->Menu();
    $fnf -> configure (-menu=>$convmenubar);

    $file2 = $convmenubar -> cascade(-label=>"File", -tearoff =>0);
    $help2 = $convmenubar -> cascade(-label=>"Help", -tearoff =>0);

    #New FILE#
    $file2 -> command(-label=>"Input file...",
                    -command=> [\&inputFile]);
    $file2 -> command(-label=>"Output file...",
                    -command=> [\&outlocation]);
    $file2 -> separator;
    $file2 -> command(-label=>"Exit the Program", -underline=>1,
                   -command=> [\&Quit]);

    #New HELP#
    $help2 -> command(-label=>"Help File", -command=> [\&ReadmeFNF]);
    $help2 -> separator;
    $help2 -> command(-label=>"About...", -command=>  [\&About]);

    #Buttons
    my $gobut = $fnf -> Button(-text=>"Run Conversion", -command =>[\&Run]);
    my $inbut = $fnf -> Button(-text=>"...", -command=>[\&inputFile]);
    my $outbut = $fnf -> Button(-text=>"...", -command=>[\&outlocation]);

    #File Box
    $inbox = $fnf -> Entry(-width=>80, -textvariable=>$infile);
    $outbox = $fnf -> Entry(-width=>80, -textvariable=>$outfile);

    #Labels
    $lab2 = $fnf -> Label(-text=>"FASTA to NEXUS to FASTA Converter",
                           -font=>"Arial 10 bold");
    my $inlab =$fnf -> Label(-text=>"Input File:", -font=>"Arial 10");
    my $outlab =$fnf -> Label(-text=>"Output File:", -font=>"Arial 10");
    my $hseparator =$fnf -> Label(-text=>"   ", -font=>"Arial 10");
    my $vseparator =$fnf -> Label(-text=>" ", -font=>"Arial 10");
    my $vseparator2 =$fnf -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator2 =$fnf -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator3 =$fnf -> Label(-text=>"   ", -font=>"Arial 10");

    #Geometry
    $lab2 -> grid(-row=>0, -column=>0, -columnspan=>2);
    $inbox -> grid(-row=>1, -column=>1);
    $outbox -> grid(-row=>3, -column=>1);
    $gobut -> grid(-row=>9, -column=>1);
    $inlab -> grid(-row=>1, -column=>0);
    $outlab -> grid(-row=>3, -column=>0);
    $hseparator -> grid(-row=>2, -column=>1);
    $vseparator -> grid(-row=>1, -column=>2);
    $vseparator2 -> grid(-row=>1, -column=>4);
    $hseparator2 -> grid(-row=>4, -column=>0);
    $hseparator3 -> grid(-row=>10, -column=>0);
    $inbut -> grid(-row=>1, -column=>3);
    $outbut -> grid(-row=>3, -column=>3);
}
#------------------------------------------------------------------------------#
sub inputFile {
    $infile = $fnf ->getOpenFile();
    $inbox ->delete(0,'end');
    $inbox ->insert('end',$infile);
    open (FASTA, "$infile");
        if (<FASTA> =~ /^>/) {
           $selectionlab = $fnf ->Label(-text=>"Please select the NEXUS type to convert to:",
                                       -font=>"Arial 10 bold");
           $NEXUSP = $fnf ->Radiobutton(-text=>"Interleave NEXUS (PAUP or MrBayes Format)", -value=>paup,
                                       -variable=>\$NEXUStype);
           $NEXUSN = $fnf ->Radiobutton(-text=>"Leave NEXUS (Network or TCS Format)", -value=>network,
                                       -variable=>\$NEXUStype);
           $gaplabel = $fnf ->Label(-text=>"Gap:", -font=>"Arial 10 bold");
           $gap1 = $fnf ->Radiobutton(-text=>"-", -value=>"-", -variable=>\$gap);
           $gap2 = $fnf ->Radiobutton(-text=>"~", -value=>"~", -variable=>\$gap);
           $missinglabel = $fnf ->Label(-text=>"Missing:", -font=>"Arial 10 bold");
           $missing1 = $fnf ->Radiobutton(-text=>"N", -value=>"N", -variable=>\$missing);
           $missing2 = $fnf ->Radiobutton(-text=>"?", -value=>"?", -variable=>\$missing);
           $txblock = $fnf ->Checkbutton(-text=>"Include taxa block", -variable=>\$txblk);
           $hseparator4 =$fnf -> Label(-text=>"   ", -font=>"Arial 2");
           $hseparator5 =$fnf -> Label(-text=>"   ", -font=>"Arial 2");
           $hseparator6 =$fnf -> Label(-text=>"   ", -font=>"Arial 2");
           $vseparator3 =$fnf -> Label(-text=>"   ", -font=>"Arial 2");
           $inmx = $fnf ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data);
           $datalabel = $fnf ->Label(-text=>"Data Type:", -font=>"Arial 10 bold");
           $extension = ".nex";

           $selectionlab -> grid(-row=>5, -column=>1);
           $NEXUSP -> grid(-row=>6, -column=>1);
           $NEXUSN -> grid(-row=>7, -column=>1);
           $gaplabel -> grid(-row=>5, -column=>3);
           $gap1 -> grid(-row=>6, -column=>3);
           $gap2 -> grid(-row=>7, -column=>3);
           $missinglabel -> grid(-row=>5, -column=>5);
           $missing1 -> grid(-row=>6, -column=>5);
           $missing2 -> grid(-row=>7, -column=>5);
           $txblock -> grid(-row=>8, -column=>1);
           $hseparator4 -> grid(-row=>9, -column=>0);
           $hseparator5 -> grid(-row=>1, -column=>4);
           $hseparator6 -> grid(-row=>4, -column=>4);
           $vseparator3 -> grid(-row=>1, -column=>6);
           $inmx -> grid(-row=>1, -column=>5);
           $datalabel ->grid(-row=>0, -column=>5);
           }
        elsif (($infile =~ /\.nex$/i) or ($infile eq "")) {
            $extension = ".fas";
            unless ($selectionlab eq "") {
            destroy $selectionlab;
            destroy $NEXUSP;
            destroy $NEXUSN;
            destroy $gaplabel;
            destroy $gap1;
            destroy $gap2;
            destroy $missinglabel;
            destroy $missing1;
            destroy $missing2;
            destroy $txblock;
            destroy $hseparator4;
            destroy $inmx;
            destroy $datalabel;
            }
        }
}
#------------------------------------------------------------------------------#
sub outlocation {
    $outfile = $fnf -> getSaveFile(-defaultextension=>$extension);
    $outbox ->delete(0,'end');
    $outbox ->insert('end',$outfile);
    }
#------------------------------------------------------------------------------#
sub Run {
    $outfile = $outbox -> get();
    $infile = $inbox -> get();
    unless ($outfile =~ /^.:\/.*\/.*/) {
        if ($infile =~ /^.:.*\//) {
            $path = $&;
        }
        $outfile = $path.$outfile;
    }
    open (FILE, "$infile") or
          $fnf->messageBox(-message=>"Failure reading input file:\n$infile\nReturning to main Window.",
                          -icon=>'error', -title=>"Read error!", -font=>"Arial 10") and $stop = 1;

    while ($reader = <FILE>) {   #Identifica ficheiros Nexus
        if ($reader =~ /matrix/i) {
            $identity = "Nexus";
        }
    }

    open (FILE, "$infile");
    if (<FILE> =~ /^>.*/) {
        unless (($gap eq "") or ($missing eq "")) {
            if ($NEXUStype eq "paup") {
            &fasta_to_nexus1;
            }
            elsif ($NEXUStype eq "network") {
            &fasta_to_nexus2;
            }
            elsif ($NEXUStype eq "") {
            $fnf->messageBox(-message=>"Please select a NEXUS file type to convert to.",
                             -icon=>'error', -title=>"Missing Parameter", -font=>"Arial 10");
            }

        }
        else {
            $fnf->messageBox(-message=>"Please select a gap and/or missing data type.",
                             -icon=>'error', -title=>"Missing Parameter", -font=>"Arial 10");

        }
    }
    elsif ($identity = "Nexus") {
    &nexus_to_fasta
    }
    else {$fnf->messageBox(-message=>"Invalid file type to convert.\nPlease use a Fasta or Nexus formated file to convert.\nReturning to main Window.",
                           -icon=>'error', -font=>"Arial 10") and $stop = 1;
    }

    close FILE;
}
#------------------------------------------------------------------------------#
sub fasta_to_nexus1 {    #Função que converte ficheiros fasta para ficheiros nexus utilizaveis no PAUP. Utiliza subfunções.
    open (FASTA, "$infile") or
                       $fnf->messageBox(-message=>"Failure reading input file:\n$infile\nReturning to main Window.",
                                        -icon=>'error', -title=>"Read Error!", -font=>"Arial 10") and $stop =1;
    my $a = (-1);
    for $fastalines (<FASTA>) {
        if ($fastalines =~/^>/) {
            $a++;
            $taxa[$a] = $fastalines;
        }
        else {
            unless ($fastalines =~ /^;/) {
                $seq[$a] = $seq[$a].$fastalines;
            }
        }
    }
    for $aa (0..$#taxa) {
        @space = split(/\s/, $taxa[$aa]);
        $taxa[$aa] = join("_", @space);
    }
    
    for $b (0..$#taxa) {
        if (length ($taxa[$b]) > 9) {
            $taxa[$b] = substr($taxa[$b], 1, 9);
        }
        else {
            $taxa[$b] = substr($taxa[$b], 1, (length($taxa[$b])));
        }
    }
    for $c (0..$#taxa) {
        $cc = length ($taxa[$c]);
        if ($cc < 9) {
            for $d (0..(9 - $cc)) {
                if ($d > 0) {
                    substr ($taxa[$c], 0, 0) = " ";
                }
            }
        }
    }
    chomp @taxa;
    
    for $c (0..$#seq) {
        @joined = split(/\n/, $seq[$c]);
        $seq[$c] = join (//, @joined);
    }
    @nchar = split (//, $seq[0]);
    open (NEXUS, ">$outfile") or
          $fnf->messageBox(-message=>"Could not write to output file: \"$outfile\"\n\nReturning to main Window.",
                           -title=>"Write error!", -icon=>"error", -font=>"Arial 10") and $stop = 1;
    print NEXUS "\#Nexus\n";
    print NEXUS "[", $outfile, " -- data title]\n\n";
    if ($txblk == 1) {
        print NEXUS "Begin Taxa;\n";
        print NEXUS " Dimensions Ntax=", ($#taxa + 1), ";\n";
        print NEXUS " TaxLabels\n";
        for $n (@taxa) {
            print NEXUS $n, "\n";
        }
        print NEXUS ";\n  End;\n";
    }
    print NEXUS "\nBegin data;\n dimensions ntax=", ($#taxa + 1), " nchar=", ($#nchar + 1), ";\n";
    print NEXUS " format datatype=", $data, " interleave missing=", $missing, " gap=", $gap, ";\n";
    print NEXUS "  matrix\n";

    $q = 0;
    for $p (0..($#nchar/100)) {
        for $pp (0..$#taxa) {
            print NEXUS $taxa[$pp], "  ";
            for $ppp ($q..($q + 4)) {
                print NEXUS substr($seq[$pp], ($ppp*20), 20), " ";
            }
            print NEXUS "\n";
        }
        print NEXUS "\n";
        $q = ($q + 5);
    }
    print NEXUS ";\n  end;";
    close NEXUS;
    unless ($stop == 1) {
        $fnf->messageBox(-message=>"Conversion successfull.\n\nThank you for using Concatenator.\nReturning to main Window.",
                        -title=>"Success!",
						-font=>"Arial 10");
        }
    &EndFnF;
}
#------------------------------------------------------------------------------#
sub fasta_to_nexus2 {   #Função para criar os ficheiros Nexus do tipo "Leave" (Network)
    open (FASTA, "$infile") or
                       $fnf->messageBox(-message=>"Failure reading input file:\n$infile\nReturning to main Window.",
                                        -icon=>'error', -title=>"Read Error!", -font=>"Arial 10") and $stop = 1;
    my $a = (-1);
    for $fastalines (<FASTA>) {
        if ($fastalines =~/^>/) {
            $a++;
            $taxa[$a] = $fastalines;
        }
        else {
            unless ($fastalines =~ /^;/) {
                $seq[$a] = $seq[$a].$fastalines;
            }
        }
    }
    
    for $aa (0..$#taxa) {
        @space = split(/\s/, $taxa[$aa]);
        $taxa[$aa] = join("_", @space);
    }
    for $b (0..$#taxa) {
        if (length ($taxa[$b]) > 9) {
            $taxa[$b] = substr($taxa[$b], 1, 9);
        }
        else {
            $taxa[$b] = substr($taxa[$b], 1, (length($taxa[$b])));
        }
    }
    for $c (0..$#taxa) {
        $cc = length ($taxa[$c]);
        if ($cc < 9) {
            for $d (0..(9 - $cc)) {
                if ($d > 0) {
                    substr ($taxa[$c], 0, 0) = " ";
                }
            }
        }
    }
    chomp @taxa;

    for $c (0..$#seq) {
        @joined = split(/\n/, $seq[$c]);
        $seq[$c] = join (//, @joined);
    }
    @nchar = split (//, $seq[0]);

    open (NEXUS, ">$outfile") or
          $fnf->messageBox(-message=>"Could not write to output file: \"$outfile\"\n\nReturning to main Window.",
                           -title=>"File write error", -icon=>"error", -font=>"Arial 10") and $stop =1;
    print NEXUS "\#NEXUS\n";
    if ($txblk == 1) {
        print NEXUS "BEGIN TAXA;\n";
        print NEXUS " DIMENSIONS NTAX=", ($#taxa + 1), ";\n";
        print NEXUS " TAXLABELS\n";
        for $n (@taxa) {
            print NEXUS $n, "\n";
        }
        print NEXUS ";\n  END;\n";
    }
    print NEXUS "\nBEGIN DATA;\nDIMENSIONS NTAX=", ($#taxa + 1), " NCHAR=", ($#nchar + 1), ";\n";
    print NEXUS "FORMAT DATATYPE=", $data, " MISSING=", $missing, " GAP=", $gap, ";\n";
    print NEXUS "MATRIX\n";
    for $e (0..$#taxa) {
        print NEXUS $taxa[$e], "  ", $seq[$e], "\n";
    }
    print NEXUS "  ;\nEND;";
    close NEXUS;
    
    unless ($stop == 1) {
        $fnf->messageBox(-message=>"Conversion successfull.\n\nThank you for using Concatenator.\nReturning to main Window.",
                         -title=>"Success!", -font=>"Arial 10");
    }
    &EndFnF;
                         
}
#------------------------------------------------------------------------------#
sub nexus_to_fasta {
    open (NEXUS, "$infile") or
          $fnf->messageBox(-message=>"Failure reading input file:\n$infile\nReturning to main Window.",
                          -icon=>'error', -title=>"Read error!", -font=>"Arial 10") and $stop =1;
    $a = 0;
    $b = 0;
    $c = 1;
    for $get (<NEXUS>) {
        if ($a == 1 and $c == 1 and ($get =~ /^\W*\n/ or $get =~ /W*;/)) {
        $c = 0;
        }
        if ($a == 1 and $c == 1) {
            $taxa[$b] = substr ($get, 0, 9);
            $b++;
        }
        if ($get =~ /^.*matrix/i) {
            $a = 1;
        }
    }

    open (NEXUS, "$infile");
    for $f (<NEXUS>) {
        @i = split (//, $f);
        for $g (0..$#taxa) {
            if ((substr ($f, 0, 9)) eq $taxa[$g]) {
                $seq[$g] = $seq[$g] . substr ($f, 10, ($#i + 1))
            }
        }
    @i = "";
    }
    for $j (0..$#seq) {
        @k = split (/\s/, $seq[$j]);
        $seq[$j] = join (/\*/, @k);
        @k = "";
    }
    close NEXUS;
    for $l (0..$#taxa) {
        @ll = split (/\s/, $taxa[$l]);
        $taxa[$l] = join ("", @ll);
    }

    open (FASTA, ">$outfile") or
        $fnf->messageBox(-message=>"Failure writing to output file:\n$outfile\nReturning to main Window.",
                         -icon=>'error', -title=>"Write error!", -font=>"Arial 10") and $stop =1;

    for $m (0..$#taxa) {
        $nchar = length ($seq[$m]);
        print FASTA ">", $taxa[$m], "\n";
        $nn = 0;
        for $n (0..($nchar/60)) {
            print FASTA substr($seq[$m], $nn, 60), "\n";
            $nn = $nn + 60;
        }
    }
    close FASTA;
    unless ($stop == 1) {
        $fnf->messageBox(-message=>"Conversion successfull.\n\nThank you for using Concatenator.\nReturning to main Window.",
                         -title=>"Success!", -font=>"Arial 10");
    }
    &EndFnF;
                         
}
#---------------------------------Destroy Window-------------------------------#
sub EndFnF {
    $infile = "";
    $outfile = "";
    $missing = "";
    $gap = "";
    $NEXUStype = "";
    @taxa = "";
    @seq = "";
    @space = "";
    @joined = "";
    @nchar = "";
    @ll = "";
    $stop = "";
    $path = "";
    destroy $fnf;
}

#------------------------------------------------------------------------------#
#------------------------------Concatenator------------------------------------#
#------------------------------------------------------------------------------#
sub Concatenator {
    #New Menu Entries:
    #New Window:
    $Concatw = $mw -> Toplevel(-title=>"Matrix Concatenator");

    #New Menu Entries:
    #Menu Bar
    $concatmenubar = $Concatw ->Menu();
    $Concatw -> configure (-menu=>$concatmenubar);
    $file4 = $concatmenubar -> cascade(-label=>"File", -tearoff =>0);
    $help4 = $concatmenubar -> cascade(-label=>"Help", -tearoff =>0);

    #New FILE#
    $file4 -> command(-label=>"Matrix 1...",
                      -command=> [\&inMatrix1]);
    $file4 -> command(-label=>"Matrix 2...",
                      -command=> [\&inMatrix2]);
    $file4 -> command(-label=>"Matrix 3...",
                      -command=> [\&inMatrix3], -state=>"disabled");
    $file4 -> command(-label=>"Matrix 4...",
                      -command=> [\&inMatrix4], -state=>"disabled");
    $file4 -> command(-label=>"Matrix 5...",
                      -command=> [\&inMatrix5], -state=>"disabled");
    $file4 -> command(-label=>"Output Matrix...",
                      -command=> [\&outMatrix]);
    $file4 -> separator;
    $file4 -> command(-label=>"Exit the Program", -underline=>1,
                      -command=> [\&Quit]);


    #New HELP#
    $help4 -> command(-label=>"Help File", -command=> [\&ReadmeConcatenator]);
    $help4 -> separator;
    $help4 -> command(-label=>"About...", -command=>  [\&About]);

    #Buttons
    my $joinbut = $Concatw -> Button(-text=>"Concatenate!", -font=>"Arial 10 bold",
                                     -command =>[\&Join]);
    $addbut = $Concatw -> Button(-text=>"Add one more matrix", -font=>"Arial 10 bold",
                                 -command=>[\&Mat3]);
    my $in1but = $Concatw -> Button(-text=>"...", -command=>[\&inMatrix1]);
    my $in2but = $Concatw -> Button(-text=>"...", -command=>[\&inMatrix2]);
    $in3but = $Concatw -> Button(-text=>"...", -command=>[\&inMatrix3]);
    $in4but = $Concatw -> Button(-text=>"...", -command=>[\&inMatrix4]);
    $in5but = $Concatw -> Button(-text=>"...", -command=>[\&inMatrix5]);
    my $outbut = $Concatw -> Button(-text=>"...", -command=>[\&outMatrix]);

    #File Box
    $Mat1Box = $Concatw -> Entry(-width=>80, -textvariable=>$inFile1);
    $Mat2Box = $Concatw -> Entry(-width=>80, -textvariable=>$inFile2);
    $OutBox = $Concatw -> Entry(-width=>80, -textvariable=>$outMat);

    #Radio Buttons & Checkbutton
    my $txblock = $Concatw ->Checkbutton(-text=>"Include taxa block", -variable=>\$txblk);
    
    my $PAUPconc = $Concatw ->Radiobutton(-text=>"PAUP ready concatenated matrix", -value=>paup,
                                     -variable=>\$conctype);
    my $MrBayesconc = $Concatw ->Radiobutton(-text=>"MrBayes ready concatenated matrix", -value=>mrbayes,
                                        -variable=>\$conctype);
    my $gap1 = $Concatw ->Radiobutton(-text=>"-", -value=>"-", -variable=>\$gap);
    my $gap2 = $Concatw ->Radiobutton(-text=>"~", -value=>"~", -variable=>\$gap);
    my $missing1 = $Concatw ->Radiobutton(-text=>"N", -value=>"N", -variable=>\$missing);
    my $missing2 = $Concatw ->Radiobutton(-text=>"?", -value=>"?", -variable=>\$missing);
    my $ILDcommand = $Concatw ->Checkbutton(-text=>"Include \"exclude\" command for ILD partition test", -variable=>\$ILD);
    
    #Option Menus
    my $mx1 = $Concatw ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data1);
    my $mx2 = $Concatw ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data2);

    #Labels
    $lab = $Concatw -> Label(-text=>"Matrix Concatenator\nInputs must be on NEXUS format.\nUp to a maximum of five matrices can be joined.",
                           -font=>"Arial 10 bold");
    my $in1lab =$Concatw -> Label(-text=>"Matrix 1:", -font=>"Arial 10");
    my $in2lab =$Concatw -> Label(-text=>"Matrix 2:", -font=>"Arial 10");
    my $outlab =$Concatw -> Label(-text=>"Output Matrix:", -font=>"Arial 10");
    my $hseparator =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $vseparator =$Concatw -> Label(-text=>" ", -font=>"Arial 10");
    my $vseparator2 =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator2 =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator3 =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator4 =$Concatw -> Label(-text=>"   ", -font=>"Arial 2");
    my $hseparator5 =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator7 =$Concatw -> Label(-text=>"   ", -font=>"Arial 10");
    my $hseparator6 =$Concatw -> Label(-text=>"   ", -font=>"Arial 2");
    my $typelab = $Concatw -> Label(-text=>"Concatenation type:", -font=>"Arial 10 bold");
    my $gaplabel = $Concatw ->Label(-text=>"Gap character:", -font=>"Arial 10 bold");
    my $missinglabel = $Concatw ->Label(-text=>"\"Missing\" character:", -font=>"Arial 10 bold");
    my $datalabel = $Concatw ->Label(-text=>"Data Type:", -font=>"Arial 10 bold");

    #Geometry
    $lab -> grid(-row=>0, -column=>1, -columnspan=>4);
    $Mat1Box -> grid(-row=>1, -column=>1, -columnspan=>4);
    $Mat2Box -> grid(-row=>2, -column=>1, -columnspan=>4);
    $OutBox -> grid(-row=>7, -column=>1, -columnspan=>4);
    $joinbut -> grid(-row=>16, -column=>1, -columnspan=>4);
    $in1lab -> grid(-row=>1, -column=>0);
    $in2lab -> grid(-row=>2, -column=>0);
    $outlab -> grid(-row=>7, -column=>0);
    $vseparator -> grid(-row=>1, -column=>5);
    $vseparator2 -> grid(-row=>1, -column=>7);
    $hseparator2 -> grid(-row=>8, -column=>0);
    $hseparator4 -> grid(-row=>15, -column=>1);
    $hseparator5 -> grid(-row=>17, -column=>1);
    $hseparator6 -> grid(-row=>12, -column=>1);
    $hseparator7 -> grid(-row=>2, -column=>9);
    $typelab -> grid(-row=>9, -column=>0, -columnspan=>2);
    $PAUPconc -> grid(-row=>10, -column=>0, -columnspan=>2);
    $MrBayesconc -> grid(-row=>11, -column=>0, -columnspan=>2);
    $addbut -> grid(-row=>6, -column=>0);
    $gaplabel -> grid(-row=>9, -column=>3);
    $missinglabel -> grid(-row=>9, -column=>4);
    $gap1 -> grid(-row=>10, -column=>3);
    $gap2 -> grid(-row=>11, -column=>3);
    $missing1 -> grid(-row=>10, -column=>4);
    $missing2 -> grid(-row=>11, -column=>4);
    $txblock -> grid (-row=>13, -column=>1, -columnspan=>4);
    $datalabel -> grid (-row=>0, -column=>8);
    $mx1 -> grid (-row=>1, -column=>8);
    $mx2 -> grid (-row=>2, -column=>8);
    $in1but -> grid (-row=>1, -column=>6);
    $in2but -> grid (-row=>2, -column=>6);
    $outbut -> grid (-row=>7, -column=>6);
    $ILDcommand -> grid (-row=>14, -column=>1, -columnspan=>4);
}
#------------------------------------------------------------------------------#
sub inMatrix1 {
    $infile1 = $Concatw ->getOpenFile();
    $Mat1Box ->delete(0, 'end');
    $Mat1Box ->insert('end', $infile1);
    }
#------------------------------------------------------------------------------#
sub inMatrix2 {
    $infile2 = $Concatw ->getOpenFile();
    $Mat2Box ->delete(0, 'end');
    $Mat2Box ->insert('end', $infile2);
    }
#------------------------------------------------------------------------------#
sub inMatrix3 {
    $infile3 = $Concatw ->getOpenFile();
    $Mat3Box ->delete(0, 'end');
    $Mat3Box ->insert('end', $infile3);
    }
#------------------------------------------------------------------------------#
sub inMatrix4 {
    $infile4 = $Concatw ->getOpenFile();
    $Mat4Box ->delete(0, 'end');
    $Mat4Box ->insert('end', $infile4);
    }
#------------------------------------------------------------------------------#
sub inMatrix5 {
    $infile5 = $Concatw ->getOpenFile();
    $Mat5Box ->delete(0, 'end');
    $Mat5Box ->insert('end', $infile5);
    }
#------------------------------------------------------------------------------#
sub outMatrix {
    $outMat = $Concatw ->getSaveFile(-defaultextension=>".nex");
    $OutBox ->delete(0, 'end');
    $OutBox ->insert('end', $outMat);
}
#------------------------------------------------------------------------------#
sub Mat3 {
    destroy $addbut;
    $Mat3Box = $Concatw -> Entry(-width=>80, -textvariable=>$inFile3);
    $addbut = $Concatw -> Button(-text=>"Add one more matrix", -font=>"Arial 10 bold",
                            -command=>[\&Mat4]);
    my $in3lab =$Concatw -> Label(-text=>"Matrix 3:", -font=>"Arial 10");
    my $mx3 = $Concatw ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data3);
    $matrices = 3;
    $concatmenubar -> delete(1, 2);
    $file4 = $concatmenubar -> cascade(-label=>"File", -tearoff =>0);
    $help4 = $concatmenubar -> cascade(-label=>"Help", -tearoff =>0);
    #New FILE#
    $file4 -> command(-label=>"Matrix 1...",
                      -command=> [\&inMatrix1]);
    $file4 -> command(-label=>"Matrix 2...",
                      -command=> [\&inMatrix2]);
    $file4 -> command(-label=>"Matrix 3...",
                      -command=> [\&inMatrix3]);
    $file4 -> command(-label=>"Matrix 4...",
                      -command=> [\&inMatrix4], -state=>"disabled");
    $file4 -> command(-label=>"Matrix 5...",
                      -command=> [\&inMatrix5], -state=>"disabled");
    $file4 -> command(-label=>"Output Matrix...",
                      -command=> [\&outMatrix]);
    $file4 -> separator;
    $file4 -> command(-label=>"Exit the Program", -underline=>1,
                      -command=> [\&Quit]);


    #New HELP#
    $help4 -> command(-label=>"Help File", -command=> [\&ReadmeConcatenator]);
    $help4 -> separator;
    $help4 -> command(-label=>"About...", -command=>  [\&About]);

    #Geometry
    $Mat3Box -> grid(-row=>3, -column=>1, -columnspan=>4);
    $in3lab -> grid(-row=>3, -column=>0);
    $addbut -> grid(-row=>6, -column=>0);
    $mx3 -> grid(-row=>3, -column=>8);
    $in3but -> grid (-row=>3, -column=>6);
    }
#------------------------------------------------------------------------------#
sub Mat4 {
    $Mat4Box = $Concatw -> Entry(-width=>80, -textvariable=>$inFile4);
    $addbut = $Concatw -> Button(-text=>"Add one more matrix", -font=>"Arial 10 bold",
                                 -command=>[\&Mat5]);
    my $in4lab =$Concatw -> Label(-text=>"Matrix 4:", -font=>"Arial 10");
    my $mx4 = $Concatw ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data4);
    $matrices = 4;
    $concatmenubar -> delete(1, 2);
    $file4 = $concatmenubar -> cascade(-label=>"File", -tearoff =>0);
    $help4 = $concatmenubar -> cascade(-label=>"Help", -tearoff =>0);
    #New FILE#
    $file4 -> command(-label=>"Matrix 1...",
                      -command=> [\&inMatrix1]);
    $file4 -> command(-label=>"Matrix 2...",
                      -command=> [\&inMatrix2]);
    $file4 -> command(-label=>"Matrix 3...",
                      -command=> [\&inMatrix3]);
    $file4 -> command(-label=>"Matrix 4...",
                      -command=> [\&inMatrix4]);
    $file4 -> command(-label=>"Matrix 5...",
                      -command=> [\&inMatrix5], -state=>"disabled");
    $file4 -> command(-label=>"Output Matrix...",
                      -command=> [\&outMatrix]);
    $file4 -> separator;
    $file4 -> command(-label=>"Exit the Program", -underline=>1,
                      -command=> [\&Quit]);


    #New HELP#
    $help4 -> command(-label=>"Help File", -command=> [\&ReadmeConcatenator]);
    $help4 -> separator;
    $help4 -> command(-label=>"About...", -command=>  [\&About]);

    #Geometry
    $Mat4Box -> grid(-row=>4, -column=>1, -columnspan=>4);
    $in4lab -> grid(-row=>4, -column=>0);
    $addbut -> grid(-row=>6, -column=>0);
    $mx4 -> grid(-row=>4, -column=>8);
    $in4but -> grid (-row=>4, -column=>6);
    }
#------------------------------------------------------------------------------#
sub Mat5 {
    $Mat5Box = $Concatw -> Entry(-width=>80, -textvariable=>$inFile5);
    $addbut = $Concatw -> Button(-text=>"Add one more matrix", -font=>"Arial 10 bold",
                            -command=>[\&NoMore]);
    my $in5lab =$Concatw -> Label(-text=>"Matrix 5:", -font=>"Arial 10");
    my $mx5 = $Concatw ->Optionmenu(options=>[qw(DNA RNA Nucleotide Protein)], -variable=>\$data5);
    $matrices = 5;
    $concatmenubar -> delete(1, 2);
    $file4 = $concatmenubar -> cascade(-label=>"File", -tearoff =>0);
    $help4 = $concatmenubar -> cascade(-label=>"Help", -tearoff =>0);
    #New FILE#
    $file4 -> command(-label=>"Matrix 1...",
                      -command=> [\&inMatrix1]);
    $file4 -> command(-label=>"Matrix 2...",
                      -command=> [\&inMatrix2]);
    $file4 -> command(-label=>"Matrix 3...",
                      -command=> [\&inMatrix3]);
    $file4 -> command(-label=>"Matrix 4...",
                      -command=> [\&inMatrix4]);
    $file4 -> command(-label=>"Matrix 5...",
                      -command=> [\&inMatrix5]);
    $file4 -> command(-label=>"Output Matrix...",
                      -command=> [\&outMatrix]);
    $file4 -> separator;
    $file4 -> command(-label=>"Exit the Program", -underline=>1,
                      -command=> [\&Quit]);


    #New HELP#
    $help4 -> command(-label=>"Help File", -command=> [\&ReadmeConcatenator]);
    $help4 -> separator;
    $help4 -> command(-label=>"About...", -command=>  [\&About]);

    #Geometry
    $Mat5Box -> grid(-row=>5, -column=>1, -columnspan=>4);
    $in5lab -> grid(-row=>5, -column=>0);
    $addbut -> grid(-row=>6, -column=>0);
    $mx5 -> grid(-row=>5, -column=>8);
    $in5but -> grid (-row=>5, -column=>6);
    }
#------------------------------------------------------------------------------#
sub NoMore {
    $Concatw->messageBox(-message=>"A maximum of five matrices can be concatenated with this method... Sorry...",
                         -icon=>'info', -title=>"Reached limit", -font=>"Arial 10");
    }
#------------------------------------------------------------------------------#
sub Join {
    $outMat = $OutBox -> get();
    $infile1 = $Mat1Box -> get();
    unless ($outMat =~ /^.:\/.*\/.*/) {
        if ($infile1 =~ /^.:.*\//) {
            $path = $&;
        }
        $outMat = $path.$outMat;
    }
    if ($ILD == 1) {
        substr ($outMat, -4, 0) = "ILD";
    }
    if ($gap eq "") {
        $Concatw->messageBox(-message=>"Please select a gap character...",
                             -icon=>'error', -title=>"Missing parameter", -font=>"Arial 10");
        }
    else {$gaps = 1;}
    
    if ($missing eq "") {
        $Concatw->messageBox(-message=>"Please select a \"Missing\" character...",
                             -icon=>'error', -title=>"Missing parameter", -font=>"Arial 10");
        }
    else {$missings = 1;}
    
    if ($conctype eq "") {
        $Concatw->messageBox(-message=>"Please select an output concatenated matrix type to convert to...",
                             -icon=>'error', -title=>"Missing parameter", -font=>"Arial 10");
        }
     elsif ($conctype eq "paup" and $gaps == 1 and $missings == 1)  {
        &paupconcat
        }
     elsif ($conctype eq "mrbayes" and $gaps == 1 and $missings == 1) {
        &mrbayesconcat
        }
     unless ($conctype eq "" or $gaps eq "" or $missings eq "" or $stop == 1) {
        $Concatw->messageBox(-message=>"Concatenation successfull.\n\nThank you for using Concatenator.\nReturning to main Window.",
                             -title=>"Success!", -font=>"Arial 10");
        }
      $stop = "";
      &EndConcat;
}
#------------------------------------------------------------------------------#
sub paupconcat {
    &MatTest;
    if ($data1 eq $data2) {
        $type = $data1;
    }
    else { $type = "Mixed"}
    
    unless ($type eq "Mixed") {
        if ($matrices > 2) {
            unless ($type eq $data3) {
                $type = "Mixed";
            }
        }
        if ($matrices > 3) {
            unless ($type eq $data4) {
                $type = "Mixed";
            }
        }
        if ($matrices > 4) {
            unless ($type eq $data5) {
                $type = "Mixed";
            }
        }
    }
    
    @nchar = split (//, $SeqC[0]);
    open (CONCAT, ">$outMat") or
          $Concatw->messageBox(-message=>"Could not write to output file: \"$outMat\"\n\nReturning to main Window.",
                               -title=>"Write error!", -icon=>"error", -font=>"Arial 10") and $stop = 1;
    print CONCAT "\#Nexus\n";
    print CONCAT "[", $outMat, " -- data title]\n\n";
    if ($txblk == 1) {
        print CONCAT "Begin Taxa;\n";
        print CONCAT " Dimensions Ntax=", ($#FullTaxa + 1), ";\n";
        print CONCAT " TaxLabels\n";
        for $n (@FullTaxa) {
            print CONCAT $n, "\n";
        }
        print CONCAT ";\n  End;\n\n";
    }
    print CONCAT "\nBegin data;\n dimensions ntax=", ($#FullTaxa + 1), " nchar=", ($#nchar + 1), ";\n";
    print CONCAT " format datatype=", $type, " interleave missing=", $missing, " gap=", $gap, ";\n";
    print CONCAT "  matrix\n";

    $q = 0;
    for $p (0..($#nchar/100)) {
        for $pp (0..$#FullTaxa) {
            print CONCAT $FullTaxa[$pp], "  ";
            for $ppp ($q..($q + 4)) {
                print CONCAT substr($SeqC[$pp], ($ppp*20), 20), " ";
            }
            print CONCAT "\n";
        }
        print CONCAT "\n";
        $q = ($q + 5);
    }
    print CONCAT ";\n  end;";
    print CONCAT "\n\ncharpartition ILD = Frag1:1-", ($#char1 + 1), ", Frag2:", ($#char1 + 2), "-", ($#char1 + $#char2 +2);
    if ($matrices > 2) {
        print CONCAT ", Frag3:", ($#char1 + $#char2 +3), "-", ($#char1 + $#char2 + $#char3 +3);
    }
    if ($matrices > 3) {
        print CONCAT ", Frag4:", ($#char1 + $#char2 + $#char3 +4), "-", ($#char1 + $#char2 + $#char3 + $#char4 +4);
    }
    if ($matrices > 4) {
        print CONCAT ", Frag5:", ($#char1 + $#char2 + $#char3 + $#char4 +5), "-", ($#char1 + $#char2 + $#char3 + $#char4 + $#char5 +5);
    }
    print CONCAT ";";
    if ($ILD == 1) {
        print CONCAT "\nexclude constant;\n";

    }
    close CONCAT;

}
#------------------------------------------------------------------------------#
sub mrbayesconcat {
    &MatTest;

    open (CONCAT, ">$outMat") or
          $Concatw->messageBox(-message=>"Could not write to output file: \"$outMat\"\n\nReturning to main Window.",
                               -title=>"Write error!", -icon=>"error", -font=>"Arial 10") and $stop = 1;
    print CONCAT "\#Nexus\n";
    print CONCAT "[", $outMat, " -- data title]\n\n";
    if ($txblk == 1) {
        print CONCAT "Begin Taxa;\n";
        print CONCAT " Dimensions Ntax=", ($#FullTaxa + 1), ";\n";
        print CONCAT " TaxLabels\n";
        for $n (@FullTaxa) {
            print CONCAT $n, "\n";
        }
        print CONCAT ";\n  End;\n\n";
    }
    print CONCAT "Begin data;\n";
    print CONCAT " dimensions ntax=", ($#FullTaxa + 1), " nchar=", ($#nchar + 1), ";\n";
    print CONCAT " format datatype=mixed (", $data1, ":1-", ($#char1 + 1), ",", $data2, ":", ($#char1 + 2), "-", ($#char1 + $#char2 +2);
    if ($matrices > 2) {
        print CONCAT ",", $data3, ":", ($#char1 + $#char2 +3), "-", ($#char1 + $#char2 + $#char3 +3);
    }
    if ($matrices > 3) {
        print CONCAT ",", $data4, ":", ($#char1 + $#char2 + $#char3 +4), "-", ($#char1 + $#char2 + $#char3 + $#char4 +4);
    }
    if ($matrices > 4) {
        print CONCAT ",", $data5, ":", ($#char1 + $#char2 + $#char3 + $#char4 +5), "-", ($#char1 + $#char2 + $#char3 + $#char4 + $#char5 +5);
    }
    print CONCAT ") interleave gap=", $gap, "missing=", $missing, ";\n";
    print CONCAT "  matrix\n";

    $q = 0;
    for $p (0..($#nchar/100)) {
        for $pp (0..$#FullTaxa) {
            print CONCAT $FullTaxa[$pp], "  ";
            for $ppp ($q..($q + 4)) {
                print CONCAT substr($SeqC[$pp], ($ppp*20), 20), " ";
            }
            print CONCAT "\n";
        }
        print CONCAT "\n";
        $q = ($q + 5);
    }
    print CONCAT ";\n  end;";
    close CONCAT;
}
#------------------------------------------------------------------------------#
sub MatTest {
    #Matrix1
    
    open (MATRIX1, "$infile1") or
        $Concatw->messageBox(-message=>"Unable to open Matrix 1 input file:\n$infile1",
                             -icon=>"error", -title=>"Read error!", -font=>"Arial 10");
    $d1 = 0;
    while ($check1 = <MATRIX1>) {
          if ($check1 =~ /^\s*matrix/i) {
              $d1 = 1;
          }
    }
    close MATRIX1;
    
    #Matrix2
    
    open (MATRIX2, "$infile2") or
        $Concatw->messageBox(-message=>"Unable to open Matrix 2 input file:\n$infile2",
                             -icon=>"error", -title=>"Read error!", -font=>"Arial 10");
    $d2 = 0;
    while ($check2 = <MATRIX2>) {
          if ($check2 =~ /^\s*matrix/i) {
              $d2 = 1;
          }
    }
    close MATRIX2;
    
    #Matrix3
    
    if ($matrices > 2) {
        open (MATRIX3, "$infile3") or
            $Concatw->messageBox(-message=>"Unable to open Matrix 3 input file:\n$infile3",
                                 -icon=>"error", -title=>"Read error!", -font=>"Arial 10");
        $d3 = 0;
        while ($check3 = <MATRIX3>) {
              if ($check3 =~ /^\s*matrix/i) {
                  $d3 = 1;
              }
        }
    close MATRIX3;
    }
    
    #Matrix4
    
    if ($matrices > 3) {
        open (MATRIX4, "$infile4") or
            $Concatw->messageBox(-message=>"Unable to open Matrix 4 input file:\n$infile4",
                                 -icon=>"error", -title=>"Read error!", -font=>"Arial 10");
        $d4 = 0;
        while ($check4 = <MATRIX4>) {
              if ($check4 =~ /^\s*matrix/i) {
                  $d4 = 1;
              }
        }
    close MATRIX4;
    }
     
    #Matrix5

    if ($matrices > 4) {
        open (MATRIX5, "$infile5") or
            $Concatw->messageBox(-message=>"Unable to open Matrix 5 input file:\n$infile5",
                                 -icon=>"error", -title=>"Read error!", -font=>"Arial 10");
        $d5 = 0;
        while ($check5 = <MATRIX5>) {
              if ($check5 =~ /^\s*matrix/i) {
                  $d5 = 1;
              }
        }
     close MATRIX5;
     }

    #What's Wrong?
    
    if ($d1 == 0) {
        $Concatw->messageBox(-message=>"Matrix 1 is not a conveniently formated NEXUS file.\nPPlease choose another file or correct the selected file...",
                             -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10");
        &inMatrix1;
    }
    if ($d2 == 0) {
        $Concatw->messageBox(-message=>"Matrix 2 is not a conveniently formated NEXUS file.\nPlease choose another file or correct the selected file...",
                             -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10");
        &inMatrix2;
    }
    if ($matrices > 2) {
    if ($d3 == 0) {
        $Concatw->messageBox(-message=>"Matrix 3 is not a conveniently formated NEXUS file.\nPlease choose another file or correct the selected file...",
                             -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10");
        &inMatrix3;
    }
    }
    if ($matrices > 3) {
    if ($d4 == 0) {
        $Concatw->messageBox(-message=>"Matrix 4 is not a conveniently formated NEXUS file.\nPlease choose another file or correct the selected file...",
                             -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10");
        &inMatrix4;
    }
    }
    if ($matrices > 4) {
    if ($d5 == 0) {
        $Concatw->messageBox(-message=>"Matrix 5 is not a conveniently formated NEXUS file.\nPlease choose another file or correct the selected file...",
                             -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10");
        &inMatrix5;
    }
    }

    #Where to go?

    if ($matrices < 3) {
        if ($d1 == 1 and $d2 == 1){&SimpleConcat;}
        else {&MatTest;}
    }
    elsif ($matrices < 4) {
        if ($d1 == 1 and $d2 == 1 and $d3 == 1) {&SimpleConcat;}
        else {&MatTest;}
    }
    elsif ($matrices < 5) {
        if ($d1 == 1 and $d2 == 1 and $d3 == 1 and $d4 ==1) {&SimpleConcat;}
        else {&MatTest;}
    }
    elsif ($matrices < 6) {
        if ($d1 == 1 and $d2 == 1 and $d3 == 1 and $d4 ==1 and $d5 == 1) {&SimpleConcat;}
        else {&MatTest;}
    }
}
#------------------------------------------------------------------------------#
sub SimpleConcat {   #Lê os taxa de cada matriz e coloca cada um destes em seu array na ordem conviniente. Faz isso para todas as matrizes chamadas.
    #Matrix1

    open (MATRIX1, "$infile1");
    $a1 = 0;
    $b1 = 0;
    $c1 = 1;
    for $get1  (<MATRIX1>) {
        if ($a1 == 1 and $c1 == 1 and ($get1 =~ /^\W*\n/ or $get1 =~ /;/)) {
            $c1 = 0;
        }
        if ($a1 == 1 and $c1 == 1) {
            $taxa1[$b1] = substr ($get1, 0, 9);
            $b1++;
        }
        if ($get1 =~ /^\s*matrix/i) {
            $a1 = 1;
        }
    }
	close MATRIX1;
    
    #Matrix2

    open (MATRIX2, "$infile2");
    $a2 = 0;
    $b2 = 0;
    $c2 = 1;
    for $get2  (<MATRIX2>) {
        if ($a2 == 1 and $c2 == 1 and ($get2 =~ /^\W*\n/ or $get2 =~ /;/)) {
            $c2 = 0;
        }
        if ($a2 == 1 and $c2 == 1) {
            $taxa2[$b2] = substr ($get2, 0, 9);
            $b2++;
        }
        if ($get2 =~ /^\s*matrix/i) {
            $a2 = 1;
        }
    }
	close MATRIX2;
	
    #Matrix3

    if ($matrices > 2) {
        open (MATRIX3, "$infile3");
        $b3 = 0;
        $c3 = 1;
        for $get3  (<MATRIX3>) {
            if ($a3 == 1 and $c3 == 1 and ($get3 =~ /^\W*\n/ or $get3 =~ /;/)) {
                $c3 = 0;
            }
            if ($a3 == 1 and $c3 == 1) {
                $taxa3[$b3] = substr ($get3, 0, 9);
                $b3++;
            }
            if ($get3 =~ /^\s*matrix/i) {
                $a3 = 1;
            }
        }
		close MATRIX3;
	}

    
    #Matrix4
    
    if ($matrices > 3) {
        open (MATRIX4, "$infile4");
        $b4 = 0;
        $c4 = 1;
        for $get4  (<MATRIX4>) {
            if ($a4 == 1 and $c4 == 1 and ($get4 =~ /^\W*\n/ or $get4 =~ /;/)) {
                $c4 = 0;
            }
            if ($a4 == 1 and $c4 == 1) {
                $taxa4[$b4] = substr ($get4, 0, 9);
                $b4++;
            }
            if ($get4 =~ /^\s*matrix/i) {
                $a4 = 1;
            }
        }
	close MATRIX4;
	}

    #Matrix5

    if ($matrices > 4) {
        open (MATRIX5, "$infile5");
        $b5 = 0;
        $c5 = 1;
        for $get5  (<MATRIX5>) {
            if ($a5 == 1 and $c5 == 1 and ($get5 =~ /^\W*\n/ or $get5 =~ /;/)) {
                $c5 = 0;
            }
            if ($a5 == 1 and $c5 == 1) {
                $taxa5[$b5] = substr ($get5, 0, 9);
                $b5++;
            }
            if ($get5 =~ /^\s*matrix/i) {
                $a5 = 1;
            }
        }
	close MATRIX5;
	}
	
	#Caso uma matriz tenha taxa com o mesmo nome aborta:

	for $corr1 (@taxa1) {
		$wrong = 0;
		for $corrg1 (@taxa1) {
			if ($corrg1 eq $corr1) { $wrong++}
		}
		if ($wrong > 1) {
			$Concatw->messageBox(-message=>"Matrix 1 has multiple taxa with the same name... Aborting.",
                            -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10",
							-command=>&EndConcat);
		}
	}
	for $corr2 (@taxa2) {
		$wrong = 0;
		for $corrg2 (@taxa2) {
			if ($corrg2 eq $corr2) { $wrong++}
		}
		if ($wrong > 1) {
			$Concatw->messageBox(-message=>"Matrix 2 has multiple taxa with the same name... Aborting.",
                            -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10",
							-command=>&EndConcat);
		}
	}
	if ($matrices > 2) {
		for $corr3 (@taxa3) {
			$wrong = 0;
			for $corrg3 (@taxa3) {
				if ($corrg3 eq $corr3) { $wrong++}
			}
			if ($wrong > 1) {
				$Concatw->messageBox(-message=>"Matrix 3 has multiple taxa with the same name... Aborting.",
    	                        -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10",
								-command=>&EndConcat);
			}
		}
	}
	if ($matrices >3) {
		for $corr4 (@taxa4) {
			$wrong = 0;
			for $corrg4 (@taxa4) {
				if ($corrg4 eq $corr4) { $wrong++}
			}
			if ($wrong > 1) {
				$Concatw->messageBox(-message=>"Matrix 4 has multiple taxa with the same name... Aborting.",
    	                        -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10",
								-command=>&EndConcat);
			}
		}
	}
	if ($matrices >4) {
		for $corr5 (@taxa5) {
			$wrong = 0;
			for $corrg5 (@taxa5) {
				if ($corrg5 eq $corr5) { $wrong++}
			}
			if ($wrong > 1) {
				$Concatw->messageBox(-message=>"Matrix 5 has multiple taxa with the same name... Aborting.",
    	                        -icon=>"error", -title=>"Wrong data input...", -font=>"Arial 10",
								-command=>&EndConcat);
			}
		}
	}

	#Permite tomar uma decisão no caso de os taxa não corresponderem uns aos outros:    

	$decision = "";
	@taxa1s = sort @taxa1;
	@taxa2s = sort @taxa2;
	@taxa3s = sort @taxa3;
	@taxa4s = sort @taxa4;
	@taxa5s = sort @taxa5;	
	for $txc1 (0..$#taxa1 + $#taxa2) {
		unless ($taxa1s[$txc1] eq $taxa2s[$txc1]) {$diference = 1}
	}
	if ($matrices > 2) {
		for $txc2 (0..$#taxa1 + $#taxa3) {
	        unless ($taxa1s[$txc2] eq $taxa3s[$txc2]) {$diference = 1}
		}
    }
	if ($matrices > 3) {
		for $txc3 (0..$#taxa1 + $#taxa4) {
			unless ($taxa1s[$txc3] eq $taxa4s[$txc3]) {$diference = 1}
		}
    }
	if ($matrices > 4) {
		for $txc4 (0..$#taxa1 + $#taxa5) {
			unless ($taxa1s[$txc4] eq $taxa5s[$txc4]) {$diference = 1}
		}
    }

	if ($diference == 1) {&Decision}

	@FullTaxa = @taxa1;	
	if ($decision eq "Fill" or $decision eq "") {
		for $look (@taxa2) {
			$found = 0;
			for $lookall (@FullTaxa) {
				if ($look eq $lookall) {$found = 1}
			}
			if ($found == 0) {$FullTaxa[$#FullTaxa +1] = $look}
		}	
		if ($matrices > 2) {
			for $look (@taxa3) {
				$found = 0;
				for $lookall (@FullTaxa) {
					if ($look eq $lookall) {$found = 1}
				}
				if ($found == 0) {$FullTaxa[$#FullTaxa +1 ] = $look}
			}	
		}
		if ($matrices > 3) {
			for $look (@taxa4) {
				$found = 0;
				for $lookall (@FullTaxa) {
					if ($look eq $lookall) {$found = 1}
				}
				if ($found == 0) {$FullTaxa[$#FullTaxa +1 ] = $look}
			}	
		}
		if ($matrices > 4) {
			for $look (@taxa5) {
				$found = 0;
				for $lookall (@FullTaxa) {
					if ($look eq $lookall) {$found = 1}
				}
				if ($found == 0) {$FullTaxa[$#FullTaxa +1 ] = $look}
			}	
		}
	}
	if ($decision eq "Ignore") {
		for $lookall (0..$#FullTaxa) {
			$found = 0;
			for $look (@taxa2) {
				if ($look eq $FullTaxa[$lookall]) {$found = 1}
			}
			if ($found == 0) {$FullTaxa[$lookall] = ""}
		}
		if ($matrices > 2) {
			for $lookall (0..$#FullTaxa) {
			$found = 0;
			for $look (@taxa3) {
				if ($FullTaxa[$lookall] eq $look) {$found = 1}
			}
			if ($found == 0) {$FullTaxa[$lookall] = ""}
		}
		}
		if ($matrices > 3) {
			for $lookall (0..$#FullTaxa) {
			$found = 0;
			for $look (@taxa4) {
				if ($FullTaxa[$lookall] eq $look) {$found = 1}
			}
			if ($found == 0) {$FullTaxa[$lookall] = ""}
		}
		}
		if ($matrices > 4) {
			for $lookall (0..$#FullTaxa) {
			$found = 0;
			for $look (@taxa5) {
				if ($FullTaxa[$lookall] eq $look) {$found = 1}
			}
			if ($found == 0) {$FullTaxa[$lookall] = ""}
		}
		}	
	}
	for $sweep (@FullTaxa) {
			if ($sweep =~/\w/) {push @FTX, $sweep}
		}
	@FullTaxa = @FTX;
	#Sequence gathering:
    
	open (MATRIX1, "$infile1");
	for $f1 (<MATRIX1>) {
        @i1 = split (//, $f1);
        for $g1 (0..$#FullTaxa) {
            if ((substr ($f1, 0, 9)) eq $FullTaxa[$g1]) {
                $seq1[$g1] = $seq1[$g1] . substr ($f1, 10, ($#i1 + 1))
            }
		}
    	@i1 = "";

    	for $j1 (0..$#seq1) {
        	@k1 = split (/\s/, $seq1[$j1]);
        	$seq1[$j1] = join (/\*/, @k1);
			if ($seq1[$j1] =~ /\w/) {$parse1 = $seq1[$j1]}
        	@k1 = "";
    	}
    }
	if ($decision eq "Fill") {
		for $filler (0..$#FullTaxa) {
			unless ($seq1[$filler] =~/\w/ or $seq1[$filler] =~/-/) {
				$seq1[$filler] = $parse1;
				$seq1[$filler] =~ s/\w/$missing/g;
				$seq1[$filler] =~ s/$gap/$missing/g;
			}
		}	
	}

	open (MATRIX2, "$infile2"); 
	    for $f2 (<MATRIX2>) {
        @i2 = split (//, $f2);
		for $g2 (0..$#FullTaxa) {
            if ((substr ($f2, 0, 9)) eq $FullTaxa[$g2]) {
                $seq2[$g2] = $seq2[$g2] . substr ($f2, 10, ($#i2 + 1))
            }
        }
	@i2 = "";
    }
	
	for $j2 (0..$#seq2) {
       	@k2 = split (/\s/, $seq2[$j2]);
       	$seq2[$j2] = join (/\*/, @k2);
		if ($seq2[$j2] =~ /\w/) {$parse2 = $seq2[$j2]}       	
		@k2 = "";
    }
	if ($decision eq "Fill") {
		for $filler (0..$#FullTaxa) {
			unless ($seq2[$filler] =~/\w/ or $seq2[$filler] =~/-/) { 
				$seq2[$filler] = $parse2;
				$seq2[$filler] =~ s/\w/$missing/g;
				$seq2[$filler] =~ s/$gap/$missing/g;
			}
		}	
	}
	if ($matrices > 2) {
    	open (MATRIX3, "$infile3");
    	for $f3 (<MATRIX3>) {
    	    @i3 = split (//, $f3);
    	    for $g3 (0..$#FullTaxa) {
    	        if ((substr ($f3, 0, 9)) eq $FullTaxa[$g3]) {
    	            $seq3[$g3] = $seq3[$g3] . substr ($f3, 10, ($#i3 + 1))
    	        }
    	    }
    	    @i3 = "";
    	    }
    	for $j3 (0..$#seq3) {
    	    @k3 = split (/\s/, $seq3[$j3]);
    	    $seq3[$j3] = join (/\*/, @k3);
    	    if ($seq3[$j3] =~ /\w/) {$parse3 = $seq3[$j3]}  
			@k3 = "";
    	}
	    if ($decision eq "Fill") {
			for $filler (0..$#FullTaxa) {
				unless ($seq3[$filler] =~/\w/ or $seq3[$filler] =~/-/) {
					$seq3[$filler] = $parse3;
					$seq3[$filler] =~ s/\w/$missing/g;
					$seq3[$filler] =~ s/$gap/$missing/g;
				}
			}	
		}
	}

	if ($matrices > 3) {
        open (MATRIX4, "$infile4");
        for $f4 (<MATRIX4>) {
            @i4 = split (//, $f4);
            for $g4 (0..$#FullTaxa) {
                if ((substr ($f4, 0, 9)) eq $FullTaxa[$g4]) {
                    $seq4[$g4] = $seq4[$g4] . substr ($f4, 10, ($#i4 + 1))
                }
            }
        @i4 = "";
        }
        for $j4 (0..$#seq4) {
            @k4 = split (/\s/, $seq4[$j4]);
            $seq4[$j4] = join (/\*/, @k4);
            if ($seq4[$j4] =~ /\w/) {$parse4 = $seq4[$j4]}  
			@k4 = "";
        }
    	if ($decision eq "Fill") {
			for $filler (0..$#FullTaxa) {
				unless ($seq4[$filler] =~/\w/ or $seq4[$filler] =~/-/) {
					$seq4[$filler] = $parse4;
					$seq4[$filler] =~ s/\w/$missing/g;
					$seq4[$filler] =~ s/$gap/$missing/g;
				}
			}	
		}
	}

	if ($matrices > 4) {
        open (MATRIX5, "$infile5");
        for $f5 (<MATRIX5>) {
            @i5 = split (//, $f5);
            for $g5 (0..$#FullTaxa) {
                if ((substr ($f5, 0, 9)) eq $FullTaxa[$g5]) {
                    $seq5[$g5] = $seq5[$g5] . substr ($f5, 10, ($#i5 + 1))
                }
            }
        @i5 = "";
        }
        for $j5 (0..$#seq5) {
            @k5 = split (/\s/, $seq5[$j5]);
            $seq5[$j5] = join (/\*/, @k5);
			if ($seq5[$j5] =~ /\w/) {$parse5 = $seq5[$j5]} 
            @k5 = "";
        }
		if ($decision eq "Fill") {
			for $filler (0..$#FullTaxa) {
				unless ($seq5[$filler] =~/\w/ or $seq5[$filler] =~/-/) {
					$seq5[$filler] = $parse5;
					$seq5[$filler] =~ s/\w/$missing/g;
					$seq5[$filler] =~ s/$gap/$missing/g;
				}
			}	
		}
	}    
    #Concateneção efectiva
    for $l (0..$#seq1) {
        $SeqC[$l] = $seq1[$l].$seq2[$l];
    }
    if ($matrices > 2) {
        for $m (0..$#SeqC) {
            $SeqC[$m] = $SeqC[$m].$seq3[$m];
        }
    }
    if ($matrices > 3) {
        for $m (0..$#SeqC) {
            $SeqC[$m] = $SeqC[$m].$seq4[$m];
        }
    }
    if ($matrices > 4) {
        for $m (0..$#SeqC) {
            $SeqC[$m] = $SeqC[$m].$seq5[$m];
        }
    }
    @nchar = split (//, $SeqC[0]);
    @char1 = split (//, $seq1[0]);
    @char2 = split (//, $seq2[0]);
    @char3 = split (//, $seq3[0]);
    @char4 = split (//, $seq4[0]);
    @char5 = split (//, $seq5[0]);
}
#----------------------------Window destruction--------------------------------#
sub EndConcat {
    $infile1 = "";
    $infile2 = "";
    $infile3 = "";
    $infile4 = "";
    $infile5 = "";
    $outMat = "";
    $matrices = 2;
    $conctype = "";
    $gap = "";
    $missing = "";
    $gaps = "";
    $missings = "";
    $data1 = "";
    $data2 = "";
    $data3 = "";
    $data4 = "";
    $data5 = "";
    $type = "";
    @nchar = "";
    @SeqC = "";
    @taxa1 = "";
    @taxa2 = "";
    @taxa3 = "";
    @taxa4 = "";
    @taxa5 = "";
	@FullTaxa = "";
    @char1 = "";
    @char2 = "";
    @char3 = "";
    @char4 = "";
    @char5 = "";
    @seq1 = "";
    @seq2 = "";
    @seq3 = "";
    @seq4 = "";
    @seq5 = "";
    $path = "";
    destroy $Concatw;
}
#------------------------------------------------------------------------------#
sub Decision {
	$question = $Concatw->messageBox(-type=>yesno,
		-message=>"The taxa in the selected matrices don\'t match.\nPress \"Yes\" to ignore the taxa that don\'t exist \nin all matrices or press \"No\" to fill the missing data with \"$missing\".",
        -icon=>'warning', -title=>"Matrices don\'t match...", -font=>"Arial 10");
	if ($question eq "Yes") {$decision = "Ignore"};
	if ($question eq "No") {$decision = "Fill"};
}	
#------------------------------------------------------------------------------------------#
MainLoop;
