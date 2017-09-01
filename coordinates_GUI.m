

function ROI_traces_GUI(ROI,C_df, ROI_sh, color)

ses=size(C_df,2);
nb=size(C_df{ses},2);
for i=1:length(ROI)
Cn_all(:,:,i)=ROI{i}.Cn_max;
Cn_mean=mean(Cn_all,3);
leg{i}=['session ' num2str(i)];
end
warning('off','all')
warning

%Create slider
sld = uicontrol('Style', 'slider',...
        'Min',1,'Max',nb,'Value',1,...
        'Position', [4 20 120 20],...
        'Callback', @ROI_dF); 

% Add a text uicontrol to label the slider.
txt = uicontrol('Style','text',...
        'Position',[4 45 120 20],...
        'String','ROI ');
        

    % Make figure visble after adding all components
f.Visible = 'on';
plot_component(1)
    % This code uses dot notation to set properties. 
    % Dot notation runs in R2014b and later.
    % For R2014a and earlier: set(f,'Visible','on');

        
 function ROI_dF(source,callbackdata)
r = source.Value;
plot_component(round(r))  
 end
    
function plot_component(r) 
    for i=1:length(ROI)
Cn_all(:,:,i)=ROI{i}.Cn_max;
Cn_mean=mean(Cn_all,3);
    end
subplot(1,2,1)
imshow(Cn_mean);
hold on
for i=1:length(ROI)
ROI_temp=ROI_sh{i};
[B{r},L{r}] = bwboundaries(ROI_temp(:,:,r));
for k = 1:length(B{r})
%boundary = B{r}{k};  
plot(B{r}{k}(:,2), B{r}{k}(:,1), color{i}, 'LineWidth', 1)
coodonates{r}=B{r}{1};
end
end

for i=1:length(ROI)
    hold on

%subplot(length(ROI),1,i);
subplot(1,2,2)
plot(C_df{i}(:,r),color{i},'linewidth',2);
title(sprintf(['ROI ' num2str(r)] ),'fontsize',16,'fontweight','bold');
legend(leg)
end
hold off;




end
end

