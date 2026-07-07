function kTi =  invT(iTk)
    iRk = iTk(1:3,1:3)  ;
    kRi = iRk.'; 
    
    kTi = [kRi          -kRi*iOk
         zeros(length(kRi)) 1];
end 