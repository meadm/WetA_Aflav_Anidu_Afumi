{
if ( $4 > 0 && $5 > 0 && $6 > 0 ) print $0 > "induced.txt";
else if ( $4 < 0 && $5 < 0 && $6 < 0 ) print $0 > "repressed.txt";
else if ( $4 > 0 && $5 <= 0 && $6 > 0 ) print $0 > "flav_fumi_induced.txt";
else if ( $4 < 0 && $5 >= 0 && $6 < 0 ) print $0 > "flav_fumi_repressed.txt";
else if ( $4 > 0 && $5 > 0 && $6 <= 0 ) print $0 > "flav_nidu_induced.txt";
else if ( $4 < 0 && $5 < 0 && $6 >= 0 ) print $0 > "flav_nidu_repressed.txt";
else if ( $4 <= 0 && $5 > 0 && $6 > 0 ) print $0 > "nidu_fumi_induced.txt";
else if ( $4 >= 0 && $5 < 0 && $6 < 0 ) print $0 > "nidu_fumi_repressed.txt";
else if ( $4 == 0 && $5 == 0 && $6 > 0 ) print $0 > "fumi_induced.txt";
else if ( $4 == 0 && $5 == 0 && $6 < 0 ) print $0 > "fumi_repressed.txt";
else if ( $4 > 0 && $5 == 0 && $6 == 0 ) print $0 > "flav_induced.txt";
else if ( $4 < 0 && $5 == 0 && $6 == 0 ) print $0 > "flav_repressed.txt";
else if ( $4 == 0 && $5 > 0 && $6 == 0 ) print $0 > "nidu_induced.txt";
else if ( $4 == 0 && $5 < 0 && $6 == 0 ) print $0 > "nidu_repressed.txt";
}
