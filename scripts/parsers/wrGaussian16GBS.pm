################################################################################
#
# This perl module will write a gaussian basis set in the Gaussian94 file format
# To use this module, "require" it in the calling program.
# The calling program must be running under perl5.
#
# The output will be written to standard output
#
# The data is passed in as $bs
#    bs  : [ \%gbs, \%ecp ]
#           a bs is a pointer to a hash array:
#               KEY             VALUE
#               "gbs"           [%gbs]    - a pointer to a hash containing a gbs
#               "ecp"           [%ecp]    - a pointer to a hash containing a ecp
#               "dftCDfitting"  [%gbs]    - a pointer to a hash containing a gbs
#               "dftXCfitting"  [%gbs]    - a pointer to a hash containing a gbs
#     %gbs  :  {  $centerName => \@orbitalList }
#              - a gbs is a hash of centers and pointers to arrays
#              - there is one key named "polarization", it either
#                has the value of "spherical" or "cartesian".
#      $centerName : number of the center or the atomic symbol
#      @orbitalList : ( [ $orbitalType , \@GBSprimitiveList ] )
#              - orbitalList is an array of pointers to arrays, each of
#                which is one orbitalType and one pointer to an array
#        $orbitalType : S, P, SP, D...
#        @GBSprimitiveList : ( { exponent     => $exponentValue,
#                                Scoefficient => $ScoefficientValue,
#                                Pcoefficient => $PcoefficientValue} )
#              - GBSprimitiveList is an array of pointers to hashes.
#                each hash contains three key/value pairs.
#     %ecp  :  {  $centerName => \@ecpData }
#              - an ecp is a hash of centers and pointers to arrays
#      @ecpData  :  ( $numberElectrons, \@components )
#              - ecpData is an array containing the number of electrons
#                replaced by the function and a pointer to an array of
#                components.
#        @components  :  ( $shellType , \@ECPprimitiveList )
#              - components is an array containing a shell type and
#                a pointer to an array of primitives
#        @ECPprimitiveList : ( { Rexponent     => $RexponentValue,
#                                GaussExponent => $GaussExponentValue,
#                                Coefficient =>   $CoefficientValue} )
#      $shellType : ul, S, P, SP, D...
#
################################################################################

my %elementName =
(
 H  =>  "Hydrogen",
 He =>  "Helium",
 Li =>  "Lithium",
 Be =>  "Beryllium",
 B  =>  "Boron",
 C  =>  "Carbon",
 N  =>  "Nitrogen",
 O  =>  "Oxygen",
 F  =>  "Flourine",
 Ne =>  "Neon",
 Na =>  "Sodium",
 Mg =>  "Magnesium",
 Al =>  "Aluminum",
 Si =>  "Silicon",
 P  =>  "Phosphorus",
 S  =>  "Sulfur",
 Cl =>  "Chlorine",
 Ar =>  "Argon",
 K  =>  "Potassium",
 Ca =>  "Calcium",
 Sc =>  "Scandium",
 Ti =>  "Titanium",
 V  =>  "Vanadium",
 Cr =>  "Chromium",
 Mn =>  "Manganese",
 Fe =>  "Iron",
 Co =>  "Cobalt",
 Ni =>  "Nickel",
 Cu =>  "Copper",
 Zn =>  "Zinc",
 Ga =>  "Gallium",
 Ge =>  "Germanium",
 As =>  "Arsenic",
 Se =>  "Selenium",
 Br =>  "Bromine",
 Kr =>  "Krypton",
 Rb =>  "Rubidium",
 Sr =>  "Strontium",
 Y  =>  "Yttrium",
 Zr =>  "Zirconium",
 Nb =>  "Nioblum",
 Mo =>  "MolyBdenum",
 Tc =>  "Technetium",
 Ru =>  "Ruthenium",
 Rh =>  "Rhodium",
 Pd =>  "Palladium",
 Ag =>  "Silver",
 Cd =>  "Cadmium",
 In =>  "Indium",
 Sn =>  "Tin",
 Sb =>  "Antimony",
 Te =>  "Tellurium",
 I  =>  "Iodine",
 Xe =>  "Xenon",
 Cs =>  "Cesium",
 Ba =>  "Barium",
 La =>  "Lanthanum",
 Ce =>  "Cerium",
 Pr =>  "Praseodymium",
 Nd =>  "Neodymium",
 Pm =>  "Promethium",
 Sm =>  "Samarium",
 Eu =>  "Europium",
 Gd =>  "Gadolinium",
 Tb =>  "Terbium",
 Dy =>  "Dysprosium",
 Ho =>  "Holmium",
 Er =>  "Erbium",
 Tm =>  "Thulium",
 Yb =>  "Ytterbium",
 Lu =>  "Lutetium",
 Hf =>  "Hafnium",
 Ta =>  "Tantalum",
 W  =>  "Tungsten",
 Re =>  "Rhenium",
 Os =>  "Osmium",
 Ir =>  "Iridium",
 Pt =>  "Platinum",
 Au =>  "Gold",
 Hg =>  "Mercury",
 Tl =>  "Thallium",
 Pb =>  "Lead",
 Bi =>  "Bismuth",
 Po =>  "Polonium",
 At =>  "Astatine",
 Rn =>  "Radon",
 Fr =>  "Francium",
 Ra =>  "Radium",
 Ac =>  "Actinium",
 Th =>  "Thorium",
 Pa =>  "Protactinium",
 U  =>  "Uranium",
 Np =>  "Neptunium",
 Pu =>  "Plutonium",
 Am =>  "Americium",
 Cm =>  "Curium",
 Bk =>  "Berkelium",
 Cf =>  "Californium",
 Es =>  "Einsteinium",
 Fm =>  "Fermium",
 Md =>  "Mendelevium",
 No =>  "Nobelium",
 Lr =>  "Lawrencium",
 Rf =>  "Rutherfordium",
 Db =>  "Dubnium",
 Sg =>  "Seaborgium",
 Bh =>  "Bohrium",
 Hs =>  "Hassium",
 Mt =>  "Meitnerium"
);

my %elementNum =
(
 H  =>  1,
 He =>  2,
 Li =>  3,
 Be =>  4,
 B  =>  5,
 C  =>  6,
 N  =>  7,
 O  =>  8,
 F  =>  9,
 Ne =>  10,
 Na =>  11,
 Mg =>  12,
 Al =>  13,
 Si =>  14,
 P  =>  15,
 S  =>  16,
 Cl =>  17,
 Ar =>  18,
 K  =>  19,
 Ca =>  20,
 Sc =>  21,
 Ti =>  22,
 V  =>  23,
 Cr =>  24,
 Mn =>  25,
 Fe =>  26,
 Co =>  27,
 Ni =>  28,
 Cu =>  29,
 Zn =>  30,
 Ga =>  31,
 Ge =>  32,
 As =>  33,
 Se =>  34,
 Br =>  35,
 Kr =>  36,
 Rb =>  37,
 Sr =>  38,
 Y  =>  39,
 Zr =>  40,
 Nb =>  41,
 Mo =>  42,
 Tc =>  43,
 Ru =>  44,
 Rh =>  45,
 Pd =>  46,
 Ag =>  47,
 Cd =>  48,
 In =>  49,
 Sn =>  50,
 Sb =>  51,
 Te =>  52,
 I  =>  53,
 Xe =>  54,
 Cs =>  55,
 Ba =>  56,
 La =>  57,
 Ce =>  58,
 Pr =>  59,
 Nd =>  60,
 Pm =>  61,
 Sm =>  62,
 Eu =>  63,
 Gd =>  64,
 Tb =>  65,
 Dy =>  66,
 Ho =>  67,
 Er =>  68,
 Tm =>  69,
 Yb =>  70,
 Lu =>  71,
 Hf =>  72,
 Ta =>  73,
 W  =>  74,
 Re =>  75,
 Os =>  76,
 Ir =>  77,
 Pt =>  78,
 Au =>  79,
 Hg =>  80,
 Tl =>  81,
 Pb =>  82,
 Bi =>  83,
 Po =>  84,
 At =>  85,
 Rn =>  86,
 Fr =>  87,
 Ra =>  88,
 Ac =>  89,
 Th =>  90,
 Pa =>  91,
 U  =>  92,
 Np =>  93,
 Pu =>  94,
 Am =>  95,
 Cm =>  96,
 Bk =>  97,
 Cf =>  98,
 Es =>  99,
 Fm =>  100,
 Md =>  101,
 No =>  102,
 Lr =>  103,
 Rf =>  104,
 Db =>  105,
 Sg =>  106,
 Bh =>  107,
 Hs =>  108,
 Mt =>  109
);

sub writeGaussian16{
  my $bsPtr = $_[0];
  my %bs = %{$bsPtr};
  my %gbs = %{$bs{"gbs"}};
  my %name_gbs = %{$bs{"name_gbs"}};
  my $coordinants = delete $gbs{"coordinants"};
  my $name_coordinants;
  my %ecp;
  my $gbsPolarization = delete $gbs{"polarization"};
  my $ecpPolarization;
  my $dftXCPolarization;
  my $dftCDPolarization;
  my $useRouteCard = 0;

  &setupBasisTranslation;

  # check to see if a basis set name can be used in the route card instead of a
  # complete list of coefficients and exponents

  if (exists $bs{"name_gbs"} && !(exists $bs{"ecp"})) {
    $name_coordinants = delete $name_gbs{"coordinants"};
    $oldbasis = "";
    $useRouteCard = 1;
    foreach $atom (keys %name_gbs) {
      $lib_gbs = lc $name_gbs{$atom};
      # strip off quotes
      $lib_gbs =~ s/^\"//;
      $lib_gbs =~ s/\"$//;
      if ($lib_gbs ne $oldbasis && $oldbasis ne "") {$useRouteCard = 0;}
      if (!defined($NameToBasis{$lib_gbs})) {$useRouteCard = 0;}
      $oldbasis = $lib_gbs;
    }
    if ($useRouteCard == 1) {
      print("useRouteCard $oldbasis $name_coordinants\n");
    }
  }
  if ($useRouteCard == 0) {
    if (exists $bs{"ecp"})
    {
      %ecp = %{$bs{"ecp"}};
      $ecpPolarization = delete $ecp{"polarization"};
    }
    my %dftXC;
    if (exists $bs{"dftXCfitting"})
    {
      %dftXC = %{$bs{"dftXCfitting"}};
      $dftXCPolarization = delete $dftXC{"polarization"};
    }
    my %dftCD;
    if (exists $bs{"dftCDfitting"})
    {
      %dftCD = %{$bs{"dftCDfitting"}};
      $dftCDPolarization = delete $dftCD{"polarization"};
    }

    my $atom;

    ########################################33
    # Write out GBS information
    ########################################33
    #
    # Write out information for each atom in the gbs
    #
    foreach $atom (keys %gbs)
    {
      #
      # Each atom has a list of orbitals  associated with it.
      #
      my @orbitalList = @{$gbs{$atom}};
      #
      # Get element name $en
      #
      my $en;
      $en = $atom;
      $en =~ tr/a-z/A-Z/;
      print " $en  0\n";
      #
      # %coefficient_ctr counts the number of $coefficients 
      # associated with a certain $orbitalType
      #
      # Purpose of %coefficient_ctr:
      # to find if any SP orbitals are present
      #
      my %coefficient_ctr = ("S", 0, "SP", 0, "P", "D", 0, "F", 0, "G", 0, "H", 0, "I", 0);
      my $orbPtr;
      foreach $orbPtr (@orbitalList)
      {
        my @orb = @{$orbPtr};
        my $orbitalType = $orb[0];
        my @contractionSet = @{$orb[1]};
        #
        # $contractionCnt counts the number of rows 
        # for one $orbPtr
        #
        my $contractionCnt = $#contractionSet + 1;
        my $rowPtr;
        my $coefficient_ctr;
        foreach $rowPtr (@contractionSet)
        {
          my($exponent,@coefficients);
          ($exponent,@coefficients) = @{$rowPtr};
          #
          # $coefficient_ctr{$orbitalType} matches 
          # number of coefficients it's orbialType
          #
          $coefficient_ctr{$orbitalType} = $#coefficients;
        }

        my $j = 0;
        #
        # if this is an SP orbital
        #
        if ( $coefficient_ctr{$orbitalType} >= 1 && $coefficient_ctr{SP} == 0 ) {
          for ( $j=0; $j <= $coefficient_ctr{$orbitalType}; $j++ ) {
            #
            # make sure that there are no 0s as place holders
            # for the SP orbitals
            #
            $contractionCnt=0;
            foreach $rowPtr ( @contractionSet ) {
              my($exponent,@coefficients);
              ($exponent,@coefficients) = @{$rowPtr};
              if($coefficients[$j] != 0) {
                $contractionCnt++;
              }
            }
            #
            # print orbitalType and number of rows in orbital
            #
            printf " %-2s%3d  1.00\n", $orbitalType, $contractionCnt;
            #
            # only print 2 columns at a time if not an SP orbital
            #
            foreach $rowPtr ( @contractionSet ) {
              my($exponent,@coefficients);
              ($exponent,@coefficients) = @{$rowPtr};
              if($coefficients[$j] != 0) {
                printf "%17.8f", $exponent;
                printf "%16.8f\n", $coefficients[$j];
              }
            }
          }
        }
        else {
          printf " %-2s%3d  1.00\n", $orbitalType, $contractionCnt;
          foreach $rowPtr (@contractionSet) {
            my($exponent,@coefficients);
            ($exponent,@coefficients) = @{$rowPtr};
            #
            # print all coefficients for the row on one row if is an SP orbital
            #
            printf "%17.8f", $exponent;
            foreach $coefficient ( @coefficients )
            {
              if($coefficient != 0) 
              {
                printf "%16.8f", $coefficient;
              }
            }
            print "\n";
          }
        }
      }
      print " ****\n";
    }

    ########################################33
    # Write out ECP information
    ########################################33
    #
    # Set shell type translations for gaussian code
    #
    @shells = ("s", "p", "d", "f", "g", "h", "i");
    #
    # Write out information for each atom in the ecp
    #
    print "\n"; 
    foreach $atom (keys %ecp)
    {
      #
      # Each atom has a set of data associated with it
      #
      my @ecpData = @{$ecp{$atom}};
      my $numElectrons = $ecpData[0];
      my @ecpComponents = @{$ecpData[1]};
      my $numComponents = $#ecpComponents;
      my $firstShell = $shells[$numComponents];
      $atom =~ tr/[a-z]/[A-Z]/;
      # What does this zero mean?
      print "$atom  0\n";
      print "$atom-ECP   $numComponents   $numElectrons\n";

      my $cntr = 0;
      my $componentPtr;
      foreach $componentPtr (@ecpComponents)
      {
        #
        # Each component has a type string and a list of primitives
        #
        my @component = @{$componentPtr};
        my $shellType = ($cntr eq 0) ? $firstShell
                                   : ($shells[$cntr-1] .  "-$firstShell");
        $shellType .= " potential";
        my @primitiveList = @{$component[1]};
        $primCnt = $#primitiveList + 1;
        printf "$shellType\n";
        print " $primCnt\n";
        my $primPtr;
        foreach $primPtr (@primitiveList)
        {
          #
          # Each primitive has three elements in it:
          #  an Rexponent, a Gauss exponent, and a P coefficient
          #
          my %prim = %{$primPtr};
          if($prim{Coefficient} ne 0) 
          {
            print  ("$prim{Rexponent}");
            printf ("%18.8f",$prim{GaussExponent});
            printf ("%16.8f\n", $prim{Coefficient});
          }
        }
        $cntr++;
      }
    }
  }
}
1;

sub setupBasisTranslation {

  # translations between NWChem and Gaussian-09 basis names
  # (when available)

  $NameToBasis{"sto-2g"} = "sto-2g";
  $NameToBasis{"sto-3g"} = "sto-3g";
  $NameToBasis{"sto-3g*"} = "sto-3g*";

  $NameToBasis{"3-21g"} = "3-21g";
  $NameToBasis{"3-21+g"} = "3-21+g";
  $NameToBasis{"3-21g*"} = "3-21g*";
  $NameToBasis{"3-21+g*"} = "3-21+g*";

  $NameToBasis{"4-31g"} = "4-31g";

  $NameToBasis{"6-31g"} = "6-31g";
  $NameToBasis{"6-31++g"} = "6-31++g";
  $NameToBasis{"6-31++g**"} = "6-31++g**";
  $NameToBasis{"6-31g(3df,3pd)"} = "6-31g(3df,3dp)";
  $NameToBasis{"6-311g"} = "6-311G";
  $NameToBasis{"6-311++g"} = "6-311++G";
  $NameToBasis{"6-311++g(3df,3pd)"} = "6-311++g(3df,3dp)";

  $NameToBasis{"midi!"} = "midix";
  $NameToBasis{"dz (dunning)"} = "d95";
  $NameToBasis{"sv (dunning-hay)"} = "d95v";

  $NameToBasis{"cc-pvdz"} = "cc-pvdz";
  $NameToBasis{"cc-pvtz"} = "cc-pvtz";
  $NameToBasis{"cc-pvqz"} = "cc-pvqz";
  $NameToBasis{"cc-pv5z"} = "cc-pv5z";
  $NameToBasis{"cc-pv6z"} = "cc-pv6z";
  $NameToBasis{"aug-cc-pvdz"} = "aug-cc-pvdz";
  $NameToBasis{"aug-cc-pvtz"} = "aug-cc-pvtz";
  $NameToBasis{"aug-cc-pvqz"} = "aug-cc-pvqz";
  $NameToBasis{"aug-cc-pv5z"} = "aug-cc-pv5z";
  $NameToBasis{"aug-cc-pv6z"} = "aug-cc-pv6z";

}
