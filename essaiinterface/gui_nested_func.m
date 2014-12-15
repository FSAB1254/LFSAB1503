

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function gui_nested_func
 

% Initialisation de la variable représentant la valeur courante du compteur nCompteur à 0
nCompteur=0;

% Création de l'objet Figure
handles(1)=figure('units','pixels',...
    'position',[500 500 500 500],...
    'color',[0.925 0.913 0.687],...
    'numbertitle','off',...
    'name','[GUI] Utilisation des variables globales',...
    'menubar','none',...
    'tag','interface');

% Création du bouton "quantité de NH3 en sortie"
handles(5)= uicontrol ( 'style' , 'edit' ,'units','normalized', 'position', [0.1,0.3,0.3,0.05] , 'string' , 'Valeur A' );
% Création de l'objet Uicontrol Pushbutton -
handles(2)=uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.1 0.1 0.1 0.05],...
    'string','-',...    
    'callback',@retrancher,...
    'tag','bouton-');

% Création de l'objet Uicontrol Pushbutton +
handles(3)=uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.3 0.1 0.1 0.05],...
    'string','+',...    
    'callback',@ajouter,...
    'tag','bouton+');

% Création de l'objet Uicontrol Text résultat
handles(4)=uicontrol('style','text',...
    'units','normalized',...
    'position',[0.1 0.2 0.3 0.05],...
    'string','0',...
    'tag','resultat');

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%DEBUT DE LA FONCTION IMBRIQUEE RETRANCHER%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	function retrancher(obj,event)
	
	% Diminution de la valeur de nCompteur
	nCompteur=nCompteur-1;
     
	% Actualisation de la propriété String de l'objet Uicontrol Text résultat
	set(handles(4),'string',num2str(nCompteur));
	
        end

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%FIN DE LA FONCTION IMBRIQUEE RETRANCHER%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%DEBUT DE LA FONCTION IMBRIQUEE AJOUTER%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	function ajouter(obj,event)
	
	% Augmentation de la valeur de nCompteur
	nCompteur=nCompteur+1;
	
	% Actualisation de la propriété String de l'objet Uicontrol Text résultat
	set(handles(4),'string',num2str(nCompteur));
    str2num(get(handles(5),'string')) * 3
	
        end

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%FIN DE LA FONCTION IMBRIQUEE AJOUTER%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

