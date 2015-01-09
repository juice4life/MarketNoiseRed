function data=STanalysis(ticker,dip)
%This program performs short term analysis on 
%dips and spikes of a given option

period=60;
days=30;
%want to use minute by minute data (short term)
%and we want a month of data

price=getdat(period,days,ticker);
%Pricing data is saved to array price

spacings=SpacingData(price);
%Save spacing data


diprange=.01:.01:floor(var(spacings)*100)/100;
%We measure 

timedata=cell(1,length(diprange));

ind3=0;
for dip=diprange;
	ind3=ind3+1;
	for j=1:length(spacings)-1;
		ind2=0;
		if spacings(j+1)-spacings(j)>=dip;
			ind2=ind2+1;
			ind=j;
			while spacings(j)>spacings(j+1) && ind~=length(spacings);
				ind=j+1;
				tdiff=ind-j;
			end
			times(ind2)=tdiff;
		end
	end
	timedata{ind3}=times;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function stats=SpacingData(M)
%This function gets an array of the spacings between points 
%for a set of data

len=length(M)-1;

stats=zeros(1,len)

for j=1:len;
	stats(j)=M(j+1)-M(j);
end

end

