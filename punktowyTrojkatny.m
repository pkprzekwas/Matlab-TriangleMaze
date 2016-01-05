clear;
clc;
dim = 39;
level = 1;
% punkt startowy
x = [];
y = [];

% generowanie punktów
for k = linspace(0,dim-1,dim)
    for m = linspace(0,dim-1-k,dim-k)
        x = [x 2*m+k];
        y = [y k];
    end     
end
%plot(x,y,'*')
hold on
points = [x;y];
points = points';

poz = points(1,:);
stos = [];
odwiedzone = [];
% dodanie pozycji poczatkowej na stos
stos = [poz];
poz = [0 0];
odwiedzone;

droga = [poz];
rozw = [];

%cel = [dim-1,dim-1]
cel = [16,0]

while ~isempty(stos)
    rozwi = false;
    % ruchy mo¿liwe do wykonania
    lf = false;
    lfup = false;
    rgup = false;
    rg = false;
    rgdn = false;
    lfdn = false;
    
    if (find(ismember(points,[poz(1)-2,poz(2)],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)-2,poz(2)],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-2,poz(2)],'rows'),1))
            else
                lf = true;
                %'lewo'
            end
        end
    end
    if (find(ismember(points,[poz(1)+2,poz(2)],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)+2,poz(2)],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)+2,poz(2)],'rows'),1))
            else
                rg = true;
                %'prawo'
            end
        end
    end
    if (find(ismember(points,[poz(1)-1,poz(2)+1],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)+1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)+1],'rows'),1))
            else
                lfup = true;
                %'lewy gorny'
            end
        end
    end
    if (find(ismember(points,[poz(1)+1,poz(2)+1],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)+1,poz(2)+1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)+1,poz(2)+1],'rows'),1))
            else
                    rgup = true;
                    %'prawy gorny'
            end
        end
    end
    if (find(ismember(points,[poz(1)-1,poz(2)-1],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)-1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)-1],'rows'),1))
            else
                lfdn = true;
                %'lewy dolny'
            end
        end
    end
    if (find(ismember(points,[poz(1)-1,poz(2)-1],'rows'),1))
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)-1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)-1],'rows'),1))
            else
                rgdn = true;
                %'prawy dolny'
            end
        end
    end
    
    if(~lf && ~rg && ~lfdn && ~rgdn && ~lfup && ~rgup)
        %'brak ruchow'
        odwiedzone = [odwiedzone; poz];
        if (size(stos,1)>1)
            poz = stos(size(stos,1)-1,:);
        end
        stos(size(stos,1),:)=[];
    else
   % Jeœli jest mo¿liwoœæ to podejmujemy jeden z mo¿liwych ruchów
       decision = 0;
       while(~decision)
           move = rand();
           decision = 1;
           if(move<=0.1667 && lf)
               poz = [poz(1)-2,poz(2)];
               
           elseif(move<=0.3333 && rg)
               poz = [poz(1)+2,poz(2)];
               
           elseif(move<=0.5 && lfup)
               poz = [poz(1)-1,poz(2)+1];
               
           elseif(move<=6667 && rgup)
               poz = [poz(1)+1,poz(2)+1];
               
           elseif(move<=8333 && lfdn)
               poz = [poz(1)-1,poz(2)-1];
               
           elseif(move<=1 && rgdn)
               poz = [poz(1)-1,poz(2)-1];
           else
               decision = 0;
           end
       end
       % wrzucamy na stos wykonany ruch
       stos = [stos; poz];
    end
    droga = [droga;poz];
    if (poz == cel)
        if ~rozwi
            rozw = stos;
            rozwi = true;
        end
    end
end
droga
plot(droga(:,1),droga(:,2),'LineWidth',8);

axis equal off;

odwiedzone = [];
% dodanie pozycji poczatkowej na stos
poz = [0 0];
stos = [poz];
iter = 1;
while ~isempty(stos)
    iter = iter +1;
    rozwi = false;
    % ruchy mo¿liwe do wykonania
    lf = false;
    lfup = false;
    rgup = false;
    rg = false;
    rgdn = false;
    lfdn = false;
    
    if (droga(iter,:) == [poz(1)-2,poz(2)])
        if (find(ismember(odwiedzone,[poz(1)-2,poz(2)],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-2,poz(2)],'rows'),1))
            else
                lf = true;
                %'lewo'
            end
        end
    end
    if (droga(iter,:) == [poz(1)+2,poz(2)])
        if (find(ismember(odwiedzone,[poz(1)+2,poz(2)],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)+2,poz(2)],'rows'),1))
            else
                rg = true;
                %'prawo'
            end
        end
    end
    if (droga(iter,:) == [poz(1)-1,poz(2)+1])
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)+1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)+1],'rows'),1))
            else
                lfup = true;
                %'lewy gorny'
            end
        end
    end
    if (droga(iter,:) == [poz(1)+1,poz(2)+1])
        if (find(ismember(odwiedzone,[poz(1)+1,poz(2)+1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)+1,poz(2)+1],'rows'),1))
            else
                    rgup = true;
                    %'prawy gorny'
            end
        end
    end
    if (droga(iter,:) == [poz(1)-1,poz(2)-1])
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)-1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)-1],'rows'),1))
            else
                lfdn = true;
                %'lewy dolny'
            end
        end
    end
    if (droga(iter,:) == [poz(1)-1,poz(2)-1])
        if (find(ismember(odwiedzone,[poz(1)-1,poz(2)-1],'rows'),1))
        else
            if (find(ismember(stos,[poz(1)-1,poz(2)-1],'rows'),1))
            else
                rgdn = true;
                %'prawy dolny'
            end
        end
    end
    
    if(~lf && ~rg && ~lfdn && ~rgdn && ~lfup && ~rgup)
        %'brak ruchow'
        odwiedzone = [odwiedzone; poz];
        if (size(stos,1)>1)
            poz = stos(size(stos,1)-1,:);
        end
        stos(size(stos,1),:)=[];
    else
   % Jeœli jest mo¿liwoœæ to podejmujemy jeden z mo¿liwych ruchów
       decision = 0;
       while(~decision)
           decision = 1;
           if(lf)
               poz = [poz(1)-2,poz(2)];
               
           elseif(rg)
               poz = [poz(1)+2,poz(2)];
               
           elseif(lfup)
               poz = [poz(1)-1,poz(2)+1];
               
           elseif(rgup)
               poz = [poz(1)+1,poz(2)+1];
               
           elseif(lfdn)
               poz = [poz(1)-1,poz(2)-1];
               
           elseif(rgdn)
               poz = [poz(1)-1,poz(2)-1];
           else
               decision = 0;
           end
       end
       % wrzucamy na stos wykonany ruch
       stos = [stos; poz];
    end
    if (poz == cel)
            rozw = stos;
            stos = [];
    end
end

plot(rozw(:,1),rozw(:,2),'red','LineWidth',3);

plot(rozw(:,1),rozw(:,2),'green','LineWidth',2);
