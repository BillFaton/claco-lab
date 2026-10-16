function [Yinf,Ymax,X1,Tpd,TR5,TR2,ytr5,ytr2,Ymin,c_Mu,c_TMu]=step_info_Yol_matlab(G,V);

% if V='' Informations are not displayed
% if V='v' Informations are displayed

% GL
% Etude des caracteristiques de reponses indicielles 

% G. Lebret : guy.lebret@ec-nantes.fr

n_pole_instable=find(real(pole(G))>=0);
if length(n_pole_instable)==0 % systèmes stables

  % valeur finale
  %      Yinf=dcgain(G);
  Yinf=dcgain(G);

  [Y,T]=step(tf(G));
  while abs(Yinf-Y(end))*100>1.0
    T=T*1.2;
   [Y,T]=step(tf(G),T);
  end
  Tend=T(end);  
 % Tend



  T=[0:Tend/1000:Tend];
  [Y,T]=step(tf(G),T);
  
   

  
  
% calcul du TR2%
%  idx_tr2=max(find( abs(Y/Yinf-1) > 0.02));
  if Yinf == 0
    idx_tr2=max(find( abs(Y) > 0.02));
%     Y(idx_tr2),T(idx_tr2),
  else
    idx_tr2=max(find( abs(Y/Yinf-1) > 0.02));
  end 
 
%%%  if length(T)==idx_tr2 || length(T)<=idx_tr2+3
%%%      while length(T)==idx_tr2 || length(T)<=idx_tr2+3
%%%      % disp('dedans')
%%%      [Y,T]=step(G,1.2*T( length(T) ));
%%%%          idx_tr2=max(find( abs(Y/Yinf-1) > 0.02));
%%%          if Yinf == 0
%%%            idx_tr2=max(find( abs(Y) > 0.02));
%%%          else
%%%            idx_tr2=max(find( abs(Y/Yinf-1) > 0.02));
%%%          end
%%%
%%%      end
%%%  end
  
%  % amelioration de la precision
%  dt1_tr2=T(idx_tr2)-T(idx_tr2-1);
%  dt2_tr2=T(idx_tr2+1)-T(idx_tr2);
%  dt_tr2=floor(log10((dt1_tr2+dt2_tr2)/2))-1;
%  dt_tr2=10^(dt_tr2);
%  T_tr2=[0:dt_tr2:T(idx_tr2+3)];
  
% amelioration de la precision
  
  dt_tr2=(-1/min(real(pole(G))))/3;
  dt_tr2=10^(floor(log10(dt_tr2)));
  
  %dt_tr5=floor(log10((dt1_tr5+dt2_tr5)/2))-1;
  %dt_tr5=10^(dt_tr5)
%  T_tr2_end=round(T(idx_tr2+3)/dt_tr2)*dt_tr2;
%  T_tr2=[0:dt_tr2:T_tr2_end];

  
%  [Y_tr2,T_tr2]=step(G,T_tr2);
  
  Y_tr2=Y;T_tr2=T;
  
%  c_tr2=T_tr2(max(find( abs(Y_tr2/Yinf-1) > 0.02)));
  if Yinf == 0
    c_tr2=T_tr2(max(find( abs(Y_tr2) > 0.02)));
    ytr2 =Y_tr2(max(find( abs(Y_tr2) > 0.02)));
  else
    c_tr2=T_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.02)));
    ytr2 =Y_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.02)));
  end
  
  % calcule du Temps de reponse a 5%
%  c_tr5=T_tr2(max(find( abs(Y_tr2/Yinf-1) > 0.05)));
  if Yinf == 0
    c_tr5=T_tr2(max(find( abs(Y_tr2) > 0.05)));
    ytr5 =Y_tr2(max(find( abs(Y_tr2) > 0.05)));
  else
     c_tr5=T_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.05)));
    ytr5 =Y_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.05)));
  end
  
  % X1 et tp
  [Ymax_n k_idx_n]=max(Y_tr2); % T_tr2(k_idx_n)
  [Ymin_n k_min_idx_n]=min(Y_tr2);
  if abs(Ymax_n-Yinf)>1e-8 & Ymax_n>Yinf
    if k_idx_n==length(Y_tr2) || length(T)<=k_idx_n+3
       while length(T)==k_idx_n || length(T)<=k_idx_n+3
          [Y,T]=step(G,1.2*T( length(T) ));
          [Ymax_n k_idx_n]=max(Y);
       end
       dt1_Ymax=T(k_idx_n)-T(k_idx_n-1);
       dt2_Ymax=T(k_idx_n+1)-T(k_idx_n);
       
       % amelioration de la precision
       dt_Ymax=floor(log10((dt1_Ymax+dt2_Ymax)/2))-1;
       dt_Ymax=10^(dt_Ymax);
       T=[0:dt_Ymax:T(k_idx_n+3)];
       
       [Y,T]=step(G,T);
       [Ymax_n k_idx_n]=max(Y);
       [Ymin_n k_min_idx_n]=min(Y);
       
       T_tr2=T;
    end
    c_Tp=T_tr2(k_idx_n);   
    if Yinf == 0
      c_X1 =(Ymax_n)*100;
    else
      c_X1 =((Ymax_n-Yinf)/Yinf)*100;
    end
  else
      c_Tp='';
      Ymax_n='';
      c_X1='';
  end

  c_TMu=T_tr2(k_min_idx_n);
  if Yinf == 0
    c_Mu =( abs(Ymin_n) )*100;
  else
    c_Mu =(abs(Ymin_n)/Yinf)*100;
  end
  
 
% overshoot = (Ymax-Yinf)/Yinf*100
% Undershoot = abs(Ymin)/Yinf*100
 
  Ymax=Ymax_n;
  Ymin=Ymin_n;
  TR5=c_tr5;
  TR2=c_tr2;
  Tpd=c_Tp;
  X1=c_X1;
  
  if exist('V')
      if V=='v'
        %  disp(' ')
          disp('Systeme stable (carateristiques de reponse indicielle en BO):');
          disp(sprintf('Valeur finale =%2.4g',Yinf));
          disp(sprintf('Ymax =%2.4g ',Ymax));
          if Ymax_n>=Yinf
            disp(sprintf('X1 =%2.2f (%%)',X1));
            disp(sprintf('tp =%2.4g (s)',Tpd));
          end
          disp(sprintf('Tsimu =%2.4g (s), yfinal =%2.4g',T(end),Y(end)));

          disp(sprintf('tr5%% =%2.4g (s), ytr5 = %2.4g, ytr5 = %2.4g',TR5,ytr5,Y_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.05)))))
          disp(sprintf('tr2%% =%2.4g (s), ytr2 = %2.4g, ytr2 = %2.4g',TR2,ytr2,Y_tr2(max(find( abs(Y_tr2/Yinf-1) >= 0.02)))));
          if c_Mu ~= 0
            disp(sprintf('Ymin =%2.4f (%%)',Ymin));
            disp(sprintf('Mu =%2.2f (%%)',c_Mu));
            disp(sprintf('t_Mu =%2.4g (s)',c_TMu));
          end
          disp(' ');
      end
  end

else % cas des systèmes instables
%  disp(' ');
  disp('Systeme instable');
  disp(' ');
  Yinf=[];Ymax=[];X1=[];Tpd=[];
  TR5=[];TR2=[];ytr5=[];ytr2=[];
  Ymin=[];c_Mu=[];c_TMu=[];
end

     
% [Yinf,Ec_S,Ymax,X1,TR5,TR2]


% overshoot = (Cu.Peak-dcgain(Hu))/dcgain(Hu)*100
% Undershoot = abs(Umin)/dcgain(Hu)*100