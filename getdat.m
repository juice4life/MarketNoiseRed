%This is a program to create an array containing price 
%and (optional) volume data over time intervals from a Google Finance sheet

function [M,Vol]=getdat(period,days,ticker)

%Subfunction that creates text file with stock data from Google Finance
pullfromfinance(period,days,ticker);

%This part of the code extracts desired columns of the txt file (contains current price)
fileID = fopen('data.txt','r');

%Create a 6 column array A which contains all data from the txt file
formatSpec = '%f %f %f %f %f %f';
sizeA = [6 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

%Use array splicing to extract only the 2nd column of A (the price) and the 6th (the volume)
M=A(2,:);
Vol=A(6,:);
delete('data.txt');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function pullfromfinance(period,days,ticker)

%Access information from Google Finance
str='http://www.google.com/finance/getprices?i=%d&p=%dd&f=d,o,h,l,c,v&df=cpct&q=%s\n';
url=sprintf(str,period,days,ticker);
html = urlread(url);

%replace all commas with spaces and get rid of non numbers
html = strrep(html,',',' ');
html = strrep(html,'a','');

%Create new file print data from html to it
fileID = fopen('data.txt','w');
fprintf(fileID,'%s',html);
fclose(fileID);


%The next part of the code gets rid of unimportant lines at the beginning of the txt file
fileID = fopen('data.txt','r+');

%Go to the first line of the text file
frewind(fileID);

%Delete the first 7 columns of html (replace each string with nothing)
for k=1:7;
    html=strrep(html,fgets(fileID),'');
end
fclose(fileID);


%Write reformated html data to txt file
fileID = fopen('data.txt','w');
fprintf(fileID,'%s',html);
fclose(fileID);
end


