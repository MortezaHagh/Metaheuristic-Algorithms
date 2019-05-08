function [beta] = AdaptiveSelectionPressure(beta,P)

tempn=round(size(P,2)/2);
tempC=sum(P(1:tempn));

if tempC<0.8
    % beta=beta*1.05;
    beta = 10;
elseif tempC>0.90
    %beta=beta/1.05;
    beta = 2;
end

end