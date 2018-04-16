function Facular_Count

close all

DLat = 10;   %Bin size 
Lat  = [-90:DLat:90]; %Edges
%LatCnts = zeros(1,length(Lat)-1);
WdthTxt = 70;

Date  = [1887 1 1];
DateD = datenum(Date);

Date0 = DateD;
DateF = datenum([1937 12 31]);

MatCnts = [Date0:DateF]';

[Y, M, D] = datevec(MatCnts);
FrcYear = Y + (MatCnts-datenum(Y,1,1))./(datenum(Y+1,1,1)-datenum(Y,1,1));

MatCnts = [FrcYear MatCnts Y M D NaN(length(FrcYear),length(Lat)-1)];

CurrntDay = 1;




% Create a figure and axes
figure(1)
f = gcf;
set(f,'Position',[50 200 1550 500], 'Color','w');



copyfile Backup1.mat Backup2.mat
copyfile Backup0.mat Backup1.mat




%%%%%%%%%disenio de la interface grafica
% Create push buttons
for i=1:length(Lat)-1
    
    
    btns(i) = uicontrol('Style', 'pushbutton', 'String', ['(' num2str(Lat(i)) ',' num2str(Lat(i+1)) ')'],...
        'Position', [20+70*(i-1) 60 WdthTxt 20],...
        'Callback', @addcount,'ButtonDownFcn', @subcount);
    
    txts(i) = uicontrol('Style','text',...
            'Position',[20+70*(i-1) 80 WdthTxt 20],...
            'String',num2str(MatCnts(CurrntDay,i+5)));
    
end

%Clear Bottons

for i=1:length(Lat)-1
    clr(i) = uicontrol('Style', 'pushbutton', 'String', 'Zero',...
        'Position', [20+70*(i-1) 40 WdthTxt 20],...
        'Callback', @clearcount);
end

%Nan Bottons

for i=1:length(Lat)-1
    Na(i) = uicontrol('Style', 'pushbutton', 'String', 'NaN',...
        'Position', [20+70*(i-1) 20 WdthTxt 20],...
        'Callback', @NaNcount);
end

%Reset Botton

Rst = uicontrol ('Style','pushbutton','String',' NaN all',...
            'Position',[20 220 WdthTxt 20],...
            'Callback', @Reset);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RstZ = uicontrol ('Style','pushbutton','String',' Zero all',...
            'Position',[20 200 WdthTxt 20],...
            'Callback', @ResetZ);

%Textboxes

Dtui(1) = uicontrol('Style', 'edit', 'String', num2str(Date(1)),...
        'Position', [ ( (70*(length(Lat)-1)+20)/2 - WdthTxt ) 120 WdthTxt 20],...
        'Callback', @change_date,'ButtonDownFcn', @subcount);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
uicontrol('Style','text',...
            'Position',[ ( (70*(length(Lat)-1)+20)/2 - WdthTxt ) 140 WdthTxt 20],...
            'String','Year');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dtui(2) = uicontrol('Style', 'edit', 'String', num2str(Date(2)),...
        'Position', [ ( (70*(length(Lat)-1)+20)/2 ) 120 WdthTxt 20],...
        'Callback', @change_date,'ButtonDownFcn', @subcount);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol('Style','text',...
            'Position',[ ( (70*(length(Lat)-1)+20)/2 ) 140 WdthTxt 20],...
            'String','Month');        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
Dtui(3) = uicontrol('Style', 'edit', 'String', num2str(Date(3)),...
        'Position', [ ( (70*(length(Lat)-1)+20)/2 + WdthTxt ) 120 WdthTxt 20],...
        'Callback', @change_date,'ButtonDownFcn', @subcount);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uicontrol('Style','text',...
            'Position',[ ( (70*(length(Lat)-1)+20)/2 + WdthTxt ) 140 WdthTxt 20],...
            'String','Day');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
addD = uicontrol('Style', 'Pushbutton', 'String','>>',...
        'Position', [ ( (70*(length(Lat)-1)+20)/2 + 2*WdthTxt ) 120 WdthTxt 20],...
        'Callback',@addDay);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subD = uicontrol('Style', 'Pushbutton', 'String','<<',...
        'Position', [ ( (70*(length(Lat)-1)+20)/2 - 2*WdthTxt ) 120 WdthTxt 20],...
        'Callback',@subDay);
    
SaveasMat = uicontrol('Style','Pushbutton','String','SaveMat', ...
            'Position',[1200 200 WdthTxt 20],...
            'Callback', @SaveMat);
        
SaveasText = uicontrol('Style','Pushbutton','String','SaveText', ...
            'Position',[1200 220 WdthTxt 20],...
            'Callback' ,@SaveText);
LoadFile = uicontrol('Style','Pushbutton','String','LoadFile', ...
            'Position',[1200 180 WdthTxt 20],...
            'Callback' ,@LoadFiles);
Quit = uicontrol('Style','Pushbutton','String','Quit', ...
            'Position',[1200 160 WdthTxt 20],...
            'Callback' ,@Close_FC);  
        
        
        
        
        
        
        %%%%%%%%%%%%%% carga de archivos y propagacion de backups
        
load('Backup0.mat','MatCnts','CurrntDay')
set(Dtui(3),'String',num2str(MatCnts(CurrntDay,5))); 
set(Dtui(2),'String', num2str(MatCnts(CurrntDay,4)));
set(Dtui(1),'String' , num2str(MatCnts(CurrntDay,3)));
for i=1:length(Lat)-1
   set(txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
end










%%%%%%%Definicion de funciones
%%%%%%%%funcion de suma de faculas
   
    function addcount(source,event)
        idx = find(btns==source);
        if isnan(MatCnts(CurrntDay,idx+5))
            MatCnts(CurrntDay,idx+5) = 0;
        end
        MatCnts(CurrntDay,idx+5) = MatCnts(CurrntDay,idx+5) + 1;
        set(txts(idx),'String',num2str(MatCnts(CurrntDay,idx+5)));
    end
%%%%%%%%%%funcion de resta de faculas
    function subcount(source,event)
        idx = find(btns==source);
        if isnan(MatCnts(CurrntDay,idx+5))
            MatCnts(CurrntDay,idx+5) = 0;
        end
        MatCnts(CurrntDay,idx+5) = MatCnts(CurrntDay,idx+5) - 1;
        set(txts(idx),'String' , num2str(MatCnts(CurrntDay,idx+5)));
    end
%%%%%%%%%%%%funcion de ceros por latitud
    function clearcount(source,event)%,handle)
        idx = find(clr==source);
        MatCnts(CurrntDay,idx+5) = 0;
        set(txts(idx),'String' , num2str(MatCnts(CurrntDay,idx+5)));
       
    end
 %%%%%%%%%%funcion de nans por latitud
  function NaNcount(source,event)%,handle)
        idx = find(Na==source);
        MatCnts(CurrntDay,idx+5) = 0*Inf;
        set(txts(idx),'String', num2str(MatCnts(CurrntDay,idx+5)));
        
  end   
%%%%%%%%%%%%%funcion de nans para todas las latitudes

    function Reset(source,event)
        MatCnts(CurrntDay,6:23) = 0* Inf;
        for i=1:length(Lat)-1
           set( txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
        end
         
    end
%%%%%%%%%%%%%%funcion de ceros para todas las latitudes   
  function ResetZ(source,event)
        MatCnts(CurrntDay,6:23) = 0;
        for i=1:length(Lat)-1
            set(txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
        end
         
  end
%%%%%%%%%%%%%cambio de fechas 	
    function change_date(source,event)
        MatCnts(CurrntDay, isnan(MatCnts(CurrntDay,:)) ) = 0;
        idx = find(Dtui==source); 
        %%Cambios!!!!!!!!!!!!!!!!!!!!!!!!!!!
        SourceS=get(source,'String');
        Date(idx)=str2num(SourceS);
        CurrntDay = datenum(Date)-Date0 +1;
        if CurrntDay > 0
            for i=1:length(Lat)-1
             set(txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
            end
            set (Dtui(3),'String', num2str(MatCnts(CurrntDay,5)));
            set (Dtui(2),'String', num2str(MatCnts(CurrntDay,4)));
            set (Dtui(1),'String', num2str(MatCnts(CurrntDay,3)));
            
        else
            'Cannot go before 1887-01-01'
            CurrntDay = 1;            
           set( Dtui(3),'String', num2str(MatCnts(1,5)));
           set( Dtui(2),'String', num2str(MatCnts(1,4)));
           set( Dtui(1),'String', num2str(MatCnts(1,3)));
            
        end
        save('Backup0.mat','MatCnts','CurrntDay')
        
       
    end
%%%%%%%%%%%%%%funcion para avanzar un dia    
    function addDay(source,event)
        CurrntDay = CurrntDay +1;
        set (Dtui(3),'String', num2str(MatCnts(CurrntDay,5)));
        set (Dtui(2),'String', num2str(MatCnts(CurrntDay,4)));
        set (Dtui(1),'String', num2str(MatCnts(CurrntDay,3)));
   
        for i=1:length(Lat)-1
            set (txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
        end
       save('Backup0.mat','MatCnts','CurrntDay')
    end 
 %%%%%%%%%%%%%%funcion para devolverse un dia
  function subDay(source,event)
       if CurrntDay ~= 1 
          CurrntDay = CurrntDay-1  ; 
         set (Dtui(3),'String', num2str(MatCnts(CurrntDay,5)));
         set (Dtui(2),'String', num2str(MatCnts(CurrntDay,4)));
         set (Dtui(1),'String', num2str(MatCnts(CurrntDay,3)));
     
         for i=1:length(Lat)-1
            set( txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
         end   
       else
           'Cannot go beyond 1887-01-01'
       end
       save('Backup0.mat','MatCnts','CurrntDay')
  end
%%Save file as .mat
    function SaveMat(source,event)
        uisave({'MatCnts','CurrntDay'},'Backup0');
        h = msgbox('your data has been save in format .mat');
    end
%%Save file as .txt
    function SaveText(source,event)
        prompt={'Enter a name for the Txt file'};
        name = 'Saving Work';
        defaultans = {'Data.txt'};
        filename= inputdlg(prompt,name,[1 40],defaultans);
        save(filename{1},'MatCnts','CurrntDay','-ascii')
        h = msgbox('your data has been save in format .txt');
     end

%%Load mat file
    function LoadFiles(source,event)
        [FileName,PathName] = uigetfile('*.mat','Select a file to load data');
        h = msgbox('your file has been loaded');
        set (Dtui(3),'String', num2str(MatCnts(CurrntDay,5)));
        set (Dtui(2),'String', num2str(MatCnts(CurrntDay,4)));
        set (Dtui(1),'String', num2str(MatCnts(CurrntDay,3)));
    
        for i=1:length(Lat)-1
           set(  txts(i),'String' , num2str(MatCnts(CurrntDay,i+5)));
         end   
    end
%%Close 
    function Close_FC(source,event)
        uisave({'MatCnts','CurrntDay'},'Backup0'); 
        close(f);
    end

end