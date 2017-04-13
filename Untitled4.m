clc;
clear;

n=10;  %number of transactions

%read excel file to get data

[~,gender] = xlsread('Bit_Q.xlsx', 'B2:B11');
blood_sugar = xlsread('Bit_Q.xlsx', 'C2:C11')';
[~, blood_type] = xlsread('Bit_Q.xlsx', 'D2:D11');

data=cell(1,3);
data{1}=gender;
data{2}=blood_sugar;
data{3}=blood_type;

%find out the transactions where certain attributes occured
k_man=find(contains(gender,'Man'));
k_woman=find(contains(gender,'Woman'));
k_bs_low = find(blood_sugar<3.9);
k_bs_med = find(blood_sugar>=3.9 & blood_sugar<=6.1);
k_bs_high = find(blood_sugar>6.1);
k_bt_A=find(contains(blood_type,'A')&~contains(blood_type,'B'));
k_bt_B=find(contains(blood_type,'B')&~contains(blood_type,'A'));
k_bt_O=find(contains(blood_type,'O'));
k_bt_AB=find(contains(blood_type,'AB'));

Bs = cell(1,9);
%calculate the bitset of the attributes using the Bit_set funtion
bitset_man=Bit_set(k_man,n);
bitset_woman=Bit_set(k_woman,n);

bitset_bs_low=Bit_set(k_bs_low,n);
bitset_bs_med=Bit_set(k_bs_med,n);
bitset_bs_high=Bit_set(k_bs_high,n);

bitset_bt_A=Bit_set(k_bt_A,n);
bitset_bt_B=Bit_set(k_bt_B,n);
bitset_bt_O=Bit_set(k_bt_O,n);
bitset_bt_AB=Bit_set(k_bt_AB,n);

Bs = {bitset_woman; bitset_man; bitset_bs_low;bitset_bs_med;bitset_bs_high;bitset_bt_A;bitset_bt_B;bitset_bt_O;bitset_bt_AB};
Bb = {'0100000';'1000000';'0001000';'0010000';'0011000';'0000001';'0000010';'0000011';'0000100'};
%calculate the binary bits of the attribute

% Create Items Set
    count=2;
    % 1st Level Frequent Patterns
    
    for i=1:numel(Bs)
        Count(i)=OneCount(Bs{i});
    end
    m=1;
    for i=1:numel(Count)
        if Count(i)>=count
        L{1}{m} = Bs{i};  % generate 1 frequent bitset
        P{1}{m} = Bb{i};  % generate 1 frequent binary bits
        m=m+1;
        end
    end
   
 k=2;
 
 while ~isempty(L{k-1})
 for i=1:numel(L{k-1})
     for j=1:numel(L{k-1})
        %if ismember(L{k-1}{i},L{k-1}) 
         if L{1}{j}==L{1}{i}
           C{i}{j}='0000000000';
         else
             C{i}{j} =dec2bin(bitand(bin2dec(L{1}{j}),bin2dec(L{1}{i})),n);
         end
     end
        if OneCount(C{i}{j})>count
            L{k}{j}=C{i}{j};
        end
     
 end
 k=k+1;
end
 
 
    






