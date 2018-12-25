/*  dbar - ascii percentage meter
 * 
 *  Copyright (C) 2007 by Robert Manea, <rob dot manea at gmail dot com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version
 *
 *  This program is distributed in the hope that it will be useful, but 
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
 *  General Public License for more details.
 * 
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 *  USA
 *
 *  Compile with:
 *  gcc dbar.c -o dbar
 *
 */

/*
dbar lets you define static 0% and 100% marks or you can define these
marks dynamically at runtime.  Static and dynamic marks can be mixed,
in this case the value specified at runtime will have a higher priority.

You can specify ranges of numbers, negative, positive or ranges with a
negative min value and positive max value.

All numbers are treated as double precision floating point, i.e. the
input is NOT limited to integers.

Options:
     -max :  Value to be considered 100%   (default: 100)
     -min :  Value to be considered   0%   (default: 0  )
     -w   :  Number of charcaters to be 
             considered 100% in the meter  (default: 25 )
     -s   :  Symbol represeting the 
             percentage value in the meter (default: =  )
     -l   :  label to be prepended to 
             the bar                       (default: '' )
     -nonl:  no new line, don't put 
             '\n' at the end of the bar    (default: do print '\n')

Usage examples:

 1) Static 100% mark or single value input:

   echo 25 | dbar -m 100 -l Sometext

   Output: Sometext  25% [======                   ]

 2) If your 100% mark changes dynamically or 2-values input:
   
   echo "50 150" | dbar
         ^   ^
         |   |__ max. value
         |
         |__ value to display

   Output: 33% [========                 ]

 3) If your value range is not between [0, maxval] or 3-values input:

   echo "50 -25 150" | dbar
         ^   ^  ^
         |   |  |__ max. value 100% mark
         |   |
         |   |_____ min. value 0% mark
         |
         |________ value to display

   Output: 43% [===========              ]


 4) Multiple runs:
    
   for i in 2 20 50 75 80; do echo $i; sleep 1; done | dbar | dzen2

   Output: Find out yourself.

*/

#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>

#define MAXLEN 512

static void pbar (const char*, double, int, char, int);


static void
pbar(const char* label, double perc, int maxc, char sym, int pnl) {
	int i, rp;
	double l;

	l = perc * ((double)maxc / 100);
	if((int)(l + 0.5) >= (int)l)
		l = l + 0.5;

	if((int)(perc + 0.5) >= (int)perc)
		rp = (int)(perc + 0.5);
	else
		rp = (int)perc;

	if(label)
		printf("%s %3d%% [", label, rp);
	else
		printf("%3d%% [", rp);

	for(i=0; i < (int)l; i++)
		if(i == maxc) {
			putchar('>');
			break;
		} else
			putchar(sym);

	for(; i < maxc; i++)
		putchar(' ');

	printf("]%s", pnl ? "\n" : "");
	fflush(stdout);
}

int
main(int argc, char *argv[])
{
	int i, nv;
	double val;
	char aval[MAXLEN], *endptr;

	/* defaults */
	int maxchars  =   25;
	double minval =    0;
	double maxval =  100.0;
	char psym     =  '=';
	int print_nl  =    1;
	const char *label = NULL;


	for(i=1; i < argc; i++) {
		if(!strncmp(argv[i], "-w", 3)) {
			if(++i < argc)
				maxchars = atoi(argv[i]);
		}
		else if(!strncmp(argv[i], "-s", 3)) {
			if(++i < argc)
				psym = argv[i][0];
		}
		else if(!strncmp(argv[i], "-max", 5)) {
			if(++i < argc) {
				maxval = strtod(argv[i], &endptr);
				if(*endptr) {
					fprintf(stderr, "dbar: '%s' incorrect number format", argv[i]);
					return EXIT_FAILURE;
				}
			}
		}
		else if(!strncmp(argv[i], "-min", 5)) {
			if(++i < argc) {
				minval = strtod(argv[i], &endptr);
				if(*endptr) {
					fprintf(stderr, "dbar: '%s' incorrect number format", argv[i]);
					return EXIT_FAILURE;
				}
			}
		}
		else if(!strncmp(argv[i], "-l", 3)) {
			if(++i < argc)
				label = argv[i];
		}
		else if(!strncmp(argv[i], "-nonl", 6)) {
			print_nl = 0;
		}
		else {
			fprintf(stderr, "usage: dbar [-w <characters>] [-s <symbol>] [-min <minvalue>] [-max <maxvalue>] [-l <string>] [-nonl]\n");
			return EXIT_FAILURE;
		}
	}

	while(fgets(aval, MAXLEN, stdin)) {
		nv = sscanf(aval, "%lf %lf %lf", &val, &minval, &maxval);
		if(nv == 2) {
			maxval = minval;
			minval = 0;
		}
		
		pbar(label, (100*(val-minval))/(maxval-minval), maxchars, psym, print_nl);
	}

	return EXIT_SUCCESS;
}

