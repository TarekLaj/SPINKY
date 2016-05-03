function[ optimal_thresh]=ROC_curve(fdr,se,seuil,showplot)
mm=se-fdr;
optimal_thresh=seuil(mm==max(mm));
optimal_thresh=optimal_thresh(1);
if strcmp(showplot,'On')
figure;
plot(fdr,se,'r.-');
xlabel('False detection Rate (%) ');ylabel('Sensitivity (%) ');
hold on; 
plot([0;100],[0 100]);
%grid on;
hold off;
%%
 
figure;plot(seuil,mm); xlabel('Threshold (MicroVolt)');ylabel('Sensitivity-FDR (%)');


% SS=-103;
hold on 
plot([optimal_thresh(1),optimal_thresh(1)],[0,max(mm)+0.05],'r--');
hold off;
end





