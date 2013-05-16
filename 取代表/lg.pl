##################################################################################
# 將 <lg...><l>「  改成  <lg ... rend="margin-left:1em;text-indent:-1em"><l>「 
# 將 <lg...><l>「『  改成  <lg ... rend="margin-left:2em;text-indent:-2em"><l>「『 
##################################################################################

$in = "T08n0239.xml";		# 輸入檔名, 若是批次檔的參數, 可用 $in = shift; 即可
$out = "out.xml";			# 輸出檔名, 若是批次檔的參數, 可用 $out = shift; 即可

open IN, $in;
open OUT, ">$out";

while(<IN>)
{
	if(/(<lg\s*.*?>)(<l.*?>)?「(.?.?)/)
	{
		$lg = $1;
		$l = $2;
		$second = $3;
		
		$indent = "1em";
		if($second eq "『")
		{
			$indent = "2em";
		}
		
		if($lg =~ /rend/)	# 有 rend 了, 加上 xxx , 讓它 parse 不過請手動處理
		{
			$lg =~ s/<lg /<lg todo="請手動改rend" /;
		}
		else
		{
			$lg =~ s/>/ rend="margin-left:${indent};text-indent:-${indent}">/;
		}

		s/(<lg\s*.*?>)(<l.*?>)?(「.?.?)/$lg$2$3/;
	}
	print OUT;
}
close IN;
close OUT;