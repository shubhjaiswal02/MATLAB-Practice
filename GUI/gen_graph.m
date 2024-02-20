filename = 'book1.xlsx';
data = readtable(filename);

% Convert the table to a matrix
may = table2array(data(:, 1:2)); % Assuming the data you want to read is in the first two columns

T=may(:,1);
I=may(:,2);

figure(1)
plot(T,I);