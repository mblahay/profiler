BEGIN{
	beginflag=1;
	recordCounter=0
}
{
	recordCounter++;

	if(beginflag == 1){
		for(i=1;i <= NF; i++){
			maxsize[i]=0;
			minsize[i]=999999;
			totalsize[i]=0;
			nullcount[i]=0
		};
		beginflag = 0;
	}
	for(i=1;i <= NF; i++){
		if(maxsize[i] < length($i)){
			maxsize[i]=length($i);
		}
		if(minsize[i] > length($i)){
			minsize[i]=length($i);
		}
		totalsize[i]+=length($i);
		if(length($i)==0){
			nullcount[i]++;
		}
		
		#Pattern analysis
		c=$i
		gsub("[[:digit:]]","9",c)
		gsub("[[:alpha:]]","Z",c)
		patterncount[i][c]++;
		
	}
	
}
END{
	OFS="|";
	print "Total Records "recordCounter;
	print "Field Length Analysis";
	print "Field","Minimum","Maximum","Average","Null Count"
	for(i=1;i <= NF; i++){
		print i,minsize[i],maxsize[i],totalsize[i]/recordCounter, nullcount[i];
	}
	
	for(i=1;i <= NF; i++){
		print "Field "i" Patterns"
		print "Count","Pattern"
		for(t in patterncount[i]){
			print patterncount[i][t],t
		}
	}
}