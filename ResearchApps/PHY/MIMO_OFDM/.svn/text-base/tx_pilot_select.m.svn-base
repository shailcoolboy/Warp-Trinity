function [o_zero, o_pilotVal1, o_pilotVal2, o_nonPilot] = tx_pilot_select(neg, antSel, sc0, ind0, ind1, ind2, ind3, alamoutiMode)
if (sc0) %DC subcarrier; force zeros
    o_zero = 1;
    o_nonPilot = 0;
    o_pilotVal1 = 0;
    o_pilotVal2 = 0;
elseif (~(ind0 | ind1 | ind2 | ind3)) %Non-pilot, non-zero subcarrier
    o_zero = 0;
    o_nonPilot = 1;
    o_pilotVal1 = 0;
    o_pilotVal2 = 0;
elseif (alamoutiMode) %Non-zero, pilot subcarrier, Alamouti mode
    if(~antSel) %Even symbol
        if(ind2 | ind3)
            o_zero = 1;
            o_nonPilot = 0;
            o_pilotVal1 = 0;
            o_pilotVal2 = 0;
        elseif(ind0 | ind1)
            if(~neg) %Non-negate symbol
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 1;
                o_pilotVal2 = 0;
            else %Negate
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 0;
                o_pilotVal2 = 1;
            end
        else %impossible
            o_zero = 0;
            o_nonPilot = 1;
            o_pilotVal1 = 0;
            o_pilotVal2 = 0;
        end
    else % antSel == 1 Odd symbol
        if(ind0 | ind1)
            o_zero = 1;
            o_nonPilot = 0;
            o_pilotVal1 = 0;
            o_pilotVal2 = 0;
        elseif(ind2)
            if(~neg) %Non-negate symbol
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 1;
                o_pilotVal2 = 0;
            else %Negate
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 0;
                o_pilotVal2 = 1;
            end
        elseif(ind3)
            if(~neg) %Non-negate symbol
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 0;
                o_pilotVal2 = 1;
            else %Negate
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 1;
                o_pilotVal2 = 0;
            end
        else %impossible
            o_zero = 0;
            o_nonPilot = 1;
            o_pilotVal1 = 0;
            o_pilotVal2 = 0;
        end
    end
elseif (~alamoutiMode) %Non-zero, pilot subcarrier, SISO/multiplexing mode
    if(antSel) %Odd symbol
        o_zero = 1;
        o_nonPilot = 0;
        o_pilotVal1 = 0;
        o_pilotVal2 = 0;
    else %Even symbol
        if(~neg)
            if(ind0 | ind1 | ind2)
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 1;
                o_pilotVal2 = 0;
            elseif(ind3)
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 0;
                o_pilotVal2 = 1;
            else %impossible
                o_zero = 0;
                o_nonPilot = 1;
                o_pilotVal1 = 0;
                o_pilotVal2 = 0;
            end
        else %neg == 1
            if(ind0 | ind1 | ind2)
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 0;
                o_pilotVal2 = 1;
            elseif(ind3)
                o_zero = 0;
                o_nonPilot = 0;
                o_pilotVal1 = 1;
                o_pilotVal2 = 0;
            else %impossible
                o_zero = 0;
                o_nonPilot = 1;
                o_pilotVal1 = 0;
                o_pilotVal2 = 0;
            end
        end
    end
else %impossible
    o_zero = 0;
    o_nonPilot = 1;
    o_pilotVal1 = 0;
    o_pilotVal2 = 0;
end
