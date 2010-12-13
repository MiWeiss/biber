use strict;
use warnings;
use utf8;
no warnings 'utf8';

use Test::More tests => 8;

use Biber;
use Biber::Output::BBL;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($ERROR);
chdir("t/tdata");

# Set up Biber object
my $biber = Biber->new(noconf => 1);
$biber->parse_ctrlfile("general2.bcf");
$biber->set_output_obj(Biber::Output::BBL->new());

# Options - we could set these in the control file but it's nice to see what we're
# relying on here for tests

# Biber options
Biber::Config->setoption('quiet', 1);
Biber::Config->setoption('fastsort', 1);

# Now generate the information
$biber->prepare;
my $out = $biber->get_output_obj;
my $section = $biber->sections->get_section(0);


my @keys = sort $section->get_citekeys;
my @citedkeys = sort qw{ murray t1 kant:ku kant:kpv };

my @allkeys = sort qw{ stdmodel aristotle:poetics vazques-de-parga shore t1
gonzalez averroes/bland laufenberg westfahl:frontier knuth:ct:a kastenholz
averroes/hannes iliad luzzatto malinowski sorace knuth:ct:d britannica
nietzsche:historie stdmodel:weinberg knuth:ct:b baez/article knuth:ct:e itzhaki
jaffe padhye cicero stdmodel:salam reese averroes/hercz murray
aristotle:physics massa aristotle:anima gillies set kowalik gaonkar springer
geer hammond wormanx westfahl:space worman set:herrmann augustine gerhardt
piccato hasan hyman stdmodel:glashow stdmodel:ps_sc kant:kpv companion almendro
sigfridsson ctan baez/online aristotle:rhetoric pimentel00 pines knuth:ct:c moraux cms
angenendt angenendtsk loh markey cotton vangennepx kant:ku nussbaum nietzsche:ksa1
vangennep knuth:ct angenendtsa spiegelberg bertram brandt set:aksin chiu nietzsche:ksa
set:yoon maron coleridge tvonb} ;

is_deeply( \@keys, \@citedkeys, 'citekeys 1') ;
is_deeply( [ $section->get_shorthands ], [ 'kant:kpv', 'kant:ku' ], 'shorthands' ) ;

# reset some options and re-generate information
$section->allkeys;
$biber->prepare;
$section = $biber->sections->get_section(0);
my $bibentries = $section->bibentries;

$out = $biber->get_output_obj;

@keys = sort $section->get_citekeys;

is_deeply( \@keys, \@allkeys, 'citekeys 2') ;

my $murray1 = q|  \entry{murray}{article}{}
    \name{labelname}{14}{}{%
      {{uniquename=0}{Hostetler}{H}{Michael~J.}{MJ}{}{}{}{}}%
      {{uniquename=0}{Wingate}{W}{Julia~E.}{JE}{}{}{}{}}%
      {{uniquename=0}{Zhong}{Z}{Chuan-Jian}{CJ}{}{}{}{}}%
      {{uniquename=0}{Harris}{H}{Jay~E.}{JE}{}{}{}{}}%
      {{uniquename=0}{Vachet}{V}{Richard~W.}{RW}{}{}{}{}}%
      {{uniquename=0}{Clark}{C}{Michael~R.}{MR}{}{}{}{}}%
      {{uniquename=0}{Londono}{L}{J.~David}{JD}{}{}{}{}}%
      {{uniquename=0}{Green}{G}{Stephen~J.}{SJ}{}{}{}{}}%
      {{uniquename=0}{Stokes}{S}{Jennifer~J.}{JJ}{}{}{}{}}%
      {{uniquename=0}{Wignall}{W}{George~D.}{GD}{}{}{}{}}%
      {{uniquename=0}{Glish}{G}{Gary~L.}{GL}{}{}{}{}}%
      {{uniquename=0}{Porter}{P}{Marc~D.}{MD}{}{}{}{}}%
      {{uniquename=0}{Evans}{E}{Neal~D.}{ND}{}{}{}{}}%
      {{uniquename=0}{Murray}{M}{Royce~W.}{RW}{}{}{}{}}%
    }
    \name{author}{14}{}{%
      {{}{Hostetler}{H}{Michael~J.}{MJ}{}{}{}{}}%
      {{}{Wingate}{W}{Julia~E.}{JE}{}{}{}{}}%
      {{}{Zhong}{Z}{Chuan-Jian}{CJ}{}{}{}{}}%
      {{}{Harris}{H}{Jay~E.}{JE}{}{}{}{}}%
      {{}{Vachet}{V}{Richard~W.}{RW}{}{}{}{}}%
      {{}{Clark}{C}{Michael~R.}{MR}{}{}{}{}}%
      {{}{Londono}{L}{J.~David}{JD}{}{}{}{}}%
      {{}{Green}{G}{Stephen~J.}{SJ}{}{}{}{}}%
      {{}{Stokes}{S}{Jennifer~J.}{JJ}{}{}{}{}}%
      {{}{Wignall}{W}{George~D.}{GD}{}{}{}{}}%
      {{}{Glish}{G}{Gary~L.}{GL}{}{}{}{}}%
      {{}{Porter}{P}{Marc~D.}{MD}{}{}{}{}}%
      {{}{Evans}{E}{Neal~D.}{ND}{}{}{}{}}%
      {{}{Murray}{M}{Royce~W.}{RW}{}{}{}{}}%
    }
    \strng{namehash}{HMJ+1}
    \strng{fullhash}{HMJWJEZCJHJEVRWCMRLJDGSJSJJWGDGGLPMDENDMRW1}
    \field{labelalpha}{Hos\textbf{+}98}
    \field{sortinit}{H}
    \field{labelyear}{1998}
    \true{singletitle}
    \field{annotation}{An \texttt{article} entry with \arabic{author} authors. By default, long author and editor lists are automatically truncated. This is configurable}
    \field{hyphenation}{american}
    \field{indextitle}{Alkanethiolate gold cluster molecules}
    \field{journaltitle}{Langmuir}
    \field{number}{1}
    \field{shorttitle}{Alkanethiolate gold cluster molecules}
    \field{subtitle}{Core and monolayer properties as a function of core size}
    \field{title}{Alkanethiolate gold cluster molecules with core diameters from 1.5 to 5.2~nm}
    \field{volume}{14}
    \field{year}{1998}
    \field{pages}{17\bibrangedash 30}
  \endentry

|;

my $murray2 = q|  \entry{murray}{article}{}
    \name{labelname}{14}{}{%
      {{uniquename=0}{Hostetler}{H}{Michael~J.}{MJ}{}{}{}{}}%
      {{uniquename=0}{Wingate}{W}{Julia~E.}{JE}{}{}{}{}}%
      {{uniquename=0}{Zhong}{Z}{Chuan-Jian}{CJ}{}{}{}{}}%
      {{uniquename=0}{Harris}{H}{Jay~E.}{JE}{}{}{}{}}%
      {{uniquename=0}{Vachet}{V}{Richard~W.}{RW}{}{}{}{}}%
      {{uniquename=0}{Clark}{C}{Michael~R.}{MR}{}{}{}{}}%
      {{uniquename=0}{Londono}{L}{J.~David}{JD}{}{}{}{}}%
      {{uniquename=0}{Green}{G}{Stephen~J.}{SJ}{}{}{}{}}%
      {{uniquename=0}{Stokes}{S}{Jennifer~J.}{JJ}{}{}{}{}}%
      {{uniquename=0}{Wignall}{W}{George~D.}{GD}{}{}{}{}}%
      {{uniquename=0}{Glish}{G}{Gary~L.}{GL}{}{}{}{}}%
      {{uniquename=0}{Porter}{P}{Marc~D.}{MD}{}{}{}{}}%
      {{uniquename=0}{Evans}{E}{Neal~D.}{ND}{}{}{}{}}%
      {{uniquename=0}{Murray}{M}{Royce~W.}{RW}{}{}{}{}}%
    }
    \name{author}{14}{}{%
      {{}{Hostetler}{H}{Michael~J.}{MJ}{}{}{}{}}%
      {{}{Wingate}{W}{Julia~E.}{JE}{}{}{}{}}%
      {{}{Zhong}{Z}{Chuan-Jian}{CJ}{}{}{}{}}%
      {{}{Harris}{H}{Jay~E.}{JE}{}{}{}{}}%
      {{}{Vachet}{V}{Richard~W.}{RW}{}{}{}{}}%
      {{}{Clark}{C}{Michael~R.}{MR}{}{}{}{}}%
      {{}{Londono}{L}{J.~David}{JD}{}{}{}{}}%
      {{}{Green}{G}{Stephen~J.}{SJ}{}{}{}{}}%
      {{}{Stokes}{S}{Jennifer~J.}{JJ}{}{}{}{}}%
      {{}{Wignall}{W}{George~D.}{GD}{}{}{}{}}%
      {{}{Glish}{G}{Gary~L.}{GL}{}{}{}{}}%
      {{}{Porter}{P}{Marc~D.}{MD}{}{}{}{}}%
      {{}{Evans}{E}{Neal~D.}{ND}{}{}{}{}}%
      {{}{Murray}{M}{Royce~W.}{RW}{}{}{}{}}%
    }
    \strng{namehash}{HMJ+1}
    \strng{fullhash}{HMJWJEZCJHJEVRWCMRLJDGSJSJJWGDGGLPMDENDMRW1}
    \field{labelalpha}{Hos98}
    \field{sortinit}{H}
    \field{labelyear}{1998}
    \true{singletitle}
    \field{annotation}{An \texttt{article} entry with \arabic{author} authors. By default, long author and editor lists are automatically truncated. This is configurable}
    \field{hyphenation}{american}
    \field{indextitle}{Alkanethiolate gold cluster molecules}
    \field{journaltitle}{Langmuir}
    \field{number}{1}
    \field{shorttitle}{Alkanethiolate gold cluster molecules}
    \field{subtitle}{Core and monolayer properties as a function of core size}
    \field{title}{Alkanethiolate gold cluster molecules with core diameters from 1.5 to 5.2~nm}
    \field{volume}{14}
    \field{year}{1998}
    \field{pages}{17\bibrangedash 30}
  \endentry

|;

my $t1 = q|  \entry{t1}{misc}{}
    \name{labelname}{1}{}{%
      {{uniquename=0}{Brown}{B}{Bill}{B}{}{}{}{}}%
    }
    \name{author}{1}{}{%
      {{}{Brown}{B}{Bill}{B}{}{}{}{}}%
    }
    \strng{namehash}{BB1}
    \strng{fullhash}{BB1}
    \field{labelalpha}{Bro92}
    \field{sortinit}{B}
    \field{labelyear}{1992}
    \true{singletitle}
    \field{title}{Normal things {$^{3}$}}
    \field{year}{1992}
  \endentry

|;

my $Worman_N = [ 'Worman, Nana', 'Worman, Nancy' ] ;
my $Gennep = [ 'van Gennep, Arnold', 'van Gennep, Jean' ] ;

is( $out->get_output_entry('t1'), $t1, 'bbl entry with maths in title' ) ;
is_deeply( Biber::Config->_get_uniquename('Worman_N'), $Worman_N, 'uniquename count 1') ;
is_deeply( Biber::Config->_get_uniquename('Gennep'), $Gennep, 'uniquename count 2') ;
is( $out->get_output_entry('murray'), $murray1, 'bbl with > maxnames' ) ;

Biber::Config->setblxoption('alphaothers', '');
Biber::Config->setblxoption('sortalphaothers', '');

$biber->prepare ;
$out = $biber->get_output_obj;

is( $out->get_output_entry('murray'), $murray2, 'bbl with > maxnames, empty alphaothers' ) ;

unlink "*.utf8";