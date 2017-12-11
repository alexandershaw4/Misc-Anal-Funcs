function ascatter(k,p)
% Scatter function with x- and y-axes auto scaled to
% y/xlim([min([k p ]) max([k p ]))
%
% With x=y line & square axes
%
% AS


figure('Position',[875         248        1015         835]);
scatter((k),(p),70,'filled'); alpha .7
m = [ min([k(:);p(:)]) max([k(:);p(:)]) ];
xlim([m(1) m(2)]);ylim([m(1) m(2)]);
hold on; plot(m(1):m(2)/7:m(2),m(1):m(2)/7:m(2),'k');axis square

%xlabel('Ketamine','fontsize',20);
%ylabel('Placebo','fontsize',20);
set(findall(gcf,'-property','FontSize'),'FontSize',18)


%titl = sprintf('Superior Parietal\n Deep Pyamidal AMPA Channel Conductance');
%title(titl,'fontsize',20)