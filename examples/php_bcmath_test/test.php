<?php

$start = time();
for ($i = 1; $i <= 1000000; $i++) {
  $a = "8.09707454052413919635577888440715258946580668428775950474824953017506360127420091940038046771237888664887342053220951123102876333457480052728109806574848871628692024581572876970116185613895631093241810791852687225130663407994467397555082232868305473303185501486875439373305931251988752888510867191442".$i;
  $b = $i."1.25737664273696274550555428050391992223318427580244856987886515040304820544244089003522386442562821180853835547526988580462516459446335918383321800211590949268950790878470723946424249952005158462419536507105822922117803735975930795427833559882975690208258765127313622053819431639645657225314642357472";
  $res = bcadd($a, $b, 300);
  //echo "a= ".$a."\n";  
  //echo "b= ".$b."\n";  
  //echo "r= ".$res."\n";  
}
$end= time();

echo "\n".($end-$start)." s\n";
echo bcmod('5.7', '1.3');
?>
