%This is a program to remove data from Google Finance sheet
%First copy sheet from internet and get rid of top lines
%Next replace all commas with spaces

function [M,Vol]=getdat(period,days,ticker)

%Subfunction that creates text file with stock data
pullfromfinance(period,days,ticker);

%This part of the code extracts 2nd column (contains current price)
fileID = fopen('data.txt','r');
formatSpec = '%f %f %f %f %f %f';
sizeA = [6 Inf];
A = fscanf(fileID,formatSpec,sizeA);
fclose(fileID);

M=A(2,:);
Vol=A(6,:);
delete('data.txt');
end

function pullfromfinance(period,days,ticker)

%Access information from Google Finance
str='http://www.google.com/finance/getprices?i=%d&p=%dd&f=d,o,h,l,c,v&df=cpct&q=%s\n';
url=sprintf(str,period,days,ticker);
html = urlread(url);
html = strrep(html,',',' ');
html = strrep(html,'a','');

%Record data to a file
fileID = fopen('data.txt','w');
fprintf(fileID,'%s',html);
fclose(fileID);

%This part of the code gets rid of unimportant lines at the beginning
fileID = fopen('data.txt','r+');
frewind(fileID);
for k=1:7;
    html=strrep(html,fgets(fileID),'');
end
fclose(fileID);

fileID = fopen('data.txt','w');
fprintf(fileID,'%s',html);
fclose(fileID);
end