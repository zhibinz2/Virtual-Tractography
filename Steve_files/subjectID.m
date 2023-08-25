function ID = subjectID;
% ID = subjecID
% Generates random subject ID 


SET = char(['A':'Z']);
NSET = length(SET);
N = 4;
i = ceil(NSET*rand(1,N));

seq = SET(i);                               % random character sequence
SF = floor(100*rand(1));                    % random ## suffix

if SF < 10
    ID = strcat(seq,'0',num2str(SF));
else
    ID = strcat(seq,num2str(SF));            % new subject ID
end

end

