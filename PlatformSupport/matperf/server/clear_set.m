function clear_set
if(exist('result.txt','file') == 2)
    system('rm result.txt');
end
if(exist('repnum.txt','file') ==2)
    system('rm repnum.txt');
end
if(exist('portadd.txt','file') ==2)
    system('rm portadd.txt');
end
if(exist ('rtmp.txt','file') ==2)
    system('rm rtmp.txt');
end
if(exist ('ptmp.txt','file') ==2)
    system('rm ptmp.txt');
end
if(exist ('dual_ptmp.txt','file') ==2)
    system('rm dual_ptmp.txt');
end
if(exist ('dual_rtmp.txt','file') ==2)
    system('rm dual_rtmp.txt');
end
if(exist ('dual_repnum.txt','file') ==2)
    system('rm dual_repnum.txt');
end
if(exist ('dual_portadd.txt','file') ==2)
    system('rm dual_portadd.txt');
end
if(exist ('tradeoff_portadd.txt','file') ==2)
    system('rm tradeoff_portadd.txt');
end
if(exist ('tradeoff_repnum.txt','file') ==2)
    system('rm tradeoff_repnum.txt');
end
if(exist ('tradeoff_repnum.txt','file') ==2)
    system('rm tradeoff_repnum.txt');
end
if(exist ('tradeoff_rtmp.txt','file') ==2)
    system('rm tradeoff_rtmp.txt');
end
if(exist ('tradeoff_ptmp.txt','file') ==2)
    system('rm tradeoff_ptmp.txt');
end
return