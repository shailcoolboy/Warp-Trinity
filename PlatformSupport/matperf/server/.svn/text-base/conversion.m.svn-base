function t1 = conversion(type, t1,repnum)

m = size(repnum);
byte = 'Bytes';
kbyte = 'KBytes';
mbyte = 'MBytes';
gbyte = 'GBytes';
bit = 'bits';
kbit = 'Kbits';
mbit = 'Mbits';
gbit = 'Gbits';

if(strcmp(kbyte,repnum) == 1)
    if(strcmp(type,'Bytes'))
        t1 = t1*1024;
        
    elseif(strcmp(type,'MBytes'))
        t1 = t1/1024;
    
    elseif(strcmp(type,'GBytes'))
        t1 = t1/(1024*1024);
    end

elseif(strcmp(mbyte,repnum) == 1)
    if(strcmp(type,'Bytes'))
        t1 = t1*1024*1024;
    
    elseif(strcmp(type,'GBytes'))
        t1 = t1/1024;
    
    elseif(strcmp(type, 'KBytes'))
        t1 = t1*1024;
    end

elseif(strcmp(gbyte,repnum))
    if(strcmp(type,'Bytes'))
        t1 = t1*1024*1024*1024*1024;
    
    elseif(strcmp(type,'MBytes'))
        t1 = t1*1024*1024*1024;
    
    elseif(strcmp(type, 'KBytes'))
        t1 = t1*1024*1024;
    end

elseif(strcmp(byte,repnum))
    if(strcmp(type,'KBytes'))
        t1 = t1/1024;
    
    elseif(strcmp(type,'MBytes'))
        t1 = t1/(1024^2);
    
    elseif(strcmp(type, 'GBtes'))
        t1 = t1/(1024*1024*1024);
    end

%%% from here bits to KMGbits
elseif(strcmp(bit,repnum))
    if(strcmp(type ,'Kbits'))
        t1 = t1/1024;    
    elseif(strcmp(type, 'Mbits'))
        t1 = t1/(1024*1024);    
    elseif(strcmp(type, 'Gits'))
        t1 = t1/(1024*1024*1024);
    end
elseif(strcmp(kbit,repnum))
    if(strcmp(type, 'bits'))
        t1 = t1 * 1024;
    elseif(strcmp(type, 'Mbits'))
        t1 = t1/1024;
    elseif(strcmp(type, 'Gbits'))
        t1= t1/(1024*1024);
    end
elseif(strcmp(mbit,repnum))
    if(strcmp(type,'bits'))
        t1 = t1*1024*1024;
    elseif(strcmp(type,'Kbits'))
        t1 = t1*1024;
    elseif(strcmp(type,'Gbits'))
        t1 = t1/1024;
    end
elseif(strcmp(gbit,repnum))
    if(strcmp(type,'bits'))
        t1 = t1*1024*1024*1024;
    elseif(strcmp(type, 'Kbits'))
        t1 = t1*1024*1024;
    elseif(strcmp(type, 'Mbits'))
        t1 = t1*1024;
    end
end
return
