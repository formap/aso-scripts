#!/usr/bin/perl

$numArgs = @ARGV;
$p=0;
$usage="Usage: BadUsers.pl [-p] \n";
if ( $numArgs != 0){
    if ( $numArgs == 1 ){
        if ( $ARGV[0] eq "-p" ) { # si el primer argument es -p 
             $p=1; # activem el flag p            
   	} else { print $usage; exit (1); }
    	} else { print $usage; exit (1); }
}	
$pass_db_file="/etc/passwd";
open(FILE,$pass_db_file) or die "no es pot obrir el fitxer, parguela, $pass_db_file: $!";
@password_db = <FILE>;
close FILE;


foreach $user_line (@password_db){
	chomp $user_line;
	@fields = split (':', $user_line);
	$user_id = $fields[0];
	$user_home = $fields[5];
	if ( -d $user_home ) {
		$command = sprintf("find %s -type f -user %s | wc -l",
					$user_home, $user_id);
		$find_out=`$command`;
		chomp $find_out;
	} else {
		$find_out = 0;
	}

	if ($find_out == 0) {
		#print "Find out es zero\n";
		$invalid_users{$user_id} = "invalid";
	} else {
		
		#print "El user " . $user_id . "te coses a la home\n";
	}
}
