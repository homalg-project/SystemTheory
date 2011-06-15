#############################################################################
##
##  Tools.gd                                            SystemTheory package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of tool procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation(
    "GeneralLinearCombination",
    [ IsHomalgRing, IsInt, IsList, IsInt ] );