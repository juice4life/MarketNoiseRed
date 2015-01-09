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

for dip=diprange;
	for j=1:length(spacings)-1;
		if spacings(j+1)-spacings(j)>=dip && ;
			k=0;
			ind=j+2;
			while k==0;
				if spacings(ind)>= spacings(j);
					t=ind-j;
					k=1;
				elseif ind==length(spacings);
					k=1;
				else
					ind=ind+1;
				end
			end
		end
	end
	timedata
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

