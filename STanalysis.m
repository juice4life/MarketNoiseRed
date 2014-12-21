function data=STanalysis(ticker,dip)
%This program performs short term analysis on 
%dips and spikes of a given stock

period=60;
days=30;
%want to use minute by minute data (short term)
%and we want a month of data

price=getdat(period,days,ticker);
%Pricing data is saved to array price

spacings=SpacingData(price);
%Save spacing data

sigma=var(spacings);
mu=mean(spacings);
%Collect spacing statistics

for j=1:length(spacings)-1;
	if spacings(j+1)-spacings(j)>=dip;
		while k==0;
			;
			;
			;
		end
	end
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

