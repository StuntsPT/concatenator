# Concatenator

This was my first "real" program. It is still quite useful in phylogeographic and phylogenetic studies, however, since this program was first released, several others have started implementing the functions present in *Concatenator*.

It is written in perl and released under the GPL license.

# Usage

*Concatenator* can be used for essentially two things: converting between FASTA and NEXUS formats and concatenating 2-5 NEXUS files.

## Format conversion

Given a FASTA input, *Concatenator* will convert it into the NEXUS format. The user can choose the *type* of NEUXS output - *leave* or *interleave*.

## Concatenation

*Concatenator* will take up to 5 NEXUS files as input and will concatenate them. The user can choose the output type - either formatted for *PAUP* or *MrBayes*.

# Limitations

The NEXUS format specification limits taxa names to 8 character, however, the FASTA format does not. *Concatenator* will trim any taxa names into the first 8 characters when performing the conversion. This is a frequent source of errors during the concatenation step, since some taxa may end up with the same name.

# How to cite:

If you find *Concatenator* usefull, please cite the following paper:

Pina-Martins F, Paulo OS (2008). Concatenator: Sequence Data Matrices Handling Made Easy. Molecular Ecology Resources 8, 1254-1255

Your citation is much appreciated!
